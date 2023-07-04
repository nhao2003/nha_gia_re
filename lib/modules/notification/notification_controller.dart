import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:nha_gia_re/data/models/notification.dart';
import 'package:nha_gia_re/data/repositories/user_repository.dart';

class NotificationController extends GetxController {
  UserRepository userRepository = GetIt.instance<UserRepository>();
  List<NotificationModel> notifications = [];
  Future<void> init()
  async {
    notifications = await userRepository.getNotification();
  }
}
