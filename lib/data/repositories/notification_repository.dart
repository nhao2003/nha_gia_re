import 'package:get/get.dart';
import 'package:nha_gia_re/data/enums/enums.dart';
import 'package:nha_gia_re/data/models/notification.dart';
import 'package:nha_gia_re/data/providers/remote/remote_data_source.dart';

class NotificationRepository {
  final RemoteDataSource _remoteDataSource;
  NotificationRepository(this._remoteDataSource);

  Stream<int> getUnreadNotificationCount() {
    return _remoteDataSource.getNotification().map((list) {
      return list.where((notification) => !notification.isRead).length;
    });
  }

  Stream<List<NotificationModel>> getNotification() {
    return _remoteDataSource.getNotification();
  }

  Future<void> setIsReadNotification(String id) async {
    await _remoteDataSource.setIsReadNotification(id);
    //getLengthNotificationsIsNotRead();
    return;
  }

  Future<void> deleteNotification(String id) async {
    await _remoteDataSource.deleteNotification(id);
  }

  RxInt numNotificationsIsNotRead = 0.obs;

  RxList<NotificationModel> listNotifications = [
    NotificationModel(
      id: "1",
      type: NotificationType.suggest,
      isRead: false,
      createAt: DateTime.now(),
      title: "Trọ Quận Tân Bình",
      content: "449/58 Trường Chinh P14 Tân Bình HCM",
      image:
          "https://www.bhg.com/thmb/H9VV9JNnKl-H1faFXnPlQfNprYw=/1799x0/filters:no_upscale():strip_icc()/white-modern-house-curved-patio-archway-c0a4a3b3-aa51b24d14d0464ea15d36e05aa85ac9.jpg",
    ),
    NotificationModel(
      id: "2",
      type: NotificationType.expirationWarning,
      isRead: false,
      createAt: DateTime.now(),
      title: "Trọ Quận Tân Bình",
      content: "449/58 Trường Chinh P14 Tân Bình HCM",
      image:
          "https://pt123.cdn.static123.com/images/thumbs/900x600/fit/2023/03/25/phong-tro-tphcm_1679716618.jpg",
    ),
    NotificationModel(
      id: "3",
      type: NotificationType.rejectPost,
      isRead: false,
      createAt: DateTime.now(),
      title: "Trọ Quận Tân Bình",
      content: "449/58 Trường Chinh P14 Tân Bình HCM",
      image:
          "https://pt123.cdn.static123.com/images/thumbs/900x600/fit/2021/11/16/cho-thue-phong-tro-1613975723_1637034014.jpg",
    ),
    NotificationModel(
      id: "4",
      type: NotificationType.acceptPost,
      isRead: false,
      createAt: DateTime.now(),
      title: "Trọ Quận Tân Bình",
      content: "449/58 Trường Chinh P14 Tân Bình HCM",
      image: "https://www.studytienganh.vn/upload/2021/06/106951.jpg",
    ),
    NotificationModel(
      id: "5",
      type: NotificationType.advertise,
      isRead: false,
      createAt: DateTime.now(),
      title: "Trọ Quận Tân Bình",
      content: "449/58 Trường Chinh P14 Tân Bình HCM",
      image:
          "https://dichvuchuyendo.net/wp-content/uploads/2020/10/phong-tro.jpg",
    ),
  ].obs;
}
