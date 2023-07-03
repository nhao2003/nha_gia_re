import 'package:get_it/get_it.dart';
import 'package:nha_gia_re/data/providers/remote/remote_data_source.dart';
import 'package:nha_gia_re/data/repositories/auth_repository.dart';
import 'package:nha_gia_re/data/repositories/chat_repository.dart';
import 'package:nha_gia_re/data/repositories/post_repository.dart';
import 'package:nha_gia_re/data/repositories/user_repository.dart';

Future<void> initAppModule() async {
  GetIt.instance
      .registerLazySingleton(() => AuthRepository(RemoteDataSource()));
  GetIt.instance.registerLazySingleton<ChatRepository>(
      () => ChatRepository(RemoteDataSource()));
  GetIt.instance
      .registerLazySingleton(() => UserRepository(RemoteDataSource()));
  GetIt.instance
      .registerLazySingleton(() => PostRepository(RemoteDataSource()));
}
