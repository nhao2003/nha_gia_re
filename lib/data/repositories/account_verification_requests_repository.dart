import 'package:nha_gia_re/data/providers/remote/remote_data_source.dart';
import 'package:nha_gia_re/data/providers/remote/response/account_verification_requests.dart';

import '../providers/remote/request/account_verification_requests.dart';

class AccountVerificationRepository {
  final RemoteDataSource _remoteDataSource;
  AccountVerificationRepository(this._remoteDataSource);
  String checkResult = "";
  Future<void> createNewRequest(AccountVerificationRequests request) async {
    await _remoteDataSource.sendAccountVerificationRequest(request);
  }

  Future<List<AccountVerificationResponse>> getNewRequests() async {
    final data = await _remoteDataSource.getNewAccountVerificationRequest();
    return data.map((e) => AccountVerificationResponse.fromJson(e)).toList();
  }

  Future<List<AccountVerificationResponse>> getVerifiedRequests() async {
    final data = await _remoteDataSource.getOldAccountVerificationRequest();
    return data.map((e) => AccountVerificationResponse.fromJson(e)).toList();
  }

  Future<List<AccountVerificationResponse>> getUserRequests() async {
    final data = await _remoteDataSource.getUserAccountVerificationRequest();
    return data.map((e) => AccountVerificationResponse.fromJson(e)).toList();
  }

  Future<void> acceptAcountVerifiedRequest(String id) async {
    await _remoteDataSource.acceptAcountVerifiedRequest(id);
  }

  Future<void> rejectAcountVerifiedRequest(String id, String reason) async {
    await _remoteDataSource.rejectAcountVerifiedRequest(id, reason);
  }

  Future<String> checkUserIsWaiting() async {
    // 0: la chua co
    // 1: la dang duyet
    // 2: la duyet duoc roi
    // chuoi ly do: la duyet tu choi
    List<AccountVerificationResponse> requests = await getUserRequests();
    if (requests.isEmpty) {
      //chua co
      return "0";
    } else {
      final req = requests.first;
      if (req.reviewedAt == null) {
        return "1";
      } else {
        if (req.isVerified == true) {
          return "2";
        } else {
          return req.rejectedInfo!;
        }
      }
    }
  }
}
