import 'package:nha_gia_re/data/models/properties/post.dart';
import 'package:nha_gia_re/data/providers/remote/remote_data_source.dart';

class AdminRepository{
  final RemoteDataSource _remoteDataSource;
  AdminRepository(this._remoteDataSource);
  Future<List<Post>> getPendingPosts() async {
    final res = await _remoteDataSource.getPendingPosts();
    return res.map((e) => Post.fromJson(e)).toList();
  }
  Future<void> approvePost(String id)async {
    await _remoteDataSource.approvePost(id);
  }
  Future<void> rejectPost(String id, String reason)async {
    await _remoteDataSource.rejectPost(id, reason);
  }
}