import 'dart:developer';
import 'dart:io';

import 'package:nha_gia_re/data/repositories/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

// path là đường dẫn trong bucket bao gồm cả tên file
// vd abc/123.jpg hoặc 123.jpg
Future<String> uploadFileToSupabaseStorage(
    File file, String bucketName, String path) async {
  final storage = Supabase.instance.client.storage;
  try {
    final response = await storage
        .from(bucketName)
        .uploadBinary(path, file.readAsBytesSync());
    print(response);
    return storage.from(bucketName).getPublicUrl(path);
  } catch (e) {
    rethrow;
  }
}

Future<void> uploadAvatar(File avatar) async {
  try {
    var uid = Supabase.instance.client.auth.currentUser!.id;
    final fileName = avatar.path.split('/').last;
    var path = '$uid/$fileName';
    print('path $path');
    final url = await uploadFileToSupabaseStorage(avatar, 'avatar', path);
  } catch (e) {
    rethrow;
  }
}
Future<void> deletePostImage() async{

}

Future<List<String>> uploadPostImages(List<File> images) async {
  try {
    log("Upload line 42:");
    log(images.length.toString());
    final List<String> urls = [];
    const uuid = Uuid();

    for (var image in images) {
      var uid = Supabase.instance.client.auth.currentUser!.id;
      String fileName = image.path.split('/').last;
      fileName = "${uuid.v4()}.${fileName.split('.').last}";
      var path = '$uid/$fileName';
      print('path $path');
      urls.add(await uploadFileToSupabaseStorage(image, 'post_images', path));
    }
    log("Upload line 56:");
    log(urls.toString());
    return urls;
  } catch (e) {
    rethrow;
  }
}


Future<List<String>> uploadMessageMedia(
    List<File> medias, String conversationID) async {
  try {
    final List<String> urls = [];
    const uuid = Uuid();
    for (final image in medias) {
      final fileName = "${uuid.v4()}.${image.path.split('.').last}";
      final path = '$conversationID/$fileName';
      final url = await uploadFileToSupabaseStorage(image, 'media_message', path);
      urls.add(url);
    }
    return urls;
  } catch (e) {
    rethrow;
  }
}
