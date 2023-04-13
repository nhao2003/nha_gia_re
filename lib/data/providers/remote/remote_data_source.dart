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

  Future<Map<String, dynamic> > editPostApartment(String postId, Map<String, dynamic> data);
  Future<Map<String, dynamic> > editPostHouse(String postId, Map<String, dynamic> data);
  Future<Map<String, dynamic> > editPostOffice(String postId, Map<String, dynamic> data);
  Future<Map<String, dynamic>> editPostMotel(String postId, Map<String, dynamic> data);
  Future<Map<String, dynamic>> editPostLand(String postId, Map<String, dynamic> data);
  Future<void> deletedPost(String id);
}
