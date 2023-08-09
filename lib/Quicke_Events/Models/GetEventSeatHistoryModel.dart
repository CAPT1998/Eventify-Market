// To parse this JSON data, do
//
//     final getEventSeatHistoryModel = getEventSeatHistoryModelFromJson(jsonString);

import 'dart:convert';

List<GetEventSeatHistoryModel> getEventSeatHistoryModelFromJson(String str) =>
    List<GetEventSeatHistoryModel>.from(
        json.decode(str).map((x) => GetEventSeatHistoryModel.fromJson(x)));

String getEventSeatHistoryModelToJson(List<GetEventSeatHistoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetEventSeatHistoryModel {
  int id;
  String? eventsPic;
  String eventTitle;
  String price;
  String about;
  String location;
  dynamic lattitude;
  dynamic longitude;
  String? eventRelevantVideo;
  String tags;
  String eventOrganizer;
  dynamic organizeImage;
  dynamic followers;
  dynamic eventType;
  String? userId;
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
  String eventCatId;
  DateTime createdAt;
  DateTime updatedAt;
  List<Seat> seats;
  List<dynamic> customFields;

  GetEventSeatHistoryModel({
    required this.id,
    this.eventsPic,
    required this.eventTitle,
    required this.price,
    required this.about,
    required this.location,
    this.lattitude,
    this.longitude,
    this.eventRelevantVideo,
    required this.tags,
    required this.eventOrganizer,
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
    required this.eventStartTime,
    required this.eventEndTime,
    required this.eventStartDate,
    required this.eventEndDate,
    required this.eventCatId,
    required this.createdAt,
    required this.updatedAt,
    required this.seats,
    required this.customFields,
  });

  factory GetEventSeatHistoryModel.fromJson(Map<String, dynamic> json) =>
      GetEventSeatHistoryModel(
        id: json["id"] ?? 0,
        eventsPic: json["events_pic"] ?? "",
        eventTitle: json["event_title"] ?? "",
        price: json["price"] ?? "",
        about: json["about"] ?? "",
        location: json["location"] ?? "",
        lattitude: json["lattitude"],
        longitude: json["longitude"],
        eventRelevantVideo: json["event_relevant_video"] ?? "",
        tags: json["tags"] ?? "",
        eventOrganizer: json["event_organizer"] ?? "",
        organizeImage: json["organize_image"],
        followers: json["followers"],
        eventType: json["event_type"],
        userId: json["user_id"] ?? "",
        totalSeats: json["total_seats"] ?? "",
        availableSeats: json["available_seats"] ?? "",
        reserveSeats: json["reserve_seats"] ?? "",
        ticketsType: json["tickets_type"] ?? "",
        limit: json["limit"] ?? "",
        sortNo: json["sort_no"] ?? "",
        eventStartTime: json["event_start_time"] ?? "",
        eventEndTime: json["event_end_time"] ?? "",
        eventStartDate: json["event_start_date"] != null
            ? DateTime.parse(json["event_start_date"])
            : DateTime.now(),
        eventEndDate: json["event_end_date"] != null
            ? DateTime.parse(json["event_end_date"])
            : DateTime.now(),
        eventCatId: json["event_cat_id"] ?? "",
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : DateTime.now(),
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"])
            : DateTime.now(),
        seats: (json["seats"] as List<dynamic>? ?? [])
            .map((x) => Seat.fromJson(x))
            .toList(),
        customFields: json["custom_fields"] != null
            ? List<dynamic>.from(json["custom_fields"].map((x) => x))
            : [],
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
        "seats": List<dynamic>.from(seats.map((x) => x.toJson())),
        "custom_fields": List<dynamic>.from(customFields.map((x) => x)),
      };
}

class Seat {
  int id;
  String seatRowName;
  String seatsPerRow;
  dynamic leftSpace;
  dynamic rightSpace;
  dynamic topSpace;
  dynamic bottomSpace;
  dynamic spaceBetweenSeats;
  dynamic roundSeat;
  dynamic roundTable;
  dynamic tableFront;
  dynamic tableLeft;
  dynamic tableRight;
  int eventId;
  String ticketId;
  bool status;
  DateTime createdAt;
  DateTime updatedAt;
  List<dynamic> customFields;
  List<SeatingPlanDetail> seatingPlanDetails;

  Seat({
    required this.id,
    required this.seatRowName,
    required this.seatsPerRow,
    this.leftSpace,
    this.rightSpace,
    this.topSpace,
    this.bottomSpace,
    this.spaceBetweenSeats,
    this.roundSeat,
    this.roundTable,
    this.tableFront,
    this.tableLeft,
    this.tableRight,
    required this.eventId,
    required this.ticketId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.customFields,
    required this.seatingPlanDetails,
  });

  factory Seat.fromJson(Map<String, dynamic> json) => Seat(
        id: json["id"],
        seatRowName: json["seat_row_name"],
        seatsPerRow: json["seats_per_row"],
        leftSpace: json["left_space"],
        rightSpace: json["right_space"],
        topSpace: json["top_space"],
        bottomSpace: json["bottom_space"],
        spaceBetweenSeats: json["space_between_seats"],
        roundSeat: json["round_seat"],
        roundTable: json["round_table"],
        tableFront: json["table_front"],
        tableLeft: json["table_left"],
        tableRight: json["table_right"],
        eventId: json["event_id"],
        ticketId: json["ticket_id"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        customFields: List<dynamic>.from(json["custom_fields"].map((x) => x)),
        seatingPlanDetails: List<SeatingPlanDetail>.from(
            json["seating_plan_details"]
                .map((x) => SeatingPlanDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "seat_row_name": seatRowName,
        "seats_per_row": seatsPerRow,
        "left_space": leftSpace,
        "right_space": rightSpace,
        "top_space": topSpace,
        "bottom_space": bottomSpace,
        "space_between_seats": spaceBetweenSeats,
        "round_seat": roundSeat,
        "round_table": roundTable,
        "table_front": tableFront,
        "table_left": tableLeft,
        "table_right": tableRight,
        "event_id": eventId,
        "ticket_id": ticketId,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "custom_fields": List<dynamic>.from(customFields.map((x) => x)),
        "seating_plan_details":
            List<dynamic>.from(seatingPlanDetails.map((x) => x.toJson())),
      };
}

class SeatingPlanDetail {
  int id;
  dynamic tableId;
  String ticketId;
  String seatNo;
  String seatStatus;
  String status;
  String seatingPlanId;
  DateTime createdAt;
  DateTime updatedAt;

  SeatingPlanDetail({
    required this.id,
    this.tableId,
    required this.ticketId,
    required this.seatNo,
    required this.seatStatus,
    required this.status,
    required this.seatingPlanId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SeatingPlanDetail.fromJson(Map<String, dynamic> json) =>
      SeatingPlanDetail(
        id: json["id"],
        tableId: json["table_id"],
        ticketId: json["ticket_id"],
        seatNo: json["seat_no"],
        seatStatus: json["seat_status"],
        status: json["status"],
        seatingPlanId: json["seating_plan_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "table_id": tableId,
        "ticket_id": ticketId,
        "seat_no": seatNo,
        "seat_status": seatStatus,
        "status": status,
        "seating_plan_id": seatingPlanId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
