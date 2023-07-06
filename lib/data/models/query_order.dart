// To parse this JSON data, do
//
//     final queryOrderResponse = queryOrderResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

QueryOrderResponse queryOrderResponseFromJson(String str) =>
    QueryOrderResponse.fromJson(json.decode(str));

String queryOrderResponseToJson(QueryOrderResponse data) =>
    json.encode(data.toJson());

class QueryOrderResponse {
  final int amount;
  final String userId;
  final int returncode;
  final String postId;
  final int zptransid;
  final String returnmessage;

  QueryOrderResponse({
    required this.amount,
    required this.userId,
    required this.returncode,
    required this.postId,
    required this.zptransid,
    required this.returnmessage,
  });

  factory QueryOrderResponse.fromJson(Map<String, dynamic> json) =>
      QueryOrderResponse(
        amount: json["amount"],
        userId: json["userId"],
        returncode: json["returncode"],
        postId: json["postId"],
        zptransid: json["zptransid"],
        returnmessage: json["returnmessage"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "userId": userId,
        "returncode": returncode,
        "postId": postId,
        "zptransid": zptransid,
        "returnmessage": returnmessage,
      };
}
