// To parse this JSON data, do
//
//     final getEventSeatsModel = getEventSeatsModelFromJson(jsonString);

import 'dart:convert';

List<GetEventSeatsModel> getEventSeatsModelFromJson(String str) => List<GetEventSeatsModel>.from(json.decode(str).map((x) => GetEventSeatsModel.fromJson(x)));

String getEventSeatsModelToJson(List<GetEventSeatsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetEventSeatsModel {
    int id;
    String seatRowName;
    String seatsPerRow;
    int eventId;
    bool status;
    DateTime createdAt;
    DateTime updatedAt;
    List<dynamic> customFields;
    List<SeatingPlanDetail> seatingPlanDetails;

    GetEventSeatsModel({
        required this.id,
        required this.seatRowName,
        required this.seatsPerRow,
        required this.eventId,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
        required this.customFields,
        required this.seatingPlanDetails,
    });

    factory GetEventSeatsModel.fromJson(Map<String, dynamic> json) => GetEventSeatsModel(
        id: json["id"],
        seatRowName: json["seat_row_name"],
        seatsPerRow: json["seats_per_row"],
        eventId: json["event_id"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        customFields: List<dynamic>.from(json["custom_fields"].map((x) => x)),
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
        "custom_fields": List<dynamic>.from(customFields.map((x) => x)),
        "seating_plan_details": List<dynamic>.from(seatingPlanDetails.map((x) => x.toJson())),
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

    factory SeatingPlanDetail.fromJson(Map<String, dynamic> json) => SeatingPlanDetail(
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

