import 'package:nha_gia_re/data/providers/remote/remote_data_source.dart';

abstract class BaseRepository {
  RemoteDataSource remoteDataSourceImpl = RemoteDataSource();
}
