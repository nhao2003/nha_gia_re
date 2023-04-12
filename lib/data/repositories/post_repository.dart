import 'package:http/http.dart';
import 'package:nha_gia_re/data/providers/remote/request/request.dart';

import '../models/properties/post.dart';
import 'base_repository.dart';

class PostRepository extends BaseRepository {
  Future<Post> createPost(PostRequest postRequest) async {
    try {
      final List<Map<String, dynamic>> response;
      switch (postRequest.type) {
        case PropertyType.apartment:
          response =
              await remoteDataSourceImpl.postApartment(postRequest.toJson());
          return Apartment.fromJson(response.first);
        case PropertyType.house:
          response = await remoteDataSourceImpl.postHouse(postRequest.toJson());
          return House.fromJson(response.first);
        case PropertyType.land:
          response = await remoteDataSourceImpl.postLand(postRequest.toJson());
          return Land.fromJson(response.first);
        case PropertyType.motel:
          response = await remoteDataSourceImpl.postMotel(postRequest.toJson());
          return Motel.fromJson(response.first);
        case PropertyType.office:
          response =
              await remoteDataSourceImpl.postOffice(postRequest.toJson());
          return Office.fromJson(response.first);
        default:
          throw Exception("Undefined Post");
      }
    } catch (e) {
      rethrow;
    }
  }
}
