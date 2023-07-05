import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import '../../data/repositories/notification_repository.dart';

class NotificationController extends GetxController {
  NotificationRepository notiRepo = GetIt.instance<NotificationRepository>();
}
