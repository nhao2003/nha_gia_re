import 'dart:developer';

import 'package:get/get.dart';
import 'package:nha_gia_re/data/models/user_info.dart';
import 'package:nha_gia_re/data/providers/remote/remote_data_source.dart';
import 'package:nha_gia_re/data/providers/remote/request/update_profile_request.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../providers/remote/remote_data_source.dart';

class AuthRepository{
  final _user = Supabase.instance.client.auth;

  bool get isUserLoggedIn => _user.currentUser != null;

  String? get userID => Supabase.instance.client.auth.currentUser?.id;

  static UserInfo? userInfo;

  final RemoteDataSource _remoteDataSource;
  AuthRepository(this._remoteDataSource);

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
      final info =
          await _remoteDataSource.getUserInfo(response.user!.id);
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
          await _remoteDataSource.signUp(email: email, password: password);
      inspect(response);
      if (response.user!.identities!.isEmpty) {
        throw const AuthException("A user with this email address has already been registered");
      }
      final info =
          await _remoteDataSource.getUserInfo(response.user!.id);
      userInfo = UserInfo.fromJson(info);
      return userInfo!;
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
    userInfo = UserInfo.fromJson(userRes);
    return userInfo!;
  }

  Future<void> recoveryPassword(String email) async {
    try {
      await _remoteDataSource.recoveryPassword(email);
    } catch (e) {
      rethrow;
    }
  }
}
