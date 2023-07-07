import 'package:nha_gia_re/data/providers/remote/remote_data_source.dart';
import 'package:nha_gia_re/data/providers/remote/response/account_verification_requests.dart';

import '../providers/remote/request/account_verification_requests.dart';

class AccountVerificationRepository {
  final RemoteDataSource _remoteDataSource;
  AccountVerificationRepository(this._remoteDataSource);

  Future<void> createNewRequest(AccountVerificationRequests request) async {
    await _remoteDataSource.sendAccountVerificationRequest(request);
  }

  Future<List<AccountVerificationResponse>> getNewRequests() async {
    final data = await _remoteDataSource.getAccountVerificationRequest();
    return data.map((e) => AccountVerificationResponse.fromJson(e)).toList();
  }
}
