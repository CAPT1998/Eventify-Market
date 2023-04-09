// To parse this JSON data, do
//
//     final getEventsModel = getEventsModelFromJson(jsonString);

import 'dart:convert';

List<GetEventsModel> getEventsModelFromJson(String str) => List<GetEventsModel>.from(json.decode(str).map((x) => GetEventsModel.fromJson(x)));

String getEventsModelToJson(List<GetEventsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetEventsModel {
    GetEventsModel({
        required this.id,
        required this.eventsPic,
        required this.eventTitle,
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
        required this.eventStartTime,
        required this.eventEndTime,
        required this.eventStartDate,
        required this.eventEndDate,
        required this.eventCatId,
        required this.createdAt,
        required this.updatedAt,
        required this.seatingPlans,
    });

    int id;
    String eventsPic;
    String eventTitle;
    String price;
    String about;
    String location;
    String eventRelevantVideo;
    List<String> tags;
    String eventOrganizer;
    String totalSeats;
    String availableSeats;
    String reserveSeats;
    String ticketsType;
    String limit;
    String sortNo;
    String eventStartTime;
    String eventEndTime;
    DateTime eventStartDate;
    DateTime eventEndDate;
    String eventCatId;
    DateTime createdAt;
    DateTime updatedAt;
    List<SeatingPlan> seatingPlans;

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
        seatingPlans: List<SeatingPlan>.from(json["seating_plans"].map((x) => SeatingPlan.fromJson(x))),
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
        "event_start_date": "${eventStartDate.year.toString().padLeft(4, '0')}-${eventStartDate.month.toString().padLeft(2, '0')}-${eventStartDate.day.toString().padLeft(2, '0')}",
        "event_end_date": "${eventEndDate.year.toString().padLeft(4, '0')}-${eventEndDate.month.toString().padLeft(2, '0')}-${eventEndDate.day.toString().padLeft(2, '0')}",
        "event_cat_id": eventCatId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "seating_plans": List<dynamic>.from(seatingPlans.map((x) => x.toJson())),
    };
}

class SeatingPlan {
    SeatingPlan({
        required this.id,
        required this.seatRowName,
        required this.seatsPerRow,
        required this.eventId,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
        required this.seatingPlanDetails,
    });

    int id;
    String seatRowName;
    String seatsPerRow;
    String eventId;
    String status;
    DateTime createdAt;
    DateTime updatedAt;
    List<SeatingPlanDetail> seatingPlanDetails;

    factory SeatingPlan.fromJson(Map<String, dynamic> json) => SeatingPlan(
        id: json["id"],
        seatRowName: json["seat_row_name"],
        seatsPerRow: json["seats_per_row"],
        eventId: json["event_id"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        seatingPlanDetails: List<SeatingPlanDetail>.from(json["seating_plan_details"].map((x) => SeatingPlanDetail.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "seat_row_name": seatRowName,
        "seats_per_row": seatsPerRow,
        "event_id": eventId,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "seating_plan_details": List<dynamic>.from(seatingPlanDetails.map((x) => x.toJson())),
    };
}

class SeatingPlanDetail {
    SeatingPlanDetail({
        required this.id,
        required this.seatType,
        required this.seatNo,
        required this.price,
        required this.seatStatus,
        required this.status,
        required this.seatingPlanId,
        required this.createdAt,
        required this.updatedAt,
    });

    int id;
    String seatType;
    String seatNo;
    String price;
    String seatStatus;
    String status;
    String seatingPlanId;
    DateTime createdAt;
    DateTime updatedAt;

    factory SeatingPlanDetail.fromJson(Map<String, dynamic> json) => SeatingPlanDetail(
        id: json["id"],
        seatType: json["seat_type"],
        seatNo: json["seat_no"],
        price: json["price"],
        seatStatus: json["seat_status"],
        status: json["status"],
        seatingPlanId: json["seating_plan_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "seat_type": seatType,
        "seat_no": seatNo,
        "price": price,
        "seat_status": seatStatus,
        "status": status,
        "seating_plan_id": seatingPlanId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
