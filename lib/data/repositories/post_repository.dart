import 'package:http/http.dart';
import 'package:nha_gia_re/data/providers/remote/request/request.dart';

import '../models/properties/post.dart';
import 'base_repository.dart';

class PostRepository extends BaseRepository {
  Future<Post> createPost(PostRequest postRequest) async {
      try {
        switch (postRequest.type) {
          case PropertyType.apartment:
            final data = await remoteDataSourceImpl.postApartment(postRequest.toJson());
            return 
          case PropertyType.house:
          remoteDataSourceImpl.postHouse(postRequest.toJson());
            break;
          case PropertyType.land:
          remoteDataSourceImpl.postLand(postRequest.toJson());
            break;
          case PropertyType.motel:
          remoteDataSourceImpl.postMotel(postRequest.toJson());
            break;
          case PropertyType.office:
          remoteDataSourceImpl.postOffice(postRequest.toJson());
            break;
          default:
            throw Exception("Undefined Post");
        }

      } catch (e) {
        rethrow;
      }
  }
}
