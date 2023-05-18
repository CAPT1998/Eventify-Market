import 'dart:convert';

List<GetMyEventsResponseModel> getMyEventsModelFromJson(String str) =>
    List<GetMyEventsResponseModel>.from(
        json.decode(str).map((x) => GetMyEventsResponseModel.fromJson(x)));

String getMyEventsModelToJson(List<GetMyEventsResponseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetMyEventsResponseModel {
  List<Invitations>? invitations;

  GetMyEventsResponseModel({this.invitations});

  GetMyEventsResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['Invitations'] != null) {
      invitations = <Invitations>[];
      json['Invitations'].forEach((v) {
        invitations!.add(new Invitations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.invitations != null) {
      data['Invitations'] = this.invitations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Invitations {
  int? id;
  String? userId;
  String? eventId;
  String? receiverId;
  String? receiverName;
  String? createdAt;
  String? updatedAt;

  Invitations(
      {this.id,
        this.userId,
        this.eventId,
        this.receiverId,
        this.receiverName,
        this.createdAt,
        this.updatedAt});

  Invitations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    eventId = json['event_id'];
    receiverId = json['receiver_id'];
    receiverName = json['receiver_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['event_id'] = this.eventId;
    data['receiver_id'] = this.receiverId;
    data['receiver_name'] = this.receiverName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
