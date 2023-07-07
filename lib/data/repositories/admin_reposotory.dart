import 'dart:developer';
import 'package:get_it/get_it.dart';
import 'package:nha_gia_re/data/models/admin.dart';

import 'package:nha_gia_re/data/models/properties/post.dart';
import 'package:nha_gia_re/data/providers/remote/remote_data_source.dart';
import 'package:nha_gia_re/data/repositories/auth_repository.dart';

class AdminRepository {
  final RemoteDataSource _remoteDataSource;

  AdminRepository(this._remoteDataSource);
  Future<List<Post>> getPendingPosts() async {
    final res = await _remoteDataSource.getPendingPosts();
    return res.map((e) => Post.fromJson(e)).toList();
  }

  Future<List<Post>> getRejectedPosts() async {
    final res = await _remoteDataSource.getRejectedPosts();
    return res.map((e) => Post.fromJson(e)).toList();
  }

  Future<void> approvePost(String id) async {
    print("===========================");
    log(id);
    await _remoteDataSource.approvePost(id);
  }

  Future<void> rejectPost(String id, String reason) async {
    print("===========================");
    log(id);
    await _remoteDataSource.rejectPost(id, reason);
  }
}
