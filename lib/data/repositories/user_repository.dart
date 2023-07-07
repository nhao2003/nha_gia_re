import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:nha_gia_re/data/models/notification.dart';
import 'package:nha_gia_re/data/providers/remote/remote_data_source.dart';
import 'package:nha_gia_re/data/repositories/auth_repository.dart';
import '../models/user_info.dart';

class UserRepository {
  final RemoteDataSource _remoteDataSource;
  UserRepository(this._remoteDataSource);

  final Map<String, UserInfo> _userInfos = {};
    final Map<String, bool> _isVerified = {};


  Future<void> followUser(String uid)
  {
    return _remoteDataSource.followUser(userId: uid);
  }  
  Future<void> unFollowUser(String uid)
  {
    return _remoteDataSource.unfollowUser(userId: uid);
  }  
  Future<bool> isFollowing(String uid)
  {
    return _remoteDataSource.isFollowing(userId: uid);
  }

  Future<UserInfo> getUserInfo([String? uid]) async {
    AuthRepository auth = GetIt.instance<AuthRepository>();
    if (uid == null && auth.isUserLoggedIn) {
      uid = auth.userID;
    }
    UserInfo? user = _userInfos[uid];
    if (user != null && user.updatedDate != null) return user;
    try {
      final data = await _remoteDataSource.getUserInfo(uid!);
      user = UserInfo.fromJson(data);
      _userInfos.putIfAbsent(user.uid, () => user!);
      return UserInfo.fromJson(data);
    } catch (e) {
      rethrow;
    }
  }
  Future<bool> isVerifiedBadge([String? uid]) async {
    AuthRepository auth = GetIt.instance<AuthRepository>();
    if (uid == null && auth.isUserLoggedIn) {
      uid = auth.userID;
    }
    bool? result = _isVerified[uid];
    if (result != null) return result;
    try {
      final data = await _remoteDataSource.isVerifiedBadge(uid!);
      _isVerified.putIfAbsent(uid, () => data!);
      return data;
    } catch (e) {
      rethrow;
    }
  }
  Future<void> updatePass(String newPass)
  async {
    try
    {
      await _remoteDataSource.updatePass(newPass);
    }catch (e) {
      rethrow;
    }
  }
}
