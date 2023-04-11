import 'package:nha_gia_re/data/repositories/base_repository.dart';
import 'package:supabase/supabase.dart';

class AuthRepository extends BaseRepository {
  Future<AuthResponse> signIn(
      {required String email, required String password}) async {
    if (await internetConnectionChecker.hasConnection) {
      try {
        return await remoteDataSourceImpl.signIn(
            email: 'email', password: 'password');
      } catch (e) {
        rethrow;
      }
    } else {
      throw Exception("No Internet");
    }
  }

  Future<AuthResponse> signUp(
      {required String email, required String password}) async {
    if (await internetConnectionChecker.hasConnection) {
      try {
        return remoteDataSourceImpl.signUp(
            email: 'email', password: 'password');
      } catch (e) {
        rethrow;
      }
    } else {
      throw Exception("No Internet");
    }
  }
  Future<void> updateUser() async {

  }
  Future<void> signOut(
      {required String email, required String password}) async {
    remoteDataSourceImpl.signOut();
  }
}
