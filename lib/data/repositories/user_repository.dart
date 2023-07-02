import 'package:get_it/get_it.dart';
import 'package:nha_gia_re/data/providers/remote/remote_data_source.dart';
import 'package:nha_gia_re/data/repositories/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/user_info.dart';

class UserRepository {
  final RemoteDataSource _remoteDataSource;
  UserRepository(this._remoteDataSource);

  final Map<String, UserInfo> _userInfos = {};

  Future<UserInfo> getUserInfo([String? uid]) async {
    AuthRepository auth = GetIt.instance<AuthRepository>();
    if(uid == null && auth.isUserLoggedIn) 
    {
      uid = auth.userID;
    }
    UserInfo? user = _userInfos[uid];
    if (user != null) return user;
    try {
      final data = await _remoteDataSource.getUserInfo(uid!);
      user = UserInfo.fromJson(data);
      _userInfos.putIfAbsent(user.uid, () => user!);
      return UserInfo.fromJson(data);
    } catch (e) {
      rethrow;
    }
  }
}