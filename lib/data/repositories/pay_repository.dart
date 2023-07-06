import 'dart:convert';
import 'package:nha_gia_re/data/models/discount.dart';
import 'package:nha_gia_re/data/providers/remote/remote_data_source.dart';
import 'package:nha_gia_re/data/providers/remote/request/create_order_request.dart';
import 'package:nha_gia_re/data/providers/remote/request/query_order.dart';
import 'package:nha_gia_re/data/repositories/auth_repository.dart';
import 'package:nha_gia_re/routers/app_routes.dart';
import '../models/user_info.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/create_order.dart';
import 'package:http/http.dart' as https;
import 'package:nha_gia_re/core/values/api_values.dart';

import '../models/membership_package.dart';

class PayRepository {
  static var client = https.Client();

  static Future<CreateOrderResponseModel?> createOrder(
      CreateOrderRequest model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': "application/json",
      // 'token': "Bearer $token"
    };
    var url = Uri.https(APP_URL, ZALO_PAY_API);
    var response = await client.post(url,
        headers: requestHeaders, body: jsonEncode(model));
    if (response.statusCode == 200) {
      CreateOrderResponseModel model =
          createOrderResponseModelFromJson(response.body);
      return model;
    } else {
      return null;
    }
  }

  static Future<bool?> createQuery(QueryOrder model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': "application/json",
      // 'token': "Bearer $token"
    };
    var url = Uri.https(APP_URL, QUERY_PAY_STATUS);
    var response = await client.post(url,
        headers: requestHeaders, body: jsonEncode(model));
    if (response.statusCode == 200) {
      // CreateOrderResponseModel model =
      //     createOrderResponseModelFromJson(response.body);
      return true;
    } else {
      return false;
    }
  }

  RemoteDataSource remoteDataSource = RemoteDataSource();
  Future<List<MembershipPackage>> getMembershipPackage() async {
    final List<Map<String, dynamic>> data =
        await Supabase.instance.client.from('membership_package').select();
    return data.map((e) => MembershipPackage.fromJson(e)).toList();
  }

  Future<List<Discount>> getDiscount() async {
    final List<Map<String, dynamic>> data =
        await Supabase.instance.client.from('discount').select();
    return data.map((e) => Discount.fromJson(e)).toList();
  }
}
