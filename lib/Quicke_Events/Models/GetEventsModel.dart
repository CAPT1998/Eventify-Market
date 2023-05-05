// To parse this JSON data, do
//
//     final getEventsModel = getEventsModelFromJson(jsonString);

import 'dart:convert';

List<GetEventsModel> getEventsModelFromJson(String str) =>
    List<GetEventsModel>.from(
        json.decode(str).map((x) => GetEventsModel.fromJson(x)));

String getEventsModelToJson(List<GetEventsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetEventsModel {
  int id;
  String? eventsPic;
  String eventTitle;
  String price;
  String about;
  String? location;
  String? eventRelevantVideo;
  List<String> tags;
  String eventOrganizer;
  String? totalSeats;
  String? availableSeats;
  String? reserveSeats;
  String? ticketsType;
  String? limit;
  String? sortNo;
  String eventStartTime;
  String eventEndTime;
  DateTime eventStartDate;
  DateTime eventEndDate;
  String? eventCatId;
  DateTime createdAt;
  DateTime updatedAt;
  List<dynamic> customFields;

  GetEventsModel({
    required this.id,
    this.eventsPic,
    required this.eventTitle,
    required this.price,
    required this.about,
    this.location,
    this.eventRelevantVideo,
    required this.tags,
    required this.eventOrganizer,
    this.totalSeats,
    this.availableSeats,
    this.reserveSeats,
    this.ticketsType,
    this.limit,
    this.sortNo,
    required this.eventStartTime,
    required this.eventEndTime,
    required this.eventStartDate,
    required this.eventEndDate,
    this.eventCatId,
    required this.createdAt,
    required this.updatedAt,
    required this.customFields,
  });

  factory GetEventsModel.fromJson(Map<String, dynamic> json) => GetEventsModel(
        id: json["id"],
        eventsPic: json["events_pic"],
        eventTitle: json["event_title"],
        price: json["price"],
        about: json["about"],
        location: json["location"],
        eventRelevantVideo: json["event_relevant_video"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        eventOrganizer: json["event_organizer"],
        totalSeats: json["total_seats"],
        availableSeats: json["available_seats"],
        reserveSeats: json["reserve_seats"],
        ticketsType: json["tickets_type"],
        limit: json["limit"],
        sortNo: json["sort_no"],
        eventStartTime: json["event_start_time"],
        eventEndTime: json["event_end_time"],
        eventStartDate: DateTime.parse(json["event_start_date"]),
        eventEndDate: DateTime.parse(json["event_end_date"]),
        eventCatId: json["event_cat_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        customFields: List<dynamic>.from(json["custom_fields"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "events_pic": eventsPic,
        "event_title": eventTitle,
        "price": price,
        "about": about,
        "location": location,
        "event_relevant_video": eventRelevantVideo,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "event_organizer": eventOrganizer,
        "total_seats": totalSeats,
        "available_seats": availableSeats,
        "reserve_seats": reserveSeats,
        "tickets_type": ticketsType,
        "limit": limit,
        "sort_no": sortNo,
        "event_start_time": eventStartTime,
        "event_end_time": eventEndTime,
        "event_start_date":
            "${eventStartDate.year.toString().padLeft(4, '0')}-${eventStartDate.month.toString().padLeft(2, '0')}-${eventStartDate.day.toString().padLeft(2, '0')}",
        "event_end_date":
            "${eventEndDate.year.toString().padLeft(4, '0')}-${eventEndDate.month.toString().padLeft(2, '0')}-${eventEndDate.day.toString().padLeft(2, '0')}",
        "event_cat_id": eventCatId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "custom_fields": List<dynamic>.from(customFields.map((x) => x)),
      };
}
