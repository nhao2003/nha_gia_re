import 'package:nha_gia_re/data/providers/remote/remote_data_source.dart';
import 'package:nha_gia_re/data/providers/remote/request/filter_request.dart';
import 'package:nha_gia_re/data/providers/remote/request/post_request.dart';
import '../enums/enums.dart';
import '../models/properties/post.dart';

class PostRepository {
  final RemoteDataSource _remoteDataSource;
  PostRepository(this._remoteDataSource);
  Future<Post> createPost(PostRequest postRequest) async {
    try {
      final Map<String, dynamic> response;
      switch (postRequest.type) {
        case PropertyType.apartment:
          response =
              await _remoteDataSource.postApartment(postRequest.toJson());
          return Apartment.fromJson(response);
        case PropertyType.house:
          response = await _remoteDataSource.postHouse(postRequest.toJson());
          return House.fromJson(response);
        case PropertyType.land:
          response = await _remoteDataSource.postLand(postRequest.toJson());
          return Land.fromJson(response);
        case PropertyType.motel:
          response = await _remoteDataSource.postMotel(postRequest.toJson());
          return Motel.fromJson(response);
        case PropertyType.office:
          response = await _remoteDataSource.postOffice(postRequest.toJson());
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
          response = await _remoteDataSource.editPostApartment(
              postID, postRequest.toJson());
          return Apartment.fromJson(response);
        case PropertyType.house:
          response = await _remoteDataSource.editPostHouse(
              postID, postRequest.toJson());
          return House.fromJson(response);
        case PropertyType.land:
          response = await _remoteDataSource.editPostLand(
              postID, postRequest.toJson());
          return Land.fromJson(response);
        case PropertyType.motel:
          response = await _remoteDataSource.editPostMotel(
              postID, postRequest.toJson());
          return Motel.fromJson(response);
        case PropertyType.office:
          response = await _remoteDataSource.editPostOffice(
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
      return await _remoteDataSource.deletePost(postId);
    } catch (e) {
      rethrow;
    }
  }

  Future<Post> getPostDetail(String id, PropertyType type) async {
    Map<String, dynamic> data =
        await _remoteDataSource.getPostDetails(id, type);
    switch (type) {
      case PropertyType.apartment:
        return Apartment.fromJson(data);
      case PropertyType.land:
        return Land.fromJson(data);
      case PropertyType.office:
        return Office.fromJson(data);
      case PropertyType.motel:
        return Motel.fromJson(data);
      case PropertyType.house:
        return House.fromJson(data);
    }
  }

  Future<void> likePost(String postId) async {
    await _remoteDataSource.likePost(postId: postId);
  }

  Future<void> unlikePost(String postId) async {
    await _remoteDataSource.unlikePost(postId: postId);
  }

  Future<bool> hasLikePost(String postId) async {
    return await _remoteDataSource.hasLikePost(postId: postId);
  }

  Future<List<Post>> getUserPosts(String uid) async {
    final List<Map<String, dynamic>> response;
    response = await _remoteDataSource.getUserPosts(uid);
    return response.map((e) => Post.fromJson(e)).toList();
  }

  Future<List<Post>> getAllPosts(PostFilter filter) async {
    final List<Map<String, dynamic>> response;
    response = await _remoteDataSource.getAllPosts(filter);
    return response.map((e) => Post.fromJson(e)).toList();
  }

  Future<List<Apartment>> getAllApartments(ApartmentFilter filter) async {
    final List<Map<String, dynamic>> response;
    response = await _remoteDataSource.getAllApartments(filter);
    return response.map((e) => Apartment.fromJson(e)).toList();
  }

  Future<List<House>> getAllHouses(HouseFilter filter) async {
    final List<Map<String, dynamic>> response;
    response = await _remoteDataSource.getAllHouses(filter);
    return response.map((e) => House.fromJson(e)).toList();
  }

  Future<List<Land>> getAllLands(LandFilter filter) async {
    final List<Map<String, dynamic>> response;
    response = await _remoteDataSource.getAllLands(filter);
    return response.map((e) => Land.fromJson(e)).toList();
  }

  Future<List<Office>> getAllOffices(OfficeFilter filter) async {
    final List<Map<String, dynamic>> response;
    response = await _remoteDataSource.getAllOffices(filter);
    return response.map((e) => Office.fromJson(e)).toList();
  }

  Future<List<Motel>> getAllMotels(MotelFilter filter) async {
    final List<Map<String, dynamic>> response;
    response = await _remoteDataSource.getAllMotels(filter);
    return response.map((e) => Motel.fromJson(e)).toList();
  }

  Future<void> hideOrUnHidePost(String postId, bool isHide) async {
    await _remoteDataSource.hideOrUnHidePost(postId, isHide);
  }

  Future<void> extendPostExpiryDate(String postId, bool isHide) async {
    await _remoteDataSource.extendPost(postId);
  }
}
