import 'package:supabase/supabase.dart';

import '../../models/user_info.dart';

abstract class RemoteDataSource {
  Future<AuthResponse> signUp(
      {required String email, required String password});
  Future<AuthResponse> signIn(
      {required String email, required String password});
  Future<void> signOut();
  Future<void> updateUser(Map<String, dynamic> data);

  Future<List<Map<String, dynamic>>> postApartment(Map<String, dynamic> data);
  Future<List<Map<String, dynamic>>> postHouse(Map<String, dynamic> data);
  Future<List<Map<String, dynamic>>> postOffice(Map<String, dynamic> data);
  Future<List<Map<String, dynamic>>> postMotel(Map<String, dynamic> data);
  Future<List<Map<String, dynamic>>> postLand(Map<String, dynamic> data);

  // Future<void> editPostApartment(Map<String, dynamic> data);
  // Future<void> editPostHouse(Map<String, dynamic> data);
  // Future<void> editPostOffice(Map<String, dynamic> data);
  // Future<void> editPostMotel(Map<String, dynamic> data);
  // Future<void> editPostLand(Map<String, dynamic> data);
  // Future<void> deletedPost(String id);
}
