import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../../data/providers/remote/response/account_verification_requests.dart';
import '../../data/repositories/account_verification_requests_repository.dart';

class AdminVerificationController extends GetxController {
  AccountVerificationRepository accountRepo =
      GetIt.instance<AccountVerificationRepository>();
  String rejectInfo = "";
  bool isExecute = false;
  Future<List<AccountVerificationResponse>> getListRequest() async {
    return await accountRepo.getNewRequests();
  }

  Future<List<AccountVerificationResponse>> getListVerifieds() async {
    return await accountRepo.getVerifiedRequests();
  }

  approveRequest(String idRequest) async {
    try {
      await accountRepo.acceptAcountVerifiedRequest(idRequest);
      Get.snackbar("Trạng thái", "Tài khoản đã được chấp nhận");
    } catch (e) {
      Get.snackbar("Trạng thái", "Đã có lỗi xảy ra");
      e.printError();
    }
    isExecute = false;
  }

  rejectRequest(String idRequest) async {
    try {
      if (rejectInfo.trim().isNotEmpty) {
        await accountRepo.rejectAcountVerifiedRequest(idRequest, rejectInfo);
        Get.snackbar("Trạng thái", "Đã từ chối yêu cầu");
      } else {
        Get.snackbar("Trạng thái", "Vui lòng thêm lý do từ chối");
      }
    } catch (e) {
      Get.snackbar("Trạng thái", "Đã có lỗi xảy ra");
      e.printError();
    }
    isExecute = false;
  }
}
