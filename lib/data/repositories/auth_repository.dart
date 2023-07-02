import 'dart:developer';

import 'package:get/get.dart';
import 'package:nha_gia_re/data/models/user_info.dart';
import 'package:nha_gia_re/data/providers/remote/request/update_profile_request.dart';
import 'package:nha_gia_re/data/repositories/base_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../providers/remote/remote_data_source.dart';

class AuthRepository extends BaseRepository {
  final _user = Supabase.instance.client.auth;

  bool get isUserLoggedIn => _user.currentUser != null;

  String? get userID => Supabase.instance.client.auth.currentUser?.id;

  static UserInfo? userInfo;

  final RemoteDataSource _remoteDataSource = RemoteDataSource();

  Future<UserInfo> getUserInfo()
  async {
    if(userInfo != null)
    {
      return userInfo!;
    }
    else
    {
      if(isUserLoggedIn)
      {
        var info = await _remoteDataSource.getUserInfo(userID!);
        userInfo = UserInfo.fromJson(info);
        return userInfo!;
      }
      else
      {
        throw Exception("User has to be LoggedIn first");
      }
    }
  }

  Future<UserInfo> signIn(
      {required String email, required String password}) async {
    try {
      final response =
          await remoteDataSourceImpl.signIn(email: email, password: password);
      final info =
          await remoteDataSourceImpl.getUserInfo(response.user!.id);
      userInfo = UserInfo.fromJson(info);
      return userInfo!;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserInfo> signUp(
      {required String email, required String password}) async {
    try {
      final response =
          await remoteDataSourceImpl.signUp(email: email, password: password);
      inspect(response);
      if (response.user!.identities!.isEmpty) {
        throw const AuthException("A user with this email address has already been registered");
      }
      final info =
          await remoteDataSourceImpl.getUserInfo(response.user!.id);
      userInfo = UserInfo.fromJson(info);
      return userInfo!;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    remoteDataSourceImpl.signOut();
  }

  Future<UserInfo> updateProfile(
      UpdateProfileRequest updateProfileRequest) async {
    final userRes =
        await remoteDataSourceImpl.updateUser(updateProfileRequest.toJson());
    userInfo = UserInfo.fromJson(userRes);
    return userInfo!;
  }

  Future<void> recoveryPassword(String email) async {
    try {
      await remoteDataSourceImpl.recoveryPassword(email);
    } catch (e) {
      rethrow;
    }
  }
}
