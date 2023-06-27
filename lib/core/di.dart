
import 'package:get_it/get_it.dart';
import 'package:nha_gia_re/data/providers/remote/remote_data_source.dart';
import 'package:nha_gia_re/data/repositories/chat_repository.dart';

Future<void> initAppModule() async {
  ChatRepository chatRepository = ChatRepository(RemoteDataSource());
  GetIt.instance.registerLazySingleton<ChatRepository>(() => chatRepository);
}
