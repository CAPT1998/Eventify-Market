import 'dart:convert';

List<Getfavoriteevents> getMyEventsModelFromJson(String str) =>
    List<Getfavoriteevents>.from(
        json.decode(str).map((x) => Getfavoriteevents.fromJson(x)));

String getMyEventsModelToJson(List<Getfavoriteevents> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Getfavoriteevents {
  final int? id;
  final dynamic eventsPic;
  final String? eventTitle;
  final String? price;
  final String? about;
  final String? latitude;
  final String? longitude;
  final dynamic eventRelevantVideo;
  final dynamic tags;
  final String? followers;
  final String? eventType;
  final String? userId;
  final String? totalSeats;
  final String? availableSeats;
  final dynamic reserveSeats;
  final dynamic ticketsType;
  final dynamic limit;
  final dynamic sortNo;
  final String? eventStartTime;
  final String? eventEndTime;
  final String? eventStartDate;
  final String? eventEndDate;
  final dynamic eventCatId;
  final String? createdAt;
  final String? updatedAt;
  final String? organizerId;
  final List<dynamic>? customFields;
  final Pivot? pivot;
  EventOrganizer? eventOrganizer;

  Getfavoriteevents(
      {this.id,
      this.eventsPic,
      this.eventTitle,
      this.price,
      this.about,
      this.latitude,
      this.longitude,
      this.eventRelevantVideo,
      this.tags,
      this.followers,
      this.eventType,
      this.userId,
      this.totalSeats,
      this.availableSeats,
      this.reserveSeats,
      this.ticketsType,
      this.limit,
      this.sortNo,
      this.eventStartTime,
      this.eventEndTime,
      this.eventStartDate,
      this.eventEndDate,
      this.eventCatId,
      this.createdAt,
      this.updatedAt,
      this.organizerId,
      this.customFields,
      this.pivot,
      this.eventOrganizer});

  Getfavoriteevents.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        eventsPic = json['events_pic'],
        eventTitle = json['event_title'] as String?,
        price = json['price'] as String?,
        about = json['about'] as String?,
        latitude = json['lattitude'] as String?,
        longitude = json['longitude'] as String?,
        eventRelevantVideo = json['event_relevant_video'],
        tags = json['tags'],
        followers = json['followers'] as String?,
        eventType = json['event_type'] as String?,
        userId = json['user_id'] as String?,
        totalSeats = json['total_seats'] as String?,
        availableSeats = json['available_seats'] as String?,
        reserveSeats = json['reserve_seats'],
        ticketsType = json['tickets_type'],
        limit = json['limit'],
        sortNo = json['sort_no'],
        eventStartTime = json['event_start_time'] as String?,
        eventEndTime = json['event_end_time'] as String?,
        eventStartDate = json['event_start_date'] as String?,
        eventEndDate = json['event_end_date'] as String?,
        eventCatId = json['event_cat_id'],
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?,
        organizerId = json['organizer_id'] as String?,
        customFields = json['custom_fields'] as List?,
        pivot = (json['pivot'] as Map<String, dynamic>?) != null
            ? Pivot.fromJson(json['pivot'] as Map<String, dynamic>)
            : null,
        eventOrganizer = json['event_organizer'] != null
            ? EventOrganizer.fromJson(json['event_organizer'])
            : null;

  Map<String, dynamic> toJson() => {
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
        'total_seats': totalSeats,
        'available_seats': availableSeats,
        'reserve_seats': reserveSeats,
        'tickets_type': ticketsType,
        'limit': limit,
        'sort_no': sortNo,
        'event_start_time': eventStartTime,
        'event_end_time': eventEndTime,
        'event_start_date': eventStartDate,
        'event_end_date': eventEndDate,
        'event_cat_id': eventCatId,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'organizer_id': organizerId,
        'custom_fields': customFields,
        'pivot': pivot?.toJson(),
        'event_organizer': eventOrganizer!.toJson(),
      };
}

class Pivot {
  final String? userId;
  final String? eventId;

  Pivot({
    this.userId,
    this.eventId,
  });

  Pivot.fromJson(Map<String, dynamic> json)
      : userId = json['user_id'] as String?,
        eventId = json['event_id'] as String?;

  Map<String, dynamic> toJson() => {'user_id': userId, 'event_id': eventId};
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
