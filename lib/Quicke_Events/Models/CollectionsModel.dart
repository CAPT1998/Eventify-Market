import 'dart:convert';

List<CollectionModel> collectionModelFromJson(String str) =>
    List<CollectionModel>.from(
        json.decode(str).map((x) => CollectionModel.fromJson(x)));

class CollectionModel {
  final int? id;
  final String? name;
  final String? createdAt;
  final String? updatedAt;
  final int? upcomingEventsCount;
  final List<UpcomingEvents>? upcomingEvents;
  final Organizer? organizer;

  CollectionModel({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.upcomingEventsCount,
    this.upcomingEvents,
    this.organizer,
  });

  CollectionModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?,
        upcomingEventsCount = json['upcoming_events_count'] as int?,
        upcomingEvents = (json['upcoming_events'] as List?)
            ?.map((dynamic e) =>
                UpcomingEvents.fromJson(e as Map<String, dynamic>))
            .toList(),
        organizer = (json['organizer'] as Map<String, dynamic>?) != null
            ? Organizer.fromJson(json['organizer'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'upcoming_events_count': upcomingEventsCount,
        'upcoming_events': upcomingEvents?.map((e) => e.toJson()).toList()
      };
}

class Organizer {
  final int? id;
  final String? organizerName;
  final String? organizerImage;
  final String? createdAt;
  final String? updatedAt;
  final String? bio;
  final dynamic location;
  final String? collectionId;
  final List<Events>? events;

  Organizer({
    this.id,
    this.organizerName,
    this.organizerImage,
    this.createdAt,
    this.updatedAt,
    this.bio,
    this.location,
    this.collectionId,
    this.events,
  });

  Organizer.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        organizerName = json['organizer_name'] as String?,
        organizerImage = json['organizer_image'] as String?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?,
        bio = json['bio'] as String?,
        location = json['location'],
        collectionId = json['collection_id'] as String?,
        events = (json['events'] as List?)
            ?.map((dynamic e) => Events.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => {
        'id': id,
        'organizer_name': organizerName,
        'organizer_image': organizerImage,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'bio': bio,
        'location': location,
        'collection_id': collectionId,
        'events': events?.map((e) => e.toJson()).toList()
      };
}

class Events {
  final int? id;
  final dynamic eventsPic;
  final String? eventTitle;
  final String? price;
  final String? about;
  final String? lattitude;
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
  final String? collectionId;
  final List<dynamic>? customFields;

  Events({
    this.id,
    this.eventsPic,
    this.eventTitle,
    this.price,
    this.about,
    this.lattitude,
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
    this.collectionId,
    this.customFields,
  });

  Events.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        eventsPic = json['events_pic'],
        eventTitle = json['event_title'] as String?,
        price = json['price'] as String?,
        about = json['about'] as String?,
        lattitude = json['lattitude'] as String?,
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
        collectionId = json['collection_id'] as String?,
        customFields = json['custom_fields'] as List?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'events_pic': eventsPic,
        'event_title': eventTitle,
        'price': price,
        'about': about,
        'lattitude': lattitude,
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
        'collection_id': collectionId,
        'custom_fields': customFields
      };
}

class UpcomingEvents {
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
  final String? collectionId;
  final List<dynamic>? customFields;
  final EventOrganizer? eventOrganizer;

  UpcomingEvents({
    this.id,
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
    this.collectionId,
    this.customFields,
    this.eventOrganizer,
  });

  UpcomingEvents.fromJson(Map<String, dynamic> json)
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
        collectionId = json['collection_id'] as String?,
        customFields = json['custom_fields'] as List?,
        eventOrganizer =
            (json['event_organizer'] as Map<String, dynamic>?) != null
                ? EventOrganizer.fromJson(
                    json['event_organizer'] as Map<String, dynamic>)
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
        'collection_id': collectionId,
        'custom_fields': customFields,
        'event_organizer': eventOrganizer?.toJson()
      };
}

class EventOrganizer {
  final int? id;
  final String? organizerName;
  final String? organizerImage;
  final String? createdAt;
  final String? updatedAt;
  final String? bio;
  final dynamic location;
  final String? collectionId;

  EventOrganizer({
    this.id,
    this.organizerName,
    this.organizerImage,
    this.createdAt,
    this.updatedAt,
    this.bio,
    this.location,
    this.collectionId,
  });

  EventOrganizer.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        organizerName = json['organizer_name'] as String?,
        organizerImage = json['organizer_image'] as String?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?,
        bio = json['bio'] as String?,
        location = json['location'],
        collectionId = json['collection_id'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'organizer_name': organizerName,
        'organizer_image': organizerImage,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'bio': bio,
        'location': location,
        'collection_id': collectionId
      };
}
