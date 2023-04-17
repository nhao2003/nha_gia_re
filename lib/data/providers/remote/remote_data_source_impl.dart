import 'package:nha_gia_re/data/enums/property_enums.dart';
import 'package:nha_gia_re/data/providers/remote/remote_data_source.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RemoteDataSourceImpl extends RemoteDataSource {
  final SupabaseClient supabaseClient = Supabase.instance.client;

  @override
  Future<AuthResponse> signUp(
      {required String email, required String password}) async {
    try {
      return await supabaseClient.auth.signUp(email: email, password: password);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AuthResponse> signIn(
      {required String email, required String password}) async {
    try {
      return await supabaseClient.auth
          .signInWithPassword(email: email, password: password);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await supabaseClient.auth.signOut();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> updateUser(Map<String, dynamic> data) async {
    try {
      final res = await supabaseClient
          .from('user_info')
          .update(data)
          .eq('uid', supabaseClient.auth.currentUser!.id)
          .select();
      return List<Map<String, dynamic>>.from(res).first;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deletedPost(String id) async {
    try {
      await supabaseClient.from('post').delete().eq('id', id);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> postApartment(Map<String, dynamic> data) async {
    try {
      final res = await supabaseClient.from('apartments').insert(data).select();
      return List<Map<String, dynamic>>.from(res).first;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> postHouse(Map<String, dynamic> data) async {
    try {
      final res = await supabaseClient.from('houses').insert(data).select();
      return List<Map<String, dynamic>>.from(res).first;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> postLand(Map<String, dynamic> data) async {
    try {
      final res = await supabaseClient.from('lands').insert(data).select();
      return List<Map<String, dynamic>>.from(res).first;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> postMotel(Map<String, dynamic> data) async {
    try {
      final res = await supabaseClient.from('motels').insert(data).select();
      return List<Map<String, dynamic>>.from(res).first;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> postOffice(Map<String, dynamic> data) async {
    try {
      final res = await supabaseClient.from('offices').insert(data).select();
      return List<Map<String, dynamic>>.from(res).first;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> getUserInfo(String uid) async {
    try {
      final response =
          await supabaseClient.from('user_info').select().eq('uid', uid);
      return List<Map<String, dynamic>>.from(response).first;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> recoveryPassword(String email) async {
    try {
      await supabaseClient.auth.resetPasswordForEmail(email);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> editPostApartment(
      String postId, Map<String, dynamic> data) async {
    try {
      final res = await supabaseClient
          .from('apartments')
          .update(data)
          .eq('id', postId)
          .select();
      return List<Map<String, dynamic>>.from(res).first;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> editPostHouse(
      String postId, Map<String, dynamic> data) async {
    try {
      final res = await supabaseClient
          .from('houses')
          .update(data)
          .eq('id', postId)
          .select();
      return List<Map<String, dynamic>>.from(res).first;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> editPostLand(
      String postId, Map<String, dynamic> data) async {
    try {
      final res = await supabaseClient
          .from('lands')
          .update(data)
          .eq('id', postId)
          .select();
      return List<Map<String, dynamic>>.from(res).first;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> editPostMotel(
      String postId, Map<String, dynamic> data) async {
    try {
      final res = await supabaseClient
          .from('motels')
          .update(data)
          .eq('id', postId)
          .select();
      return List<Map<String, dynamic>>.from(res).first;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> editPostOffice(
      String postId, Map<String, dynamic> data) async {
    try {
      final res = await supabaseClient
          .from('offices')
          .update(data)
          .eq('id', postId)
          .select();
      return List<Map<String, dynamic>>.from(res).first;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getAllPosts({int? limit}) async {
    try {
      if (limit != null) {
        final response = await supabaseClient.from('post').select();
        return List<Map<String, dynamic>>.from(response);
      } else {
        final response = await supabaseClient.from('post').select();
        return List<Map<String, dynamic>>.from(response);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> getPostDetails(
      String postId, PropertyType propertyType) async {
    final response;
    switch (propertyType) {
      case PropertyType.apartment:
        response =
            await supabaseClient.from('apartments').select().eq('id', postId);
        break;
      case PropertyType.land:
        response = await supabaseClient.from('lands').select().eq('id', postId);
        break;
      case PropertyType.office:
        response =
            await supabaseClient.from('offices').select().eq('id', postId);
        break;
      case PropertyType.motel:
        response =
            await supabaseClient.from('motels').select().eq('id', postId);
        break;
      case PropertyType.house:
        response =
            await supabaseClient.from('houses').select().eq('id', postId);
        break;
    }
    return List<Map<String, dynamic>>.from(response).first;
  }


  @override
  Stream<List<Map<String, dynamic>>> getAllConversation() async* {
    String uid = supabaseClient.auth.currentUser!.id;
    final res = supabaseClient.from('conservations')
        .select(
    '*, user1_info: user_info!conservations_user1_id_fkey(*), user2_info: user_info!conservations_user2_id_fkey(*), messages: messages(*)')
        .or('user1_id.eq.$uid, user2_id.eq.$uid').asStream();
    await for(var x in res){
      yield List<Map<String, dynamic>>.from(x).toList();
    }
  }

  @override
  Future sendMessage(Map<String, dynamic> data) async {
    await supabaseClient.from('messages').insert(data);
  }
}
