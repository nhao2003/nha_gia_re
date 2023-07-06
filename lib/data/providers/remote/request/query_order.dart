import 'dart:convert';

QueryOrder createOrderRequestFromJson(String str) =>
    QueryOrder.fromJson(json.decode(str));

String createOrderRequestToJson(QueryOrder data) => json.encode(data.toJson());

class QueryOrder {
  final QueryRecord record;

  QueryOrder({
    required this.record,
  });

  factory QueryOrder.fromJson(Map<String, dynamic> json) => QueryOrder(
        record: QueryRecord.fromJson(json["record"]),
      );

  Map<String, dynamic> toJson() => {
        "record": record.toJson(),
      };
}

class QueryRecord {
  final String userId;
  final String apptransid;
  final String postId;

  QueryRecord({
    required this.userId,
    required this.apptransid,
    required this.postId,
  });

  factory QueryRecord.fromJson(Map<String, dynamic> json) => QueryRecord(
        userId: json["userId"],
        apptransid: json["apptransid"],
        postId: json["postId"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "apptransid": apptransid,
        "postId": postId,
      };
}
