// To parse this JSON data, do
//
//     final queryRecordResponse = queryRecordResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

QueryRecordResponse queryRecordResponseFromJson(String str) =>
    QueryRecordResponse.fromJson(json.decode(str));

String queryRecordResponseToJson(QueryRecordResponse data) =>
    json.encode(data.toJson());

class QueryRecordResponse {
  final int amount;
  final String userId;
  final int returncode;
  final String postId;
  final String zptransid;
  final String returnmessage;
  final String transactionid;

  QueryRecordResponse({
    required this.amount,
    required this.userId,
    required this.returncode,
    required this.postId,
    required this.zptransid,
    required this.returnmessage,
    required this.transactionid,
  });

  factory QueryRecordResponse.fromJson(Map<String, dynamic> json) =>
      QueryRecordResponse(
        amount: json["amount"],
        userId: json["userId"],
        returncode: json["returncode"],
        postId: json["postId"],
        zptransid: json["zptransid"].toString(),
        returnmessage: json["returnmessage"],
        transactionid: json["transactionid"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "userId": userId,
        "returncode": returncode,
        "postId": postId,
        "zptransid": zptransid,
        "returnmessage": returnmessage,
        "transactionid": transactionid,
      };
}
