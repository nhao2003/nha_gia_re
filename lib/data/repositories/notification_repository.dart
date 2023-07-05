import 'package:get/get.dart';
import 'package:nha_gia_re/data/enums/enums.dart';
import 'package:nha_gia_re/data/models/notification_model.dart';

class NotificationRepository {
  List getNotifications() {
    return [...listNotifications];
  }

  int getLengthNotifications() {
    if (listNotifications.isEmpty) {
      return listNotifications.length;
    } else {
      return 0;
    }
  }

  void setNotifications(List<NotificationModel> notis) {
    listNotifications = [...notis].obs;
  }

  List fetchNotification() {
    // _listNotifications = ...;
    return listNotifications;
  }

  RxList<NotificationModel> listNotifications = [
    NotificationModel(
      id: "1",
      type: NotificationType.suggest,
      isRead: false,
      createAt: DateTime.now(),
      title: "Trọ Quận Tân Bình",
      content: "449/58 Trường Chinh P14 Tân Bình HCM",
      image:
          "https://globalcastingresources.com/wp-content/uploads/2022/10/1664482232_How-much-does-the-anime-streaming-service-cost.jpg",
    ),
    NotificationModel(
      id: "1",
      type: NotificationType.expirationWarning,
      isRead: false,
      createAt: DateTime.now(),
      title: "Trọ Quận Tân Bình",
      content: "449/58 Trường Chinh P14 Tân Bình HCM",
      image:
          "https://globalcastingresources.com/wp-content/uploads/2022/10/1664482232_How-much-does-the-anime-streaming-service-cost.jpg",
    ),
    NotificationModel(
      id: "1",
      type: NotificationType.rejectPost,
      isRead: false,
      createAt: DateTime.now(),
      title: "Trọ Quận Tân Bình",
      content: "449/58 Trường Chinh P14 Tân Bình HCM",
      image:
          "https://globalcastingresources.com/wp-content/uploads/2022/10/1664482232_How-much-does-the-anime-streaming-service-cost.jpg",
    ),
    NotificationModel(
      id: "1",
      type: NotificationType.acceptPost,
      isRead: false,
      createAt: DateTime.now(),
      title: "Trọ Quận Tân Bình",
      content: "449/58 Trường Chinh P14 Tân Bình HCM",
      image:
          "https://globalcastingresources.com/wp-content/uploads/2022/10/1664482232_How-much-does-the-anime-streaming-service-cost.jpg",
    ),
    NotificationModel(
      id: "1",
      type: NotificationType.advertise,
      isRead: false,
      createAt: DateTime.now(),
      title: "Trọ Quận Tân Bình",
      content: "449/58 Trường Chinh P14 Tân Bình HCM",
      image:
          "https://globalcastingresources.com/wp-content/uploads/2022/10/1664482232_How-much-does-the-anime-streaming-service-cost.jpg",
    ),
  ].obs;
}
