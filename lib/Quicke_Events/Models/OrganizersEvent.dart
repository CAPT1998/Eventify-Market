class OrganizerEvent {
  final String? message;
  final List<OrganizerEventDetails>? organizerEventDetails;

  OrganizerEvent({
    this.message,
    this.organizerEventDetails,
  });

  OrganizerEvent.fromJson(Map<String, dynamic> json)
      : message = json['message'] as String?,
        organizerEventDetails = (json['Organizer_event_details'] as List?)
            ?.map((dynamic e) =>
                OrganizerEventDetails.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => {
        'message': message,
        'Organizer_event_details':
            organizerEventDetails?.map((e) => e.toJson()).toList()
      };
}

class OrganizerEventDetails {
  final int? id;
  final String? eventsPic;
  final String? eventTitle;
  final String? price;
  final String? about;
  final String? location;
  final dynamic lattitude;
  final dynamic longitude;
  final String? eventRelevantVideo;
  final String? tags;
  final String? eventOrganizer;
  final dynamic organizeImage;
  final dynamic followers;
  final dynamic eventType;
  final dynamic userId;
  final String? totalSeats;
  final String? availableSeats;
  final String? reserveSeats;
  final String? ticketsType;
  final String? limit;
  final String? sortNo;
  final String? eventStartTime;
  final String? eventEndTime;
  final String? eventStartDate;
  final String? eventEndDate;
  final String? eventCatId;
  final String? createdAt;
  final String? updatedAt;
  final List<dynamic>? customFields;

  OrganizerEventDetails({
    this.id,
    this.eventsPic,
    this.eventTitle,
    this.price,
    this.about,
    this.location,
    this.lattitude,
    this.longitude,
    this.eventRelevantVideo,
    this.tags,
    this.eventOrganizer,
    this.organizeImage,
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
    this.customFields,
  });

  OrganizerEventDetails.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        eventsPic = json['events_pic'] as String?,
        eventTitle = json['event_title'] as String?,
        price = json['price'] as String?,
        about = json['about'] as String?,
        location = json['location'] as String?,
        lattitude = json['lattitude'],
        longitude = json['longitude'],
        eventRelevantVideo = json['event_relevant_video'] as String?,
        tags = json['tags'] as String?,
        eventOrganizer = json['event_organizer'] as String?,
        organizeImage = json['organize_image'],
        followers = json['followers'],
        eventType = json['event_type'],
        userId = json['user_id'],
        totalSeats = json['total_seats'] as String?,
        availableSeats = json['available_seats'] as String?,
        reserveSeats = json['reserve_seats'] as String?,
        ticketsType = json['tickets_type'] as String?,
        limit = json['limit'] as String?,
        sortNo = json['sort_no'] as String?,
        eventStartTime = json['event_start_time'] as String?,
        eventEndTime = json['event_end_time'] as String?,
        eventStartDate = json['event_start_date'] as String?,
        eventEndDate = json['event_end_date'] as String?,
        eventCatId = json['event_cat_id'] as String?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?,
        customFields = json['custom_fields'] as List?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'events_pic': eventsPic,
        'event_title': eventTitle,
        'price': price,
        'about': about,
        'location': location,
        'lattitude': lattitude,
        'longitude': longitude,
        'event_relevant_video': eventRelevantVideo,
        'tags': tags,
        'event_organizer': eventOrganizer,
        'organize_image': organizeImage,
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
        'custom_fields': customFields
      };
}
