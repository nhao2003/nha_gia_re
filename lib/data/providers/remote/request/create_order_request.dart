// To parse this JSON data, do
//
//     final createOrderRequest = createOrderRequestFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CreateOrderRequest createOrderRequestFromJson(String str) =>
    CreateOrderRequest.fromJson(json.decode(str));

String createOrderRequestToJson(CreateOrderRequest data) =>
    json.encode(data.toJson());

class CreateOrderRequest {
  final Record record;

  CreateOrderRequest({
    required this.record,
  });

  factory CreateOrderRequest.fromJson(Map<String, dynamic> json) =>
      CreateOrderRequest(
        record: Record.fromJson(json["record"]),
      );

  Map<String, dynamic> toJson() => {
        "record": record.toJson(),
      };
}

class Record {
  final String userId;
  final String membershipPackageId;
  final int numOfSubscriptionMonth;

  Record({
    required this.userId,
    required this.membershipPackageId,
    required this.numOfSubscriptionMonth,
  });

  factory Record.fromJson(Map<String, dynamic> json) => Record(
        userId: json["userId"],
        membershipPackageId: json["membershipPackageId"],
        numOfSubscriptionMonth: json["numOfSubscriptionMonth"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "membershipPackageId": membershipPackageId,
        "numOfSubscriptionMonth": numOfSubscriptionMonth,
      };
}
