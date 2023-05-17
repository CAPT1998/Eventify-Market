class PostInvitationResponseModel {
  String? message;
  Invitation? invitation;

  PostInvitationResponseModel({this.message, this.invitation});

  PostInvitationResponseModel.fromJson(Map<String, dynamic> json) {
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
  String? eventId;
  String? userId;
  String? receiverId;
  String? receiverName;
  String? updatedAt;
  String? createdAt;
  int? id;

  Invitation(
      {this.eventId,
        this.userId,
        this.receiverId,
        this.receiverName,
        this.updatedAt,
        this.createdAt,
        this.id});

  Invitation.fromJson(Map<String, dynamic> json) {
    eventId = json['event_id'];
    userId = json['user_id'];
    receiverId = json['receiver_id'];
    receiverName = json['receiver_name'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['event_id'] = this.eventId;
    data['user_id'] = this.userId;
    data['receiver_id'] = this.receiverId;
    data['receiver_name'] = this.receiverName;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
