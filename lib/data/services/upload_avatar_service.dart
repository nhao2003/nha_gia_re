
import 'dart:io';

import 'package:nha_gia_re/data/repositories/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// path là đường dẫn trong bucket bao gồm cả tên file
// vd abc/123.jpg hoặc 123.jpg
Future<String> uploadFileToSupabaseStorage(File file, String bucketName ,String path) async {
  final storage = Supabase.instance.client.storage;
  try{
    final response = await storage.from(bucketName).
    uploadBinary(path, file.readAsBytesSync() );
    print(response);
    return storage.from(bucketName).getPublicUrl(path);
  }
  catch (e)
  {
    rethrow;
  }
}

Future<void> uploadAvatar(File avatar)
async {
  try
  {
    var uid = Supabase.instance.client.auth.currentUser!.id;
    final fileName =  avatar.path.split('/').last;
    var path = '$uid/$fileName';
    print('path $path');
    final url = await uploadFileToSupabaseStorage(avatar, 'avatar', path);
  }
  catch (e)
  {
    rethrow;
  }
}