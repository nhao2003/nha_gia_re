import 'package:get_it/get_it.dart';
import 'package:nha_gia_re/data/providers/remote/remote_data_source.dart';
import 'package:nha_gia_re/data/repositories/admin_reposotory.dart';
import 'package:nha_gia_re/data/repositories/auth_repository.dart';
import 'package:nha_gia_re/data/repositories/chat_repository.dart';
import 'package:nha_gia_re/data/repositories/notification_repository.dart';
import 'package:nha_gia_re/data/repositories/post_repository.dart';
import 'package:nha_gia_re/data/repositories/settings_repository.dart';
import 'package:nha_gia_re/data/repositories/user_repository.dart';

Future<void> initAppModule() async {
  RemoteDataSource remoteDataSource = RemoteDataSource();
  GetIt.instance.registerLazySingleton(() => AuthRepository(remoteDataSource));
  GetIt.instance.registerLazySingleton<ChatRepository>(
      () => ChatRepository(RemoteDataSource()));
  GetIt.instance.registerLazySingleton(() => UserRepository(remoteDataSource));
  GetIt.instance.registerLazySingleton(() => PostRepository(remoteDataSource));
  GetIt.instance.registerLazySingleton(() => AdminRepository(remoteDataSource));
  GetIt.instance.registerLazySingleton(() => NotificationRepository());
  GetIt.instance.registerLazySingleton(() => SettingsRepository());
}
