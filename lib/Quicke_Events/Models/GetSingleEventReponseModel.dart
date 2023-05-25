class GetSingleEventReponseModel {
  String? message;
  Invitation? invitation;

  GetSingleEventReponseModel({this.message, this.invitation});

  GetSingleEventReponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    invitation = json['Invitation'] != null
        ? new Invitation.fromJson(json['Invitation'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.invitation != null) {
      data['Invitation'] = this.invitation!.toJson();
    }
    return data;
  }
}

class Invitation {
  int? id;
  String? eventsPic;
  String? eventTitle;
  String? price;
  String? about;
  String? location;
  dynamic? lattitude;
  dynamic? longitude;
  String? eventRelevantVideo;
  String? tags;
  String? eventOrganizer;
  dynamic? organizeImage;
  dynamic? followers;
  dynamic? eventType;
  dynamic? userId;
  String? totalSeats;
  String? availableSeats;
  String? reserveSeats;
  String? ticketsType;
  String? limit;
  String? sortNo;
  String? eventStartTime;
  String? eventEndTime;
  String? eventStartDate;
  String? eventEndDate;
  String? eventCatId;
  String? createdAt;
  String? updatedAt;

  Invitation(
      {this.id,
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
       });

  Invitation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eventsPic = json['events_pic'];
    eventTitle = json['event_title'];
    price = json['price'];
    about = json['about'];
    location = json['location'];
    lattitude = json['lattitude'];
    longitude = json['longitude'];
    eventRelevantVideo = json['event_relevant_video'];
    tags = json['tags'];
    eventOrganizer = json['event_organizer'];
    organizeImage = json['organize_image'];
    followers = json['followers'];
    eventType = json['event_type'];
    userId = json['user_id'];
    totalSeats = json['total_seats'];
    availableSeats = json['available_seats'];
    reserveSeats = json['reserve_seats'];
    ticketsType = json['tickets_type'];
    limit = json['limit'];
    sortNo = json['sort_no'];
    eventStartTime = json['event_start_time'];
    eventEndTime = json['event_end_time'];
    eventStartDate = json['event_start_date'];
    eventEndDate = json['event_end_date'];
    eventCatId = json['event_cat_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['events_pic'] = this.eventsPic;
    data['event_title'] = this.eventTitle;
    data['price'] = this.price;
    data['about'] = this.about;
    data['location'] = this.location;
    data['lattitude'] = this.lattitude;
    data['longitude'] = this.longitude;
    data['event_relevant_video'] = this.eventRelevantVideo;
    data['tags'] = this.tags;
    data['event_organizer'] = this.eventOrganizer;
    data['organize_image'] = this.organizeImage;
    data['followers'] = this.followers;
    data['event_type'] = this.eventType;
    data['user_id'] = this.userId;
    data['total_seats'] = this.totalSeats;
    data['available_seats'] = this.availableSeats;
    data['reserve_seats'] = this.reserveSeats;
    data['tickets_type'] = this.ticketsType;
    data['limit'] = this.limit;
    data['sort_no'] = this.sortNo;
    data['event_start_time'] = this.eventStartTime;
    data['event_end_time'] = this.eventEndTime;
    data['event_start_date'] = this.eventStartDate;
    data['event_end_date'] = this.eventEndDate;
    data['event_cat_id'] = this.eventCatId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;

    return data;
  }
}
