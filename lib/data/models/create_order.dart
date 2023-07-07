// To parse this JSON data, do
//
//     final createOrderResponseModel = createOrderResponseModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CreateOrderResponseModel createOrderResponseModelFromJson(String str) =>
    CreateOrderResponseModel.fromJson(json.decode(str));


class CreateOrderResponseModel {
  final String zptranstoken;
  final String orderurl;
  final int returncode;
  final String returnmessage;
  final String apptransid;
  final String transactionId;
  CreateOrderResponseModel({
    required this.zptranstoken,
    required this.orderurl,
    required this.returncode,
    required this.returnmessage,
    required this.apptransid,
    required this.transactionId,
  });

  factory CreateOrderResponseModel.fromJson(Map<String, dynamic> json) =>
      CreateOrderResponseModel(
        zptranstoken: json["zptranstoken"],
        orderurl: json["orderurl"],
        returncode: json["returncode"],
        returnmessage: json["returnmessage"],
        apptransid: json["apptransid"], transactionId: json["transactionid"],
      );
}
