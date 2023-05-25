class RequestInvitationActionReponseModel {
  String? message;
  Invitation? invitation;

  RequestInvitationActionReponseModel({this.message, this.invitation});

  RequestInvitationActionReponseModel.fromJson(Map<String, dynamic> json) {
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
  String? userId;
  String? eventId;
  String? receiverId;
  String? receiverName;
  String? status;
  String? createdAt;
  String? updatedAt;

  Invitation(
      {this.id,
        this.userId,
        this.eventId,
        this.receiverId,
        this.receiverName,
        this.status,
        this.createdAt,
        this.updatedAt});

  Invitation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    eventId = json['event_id'];
    receiverId = json['receiver_id'];
    receiverName = json['receiver_name'];
    status = json['status'];
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
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
