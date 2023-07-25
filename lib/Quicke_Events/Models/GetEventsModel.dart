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
  String latitude;
  String longitude;
  String? eventRelevantVideo;
  String? tags;
  String followers;
  String eventType;
  String userId;
  int totalSeats;
  int availableSeats;
  String? reserveSeats;
  String? ticketsType;
  String? limit;
  String? sortNo;
  String eventStartTime;
  String eventEndTime;
  String eventStartDate;
  String eventEndDate;
  String? eventCatId;
  DateTime createdAt;
  DateTime updatedAt;
  int organizerId;
  List<dynamic> customFields;
  EventOrganizer? eventOrganizer;

  GetEventsModel({
    required this.id,
    this.eventsPic,
    required this.eventTitle,
    required this.price,
    required this.about,
    required this.latitude,
    required this.longitude,
    this.eventRelevantVideo,
    this.tags,
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
    required this.organizerId,
    required this.customFields,
    required this.eventOrganizer,
  });

  factory GetEventsModel.fromJson(Map<String, dynamic> json) {
    return GetEventsModel(
      id: json['id'],
      eventsPic: json['events_pic'],
      eventTitle: json['event_title'],
      price: json['price'] ?? "50",
      about: json['about'],
      latitude: json['lattitude'],
      longitude: json['longitude'],
      eventRelevantVideo: json['event_relevant_video'],
      tags: json['tags'],
      followers: json['followers'],
      eventType: json['event_type'],
      userId: json['user_id'],
      totalSeats: int.parse(json['total_seats'] ?? "100"),
      availableSeats: int.parse(json['available_seats'] ?? "50"),
      reserveSeats: json['reserve_seats'] ?? "50",
      ticketsType: json['tickets_type'],
      limit: json['limit'] ?? "",
      sortNo: json['sort_no'] ?? "",
      eventStartTime: json['event_start_time'],
      eventEndTime: json['event_end_time'],
      eventStartDate: json['event_start_date'],
      eventEndDate: json['event_end_date'],
      eventCatId: json['event_cat_id'] ?? "",
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      organizerId: int.parse(json['organizer_id']),
      customFields: json['custom_fields'] ?? [],
      eventOrganizer: json['event_organizer'] != null
          ? EventOrganizer.fromJson(json['event_organizer'])
          : null,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'events_pic': eventsPic,
      'event_title': eventTitle,
      'price': price,
      'about': about,
      'lattitude': latitude,
      'longitude': longitude,
      'event_relevant_video': eventRelevantVideo,
      'tags': tags,
      'followers': followers,
      'event_type': eventType,
      'user_id': userId,
      'total_seats': totalSeats.toString(),
      'available_seats': availableSeats.toString(),
      'reserve_seats': reserveSeats,
      'tickets_type': ticketsType,
      'limit': limit,
      'sort_no': sortNo,
      'event_start_time': eventStartTime,
      'event_end_time': eventEndTime,
      'event_start_date': eventStartDate,
      'event_end_date': eventEndDate,
      'event_cat_id': eventCatId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'organizer_id': organizerId.toString(),
      'custom_fields': customFields,
      'event_organizer': eventOrganizer!.toJson(),
    };
  }
}

class EventOrganizer {
  int id;
  String organizerName;
  String organizerImage;
  DateTime createdAt;
  DateTime updatedAt;
  String? bio;
  String? location;

  EventOrganizer({
    required this.id,
    required this.organizerName,
    required this.organizerImage,
    required this.createdAt,
    required this.updatedAt,
    this.bio,
    this.location,
  });

  factory EventOrganizer.fromJson(Map<String, dynamic> json) {
    return EventOrganizer(
      id: json['id'],
      organizerName: json['organizer_name'],
      organizerImage: json['organizer_image'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      bio: json['bio'],
      location: json['location'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'organizer_name': organizerName,
      'organizer_image': organizerImage,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'bio': bio,
      'location': location,
    };
  }
}
