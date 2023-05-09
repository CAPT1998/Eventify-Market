import 'dart:convert';

List<GetEventTableModel> getEventTableModelFromJson(String str) => List<GetEventTableModel>.from(json.decode(str).map((x) => GetEventTableModel.fromJson(x)));

String getEventTableModelToJson(List<GetEventTableModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetEventTableModel {
    int id;
    String tableName;
    String eventId;
    DateTime createdAt;
    DateTime updatedAt;
    List<SeatingPlanDetail> seatingPlanDetails;

    GetEventTableModel({
        required this.id,
        required this.tableName,
        required this.eventId,
        required this.createdAt,
        required this.updatedAt,
        required this.seatingPlanDetails,
    });

    factory GetEventTableModel.fromJson(Map<String, dynamic> json) => GetEventTableModel(
        id: json["id"],
        tableName: json["table_name"],
        eventId: json["event_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        seatingPlanDetails: List<SeatingPlanDetail>.from(json["seating_plan_details"].map((x) => SeatingPlanDetail.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "table_name": tableName,
        "event_id": eventId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "seating_plan_details": List<dynamic>.from(seatingPlanDetails.map((x) => x.toJson())),
    };
}

class SeatingPlanDetail {
    int id;
    String tableId;
    String ticketId;
    String seatNo;
    String seatStatus;
    String status;
    dynamic seatingPlanId;
    DateTime createdAt;
    DateTime updatedAt;

    SeatingPlanDetail({
        required this.id,
        required this.tableId,
        required this.ticketId,
        required this.seatNo,
        required this.seatStatus,
        required this.status,
        this.seatingPlanId,
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
