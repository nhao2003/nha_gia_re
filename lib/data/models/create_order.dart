// To parse this JSON data, do
//
//     final createOrderResponseModel = createOrderResponseModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CreateOrderResponseModel createOrderResponseModelFromJson(String str) =>
    CreateOrderResponseModel.fromJson(json.decode(str));

String createOrderResponseModelToJson(CreateOrderResponseModel data) =>
    json.encode(data.toJson());

class CreateOrderResponseModel {
  final String zptranstoken;
  final String orderurl;
  final int returncode;
  final String returnmessage;
  final String apptransid;

  CreateOrderResponseModel({
    required this.zptranstoken,
    required this.orderurl,
    required this.returncode,
    required this.returnmessage,
    required this.apptransid,
  });

  factory CreateOrderResponseModel.fromJson(Map<String, dynamic> json) =>
      CreateOrderResponseModel(
        zptranstoken: json["zptranstoken"],
        orderurl: json["orderurl"],
        returncode: json["returncode"],
        returnmessage: json["returnmessage"],
        apptransid: json["apptransid"],
      );

  Map<String, dynamic> toJson() => {
        "zptranstoken": zptranstoken,
        "orderurl": orderurl,
        "returncode": returncode,
        "returnmessage": returnmessage,
        "apptransid": apptransid,
      };
}
