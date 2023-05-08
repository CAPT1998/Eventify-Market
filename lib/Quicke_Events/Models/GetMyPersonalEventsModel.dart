// To parse this JSON data, do
//
//     final getMyPersonalEventsModel = getMyPersonalEventsModelFromJson(jsonString);

import 'dart:convert';

List<GetMyPersonalEventsModel> getMyPersonalEventsModelFromJson(String str) =>
    List<GetMyPersonalEventsModel>.from(
        json.decode(str).map((x) => GetMyPersonalEventsModel.fromJson(x)));

String getMyPersonalEventsModelToJson(List<GetMyPersonalEventsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetMyPersonalEventsModel {
  int id;
  dynamic eventsPic;
  dynamic eventTitle;
  dynamic price;
  dynamic about;
  dynamic location;
  dynamic lattitude;
  dynamic longitude;
  dynamic eventRelevantVideo;
  dynamic tags;
  dynamic eventOrganizer;
  dynamic organizeImage;
  dynamic followers;
  dynamic eventType;
  dynamic userId;
  dynamic totalSeats;
  dynamic availableSeats;
  dynamic reserveSeats;
  dynamic ticketsType;
  dynamic limit;
  dynamic sortNo;
  dynamic eventStartTime;
  dynamic eventEndTime;
  DateTime eventStartDate;
  DateTime eventEndDate;
  dynamic eventCatId;
  DateTime createdAt;
  DateTime updatedAt;
  List<dynamic> seats;
  List<dynamic> customFields;

  GetMyPersonalEventsModel({
    required this.id,
    this.eventsPic,
    this.eventTitle,
    this.price,
    this.about,
    this.location,
    this.lattitude,
    this.longitude,
    this.eventRelevantVideo,
    this.tags,
    required this.eventOrganizer,
    this.organizeImage,
    required this.followers,
    required this.eventType,
    required this.userId,
    required this.totalSeats,
    required this.availableSeats,
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
    required this.seats,
    required this.customFields,
  });

  factory GetMyPersonalEventsModel.fromJson(Map<String, dynamic> json) =>
      GetMyPersonalEventsModel(
        id: json["id"],
        eventsPic: json["events_pic"],
        eventTitle: json["event_title"],
        price: json["price"],
        about: json["about"],
        location: json["location"],
        lattitude: json["lattitude"],
        longitude: json["longitude"],
        eventRelevantVideo: json["event_relevant_video"],
        tags: json["tags"],
        eventOrganizer: json["event_organizer"],
        organizeImage: json["organize_image"],
        followers: json["followers"],
        eventType: json["event_type"],
        userId: json["user_id"],
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
        seats: List<dynamic>.from(json["seats"].map((x) => x)),
        customFields: List<dynamic>.from(json["custom_fields"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "events_pic": eventsPic,
        "event_title": eventTitle,
        "price": price,
        "about": about,
        "location": location,
        "lattitude": lattitude,
        "longitude": longitude,
        "event_relevant_video": eventRelevantVideo,
        "tags": tags,
        "event_organizer": eventOrganizer,
        "organize_image": organizeImage,
        "followers": followers,
        "event_type": eventType,
        "user_id": userId,
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
        "seats": List<dynamic>.from(seats.map((x) => x)),
        "custom_fields": List<dynamic>.from(customFields.map((x) => x)),
      };
}
