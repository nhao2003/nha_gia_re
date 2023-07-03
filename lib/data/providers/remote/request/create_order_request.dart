import 'dart:convert';

CreateOrderRequest createOrderRequestFromJson(String str) => CreateOrderRequest.fromJson(json.decode(str));

String createOrderRequestToJson(CreateOrderRequest data) => json.encode(data.toJson());

class CreateOrderRequest {
    final Record record;

    CreateOrderRequest({
        required this.record,
    });

    factory CreateOrderRequest.fromJson(Map<String, dynamic> json) => CreateOrderRequest(
        record: Record.fromJson(json["record"]),
    );

    Map<String, dynamic> toJson() => {
        "record": record.toJson(),
    };
}

class Record {
    final String userId;
    final int amount;
    final String embeddata;
    final String property;

    Record({
        required this.userId,
        required this.amount,
        required this.embeddata,
        required this.property,
    });

    factory Record.fromJson(Map<String, dynamic> json) => Record(
        userId: json["userId"],
        amount: json["amount"],
        embeddata: json["embeddata"],
        property: json["property"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "amount": amount,
        "embeddata": embeddata,
        "property": property,
    };
}
