import 'package:nha_gia_re/data/providers/remote/remote_data_source.dart';

import '../models/user_info.dart';

class UserRepository {
  final RemoteDataSource _remoteDataSource;
  UserRepository(this._remoteDataSource);

  final Map<String, UserInfo> _userInfos = {};

  Future<UserInfo> getUserInfo(String uid) async {
    UserInfo? user = _userInfos[uid];
    if (user != null) return user;
    try {
      final data = await _remoteDataSource.getUserInfo(uid);
      user = UserInfo.fromJson(data);
      _userInfos.putIfAbsent(user.uid, () => user!);
      return UserInfo.fromJson(data);
    } catch (e) {
      rethrow;
    }
  }
}