import 'dart:async';

import 'package:nha_gia_re/data/enums/enums.dart';
import 'package:nha_gia_re/data/models/message.dart';
import 'package:nha_gia_re/data/providers/remote/request/filter_request.dart';
import 'package:supabase/supabase.dart';

import '../../models/user_info.dart';

abstract class RemoteDataSource {
  Future<AuthResponse> signUp(
      {required String email, required String password});

  Future<AuthResponse> signIn(
      {required String email, required String password});

  Future<void> signOut();

  Future<void> updateUser(Map<String, dynamic> data);

  Future<Map<String, dynamic>> getUserInfo(String id);

  Future<void> recoveryPassword(String email);

  Future<Map<String, dynamic>> postApartment(Map<String, dynamic> data);

  Future<Map<String, dynamic>> postHouse(Map<String, dynamic> data);

  Future<Map<String, dynamic>> postOffice(Map<String, dynamic> data);

  Future<Map<String, dynamic>> postMotel(Map<String, dynamic> data);

  Future<Map<String, dynamic>> postLand(Map<String, dynamic> data);

  Future<Map<String, dynamic>> editPostApartment(
      String postId, Map<String, dynamic> data);

  Future<Map<String, dynamic>> editPostHouse(
      String postId, Map<String, dynamic> data);

  Future<Map<String, dynamic>> editPostOffice(
      String postId, Map<String, dynamic> data);

  Future<Map<String, dynamic>> editPostMotel(
      String postId, Map<String, dynamic> data);

  Future<Map<String, dynamic>> editPostLand(
      String postId, Map<String, dynamic> data);

  Future<List<Map<String, dynamic>>> getAllPosts(PostFilter filter);

  Future<List<Map<String, dynamic>>> getAllApartments(ApartmentFilter filter);

  Future<List<Map<String, dynamic>>> getAllHouses(HouseFilter filter);

  Future<List<Map<String, dynamic>>> getAllLands(LandFilter filter);

  Future<Map<String, dynamic>> getPostDetails(
      String postId, PropertyType propertyType);

  Future<List<Map<String, dynamic>>> getAllOffices(OfficeFilter filter);

  Future<List<Map<String, dynamic>>> getAllMotels(MotelFilter filter);

  Future<void> deletedPost(String id);

  Stream<List<Message>> getMessages(String conversationId);

  Future sendMessage(Map<String, dynamic> data);

  /// Creates or returns an existing roomID of both participants
  Future<Map<String, dynamic>> getOrCreateConversation(String otherUserId);
}
