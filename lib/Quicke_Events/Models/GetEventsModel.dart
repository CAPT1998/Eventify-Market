// To parse this JSON data, do
//
//     final getEventsModel = getEventsModelFromJson(jsonString);

import 'dart:convert';

List<GetEventsModel> getEventsModelFromJson(String str) => List<GetEventsModel>.from(json.decode(str).map((x) => GetEventsModel.fromJson(x)));

String getEventsModelToJson(List<GetEventsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetEventsModel {
    GetEventsModel({
        required this.id,
        required this.eventName,
        required this.eventsPic,
        required this.timing,
        required this.date,
        required this.price,
        required this.about,
        required this.location,
        required this.eventRelevantVideo,
        required this.tags,
        required this.eventOrganizer,
        required this.totalSeats,
        required this.availableSeats,
        required this.reserveSeats,
        required this.ticketsType,
        required this.limit,
        required this.sortNo,
        required this.createdAt,
        required this.updatedAt,
    });

    int id;
    String eventName;
    String eventsPic;
    String timing;
    DateTime date;
    String price;
    String about;
    String location;
    String eventRelevantVideo;
    String tags;
    String eventOrganizer;
    String totalSeats;
    String availableSeats;
    String reserveSeats;
    String ticketsType;
    String limit;
    String sortNo;
    DateTime createdAt;
    DateTime updatedAt;

    factory GetEventsModel.fromJson(Map<String, dynamic> json) => GetEventsModel(
        id: json["id"],
        eventName: json["event_name"],
        eventsPic: json["events_pic"],
        timing: json["timing"],
        date: DateTime.parse(json["date"]),
        price: json["price"],
        about: json["about"],
        location: json["location"],
        eventRelevantVideo: json["event_relevant_video"],
        tags: json["tags"],
        eventOrganizer: json["event_organizer"],
        totalSeats: json["total_seats"],
        availableSeats: json["available_seats"],
        reserveSeats: json["reserve_seats"],
        ticketsType: json["tickets_type"],
        limit: json["limit"],
        sortNo: json["sort_no"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "event_name": eventName,
        "events_pic": eventsPic,
        "timing": timing,
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "price": price,
        "about": about,
        "location": location,
        "event_relevant_video": eventRelevantVideo,
        "tags": tags,
        "event_organizer": eventOrganizer,
        "total_seats": totalSeats,
        "available_seats": availableSeats,
        "reserve_seats": reserveSeats,
        "tickets_type": ticketsType,
        "limit": limit,
        "sort_no": sortNo,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
