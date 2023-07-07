import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../../data/providers/remote/response/account_verification_requests.dart';
import '../../data/repositories/account_verification_requests_repository.dart';

class AdminVerificationController extends GetxController {
  AccountVerificationRepository accountRepo =
      GetIt.instance<AccountVerificationRepository>();

  Future<List<AccountVerificationResponse>> getListRequest() async {
    return await accountRepo.getNewRequests();
  }
}
