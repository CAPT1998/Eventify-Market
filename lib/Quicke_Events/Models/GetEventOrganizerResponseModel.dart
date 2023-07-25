class GetEventOrganizerResponseModel {
  String? message;
  List<String>? organizer;

  GetEventOrganizerResponseModel({this.message, this.organizer});

  GetEventOrganizerResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    organizer = json['Organizer_event_details'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['Organizer'] = this.organizer;
    return data;
  }
}
