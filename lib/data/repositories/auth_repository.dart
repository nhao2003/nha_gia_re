import 'dart:developer';

import 'package:get/get.dart';
import 'package:nha_gia_re/data/models/user_info.dart';
import 'package:nha_gia_re/data/providers/remote/remote_data_source.dart';
import 'package:nha_gia_re/data/providers/remote/request/update_profile_request.dart';
import 'package:nha_gia_re/data/repositories/base_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepository{
  final RemoteDataSource _remoteDataSource;
  AuthRepository(this._remoteDataSource);
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
          await _remoteDataSource.signIn(email: email, password: password);
      final userInfo =
          await _remoteDataSource.getUserInfo(response.user!.id);
      return UserInfo.fromJson(userInfo);
    } catch (e) {
      rethrow;
    }
  }

  Future<UserInfo> signUp(
      {required String email, required String password}) async {
    try {
      final response =
          await _remoteDataSource.signUp(email: email, password: password);
      inspect(response);
      if (response.user!.identities!.isEmpty) {
        throw const AuthException("A user with this email address has already been registered");
      }
      final userInfo =
          await _remoteDataSource.getUserInfo(response.user!.id);
      return UserInfo.fromJson(userInfo);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    _remoteDataSource.signOut();
  }

  Future<UserInfo> updateProfile(
      UpdateProfileRequest updateProfileRequest) async {
    final userRes =
        await _remoteDataSource.updateUser(updateProfileRequest.toJson());
    return UserInfo.fromJson(userRes);
  }

  Future<void> recoveryPassword(String email) async {
    try {
      await _remoteDataSource.recoveryPassword(email);
    } catch (e) {
      rethrow;
    }
  }
}
