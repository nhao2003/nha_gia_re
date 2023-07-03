// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:supabase/supabase.dart';
enum Pe { A, B }

Future<void> main() async {
  final supabase = SupabaseClient(
    'https://xyzcompany.supabase.co',
    'public-anon-key',
  );
  if (supabase.auth.currentUser == null) {
    final auth = await supabase.auth.signInWithPassword(
        password: '12345678', email: 'haosince2003@gmail.com').then((value) => prints(value.user));
        }
    }
