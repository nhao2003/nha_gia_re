import 'package:http/http.dart';
import 'package:nha_gia_re/data/models/conversation.dart';
import 'package:nha_gia_re/data/providers/remote/request/filter_request.dart';
import 'package:nha_gia_re/data/providers/remote/request/post_request.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../enums/enums.dart';
import '../models/properties/post.dart';
import 'base_repository.dart';

class PostRepository extends BaseRepository {
  Future<Post> createPost(PostRequest postRequest) async {
    try {
      final Map<String, dynamic> response;
      switch (postRequest.type) {
        case PropertyType.apartment:
          response =
              await remoteDataSourceImpl.postApartment(postRequest.toJson());
          return Apartment.fromJson(response);
        case PropertyType.house:
          response = await remoteDataSourceImpl.postHouse(postRequest.toJson());
          return House.fromJson(response);
        case PropertyType.land:
          response = await remoteDataSourceImpl.postLand(postRequest.toJson());
          return Land.fromJson(response);
        case PropertyType.motel:
          response = await remoteDataSourceImpl.postMotel(postRequest.toJson());
          return Motel.fromJson(response);
        case PropertyType.office:
          response =
              await remoteDataSourceImpl.postOffice(postRequest.toJson());
          return Office.fromJson(response);
        default:
          throw Exception("Undefined Post");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Post> editPost(String postID, PostRequest postRequest) async {
    try {
      final Map<String, dynamic> response;
      switch (postRequest.type) {
        case PropertyType.apartment:
          response = await remoteDataSourceImpl.editPostApartment(
              postID, postRequest.toJson());
          return Apartment.fromJson(response);
        case PropertyType.house:
          response = await remoteDataSourceImpl.editPostHouse(
              postID, postRequest.toJson());
          return House.fromJson(response);
        case PropertyType.land:
          response = await remoteDataSourceImpl.editPostLand(
              postID, postRequest.toJson());
          return Land.fromJson(response);
        case PropertyType.motel:
          response = await remoteDataSourceImpl.editPostMotel(
              postID, postRequest.toJson());
          return Motel.fromJson(response);
        case PropertyType.office:
          response = await remoteDataSourceImpl.editPostOffice(
              postID, postRequest.toJson());
          return Office.fromJson(response);
        default:
          throw Exception("Undefined Post");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deletePost(String postId) async {
    try {
      return await remoteDataSourceImpl.deletedPost(postId);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Post>> getAllPosts(PostFilter filter) async {
    final List<Map<String, dynamic>> response;
    response = await remoteDataSourceImpl.getAllPosts(filter);
    return response.map((e) => Post.fromJson(e)).toList();
  }

}
