import 'dart:convert';

CreateOrderResponseModel createOrderResponseModelFromJson(String str) =>
    CreateOrderResponseModel.fromJson(json.decode(str));

String createOrderResponseModelToJson(CreateOrderResponseModel data) =>
    json.encode(data.toJson());

class CreateOrderResponseModel {
  final Data data;
  final String apptransid;

  CreateOrderResponseModel({
    required this.data,
    required this.apptransid,
  });

  factory CreateOrderResponseModel.fromJson(Map<String, dynamic> json) =>
      CreateOrderResponseModel(
        data: Data.fromJson(json["data"]),
        apptransid: json["apptransid"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "apptransid": apptransid,
      };
}

class Data {
  final String zptranstoken;
  final String orderurl;
  final int returncode;
  final String returnmessage;

  Data({
    required this.zptranstoken,
    required this.orderurl,
    required this.returncode,
    required this.returnmessage,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        zptranstoken: json["zptranstoken"],
        orderurl: json["orderurl"],
        returncode: json["returncode"],
        returnmessage: json["returnmessage"],
      );

  Map<String, dynamic> toJson() => {
        "zptranstoken": zptranstoken,
        "orderurl": orderurl,
        "returncode": returncode,
        "returnmessage": returnmessage,
      };
}
