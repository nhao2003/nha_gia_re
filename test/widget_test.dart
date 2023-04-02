// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nha_gia_re/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://ldgecfuqlicdeuqijmbr.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxkZ2VjZnVxbGljZGV1cWlqbWJyIiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODAyMzYyNzEsImV4cCI6MTk5NTgxMjI3MX0.V5CnCUKROCJ8WHV5SXQQPbWsEYanK0sgEPI9PBPsvz4',
  );
  AuthResponse authResponse = await Supabase.instance.client.auth
      .signInWithPassword(password: "12345678", email: "haobi2k3@gmail.com");
  print(authResponse.user?.toJson());
}
