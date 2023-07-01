import 'package:nha_gia_re/data/providers/remote/request/filter_request.dart';
import 'package:nha_gia_re/data/providers/remote/request/post_request.dart';
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
      return await remoteDataSourceImpl.deletePost(postId);
    } catch (e) {
      rethrow;
    }
  }

  Future<Post> getPostDetail(Post post) async {
    final data = await remoteDataSourceImpl.getPostDetails(post.id, post.type);
    switch (post.type) {
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
    await remoteDataSourceImpl.likePost(postId: postId);
  }

  Future<void> unlikePost(String postId) async {
    await remoteDataSourceImpl.unlikePost(postId: postId);
  }

  Future<bool> hasLikePost(String postId) async {
    return await remoteDataSourceImpl.hasLikePost(postId: postId);
  }

  Future<List<Post>> getUserPosts(String uid) async {
    final List<Map<String, dynamic>> response;
    response = await remoteDataSourceImpl.getUserPosts(uid);
    return response.map((e) => Post.fromJson(e)).toList();
  }

  Future<List<Post>> getAllPosts(PostFilter filter) async {
    final List<Map<String, dynamic>> response;
    response = await remoteDataSourceImpl.getAllPosts(filter);
    return response.map((e) => Post.fromJson(e)).toList();
  }

  Future<List<Apartment>> getAllApartments(ApartmentFilter filter) async {
    final List<Map<String, dynamic>> response;
    response = await remoteDataSourceImpl.getAllApartments(filter);
    return response.map((e) => Apartment.fromJson(e)).toList();
  }

  Future<List<House>> getAllHouses(HouseFilter filter) async {
    final List<Map<String, dynamic>> response;
    response = await remoteDataSourceImpl.getAllHouses(filter);
    return response.map((e) => House.fromJson(e)).toList();
  }

  Future<List<Land>> getAllLands(LandFilter filter) async {
    final List<Map<String, dynamic>> response;
    response = await remoteDataSourceImpl.getAllLands(filter);
    return response.map((e) => Land.fromJson(e)).toList();
  }

  Future<List<Office>> getAllOffices(OfficeFilter filter) async {
    final List<Map<String, dynamic>> response;
    response = await remoteDataSourceImpl.getAllOffices(filter);
    return response.map((e) => Office.fromJson(e)).toList();
  }

  Future<List<Motel>> getAllMotels(MotelFilter filter) async {
    final List<Map<String, dynamic>> response;
    response = await remoteDataSourceImpl.getAllMotels(filter);
    return response.map((e) => Motel.fromJson(e)).toList();
  }

  Future<void> hideOrUnHidePost(String postId, bool isHide) async {
    await remoteDataSourceImpl.hideOrUnHidePost(postId, isHide);
  }

  Future<void> extendPostExpiryDate(String postId, bool isHide) async {
    await remoteDataSourceImpl.extendPost(postId);
  }
}
