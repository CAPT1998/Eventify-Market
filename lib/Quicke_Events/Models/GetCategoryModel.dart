// To parse this JSON data, do
//
//     final getCategoryModel = getCategoryModelFromJson(jsonString);

import 'dart:convert';

List<GetCategoryModel> getCategoryModelFromJson(String str) =>
    List<GetCategoryModel>.from(
        json.decode(str).map((x) => GetCategoryModel.fromJson(x)));

String getCategoryModelToJson(List<GetCategoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetCategoryModel {
  int id;
  String eventCatName;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  GetCategoryModel({
    required this.id,
    required this.eventCatName,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory GetCategoryModel.fromJson(Map<String, dynamic> json) =>
      GetCategoryModel(
        id: json["id"],
        eventCatName: json["event_cat_name"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "event_cat_name": eventCatName,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
