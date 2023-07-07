import 'dart:async';

import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:nha_gia_re/data/models/notification.dart';
import 'package:nha_gia_re/data/repositories/notification_repository.dart';
import 'package:nha_gia_re/data/repositories/user_repository.dart';

class NotificationController extends GetxController {
  NotificationRepository notiRepo = GetIt.instance<NotificationRepository>();
    late StreamSubscription<List<NotificationModel>> streamSubscription;
  final StreamController<List<NotificationModel>> _controller = StreamController();

  Stream<List<NotificationModel>> get stream => _controller.stream;
  List<NotificationModel> notifications = [];

  @override
  void onClose() {
    streamSubscription.cancel();
    _controller.close();
    super.onClose();
  }

  void init()  {
        streamSubscription =
        notiRepo.getNotification().listen((event) {
      _controller.sink.add(event);
    });
  }
}
