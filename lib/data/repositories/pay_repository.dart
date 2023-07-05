import 'dart:convert';
import 'package:nha_gia_re/data/providers/remote/request/create_order_request.dart';
import '../models/create_order.dart';
import 'package:http/http.dart' as https;
import 'package:nha_gia_re/core/values/api_values.dart';

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
}
