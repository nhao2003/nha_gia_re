import 'dart:convert';
import 'package:get_it/get_it.dart';
import 'package:nha_gia_re/data/models/discount.dart';
import 'package:nha_gia_re/data/models/query_order.dart';
import 'package:nha_gia_re/data/providers/remote/remote_data_source.dart';
import 'package:nha_gia_re/data/providers/remote/request/create_order_request.dart';
import 'package:nha_gia_re/data/providers/remote/request/query_order.dart';
import 'package:nha_gia_re/data/repositories/auth_repository.dart';
import 'package:nha_gia_re/routers/app_routes.dart';
import '../models/purchase/membership_package_subscription.dart';
import '../models/purchase/transaction.dart';
import '../models/user_info.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/create_order.dart';
import 'package:http/http.dart' as https;
import 'package:nha_gia_re/core/values/api_values.dart';

import '../models/purchase/membership_package.dart';

class PayRepository {
  static var client = https.Client();
  final authRepo = GetIt.instance<AuthRepository>();
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

  static Future<QueryRecordResponse?> createQuery(QueryOrder model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': "application/json",
      // 'token': "Bearer $token"
    };
    var url = Uri.https(APP_URL, QUERY_PAY_STATUS);
    var response = await client.post(url,
        headers: requestHeaders, body: jsonEncode(model));
    if (response.statusCode == 200) {
      QueryRecordResponse query = queryRecordResponseFromJson(response.body);
      return query;
    } else {
      return null;
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

  Future<
          MapEntry<Transaction,
              MapEntry<MembershipPackage, MembershipPackageSubscription?>>>
      getDetailTransaction(String id) async {
    final data = await remoteDataSource.getDetailTransaction(id);
    final transaction = Transaction.fromJson(data);
    final membershipPackage =
        MembershipPackage.fromJson(data['membership_package']);
    final membershipPackageSubscription =
    data['membership_package_subscription'] != null && data['membership_package_subscription'].isNotEmpty
            ? MembershipPackageSubscription.fromJson(
                data['membership_package_subscription'].first)
            : null;
    return MapEntry(
      transaction,
      MapEntry(membershipPackage, membershipPackageSubscription),
    );
  }



  Future<
          List<
              MapEntry<Transaction,
                  MapEntry<MembershipPackage, MembershipPackageSubscription?>>>>
      getUserTransactions() async {
    final data = await remoteDataSource.getUserTransactions(authRepo.userID!);
    var tm = data;
    final res =  data.map((e) {
      final transaction = Transaction.fromJson(e);
      final membershipPackage =
          MembershipPackage.fromJson(e['membership_package']);
      final membershipPackageSubscription =
          e['membership_package_subscription'] != null && e['membership_package_subscription'].isNotEmpty
              ? MembershipPackageSubscription.fromJson(
                  e['membership_package_subscription'].first)
              : null;
      return MapEntry(
        transaction,
        MapEntry(membershipPackage, membershipPackageSubscription),
      );
    }).toList();
    return res;
  }
}
