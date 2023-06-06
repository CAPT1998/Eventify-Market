import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:quickie_event/Quicke_Events/Models/GetEventSeatHistoryModel.dart';
import 'package:quickie_event/Quicke_Events/Models/GetEventSeatsModel.dart';
import 'package:quickie_event/Quicke_Events/Models/GetEventTableModel.dart';
import 'package:quickie_event/Quicke_Events/Models/GetEventTicketsModel.dart';
import 'package:quickie_event/Quicke_Events/Models/GetEventsModel.dart';
import 'package:quickie_event/Quicke_Events/Models/GetMyPersonalEventsModel.dart';
import 'package:quickie_event/Quicke_Events/Models/ReservationModel.dart';

import '../../helper/storage_helper.dart';
import '../Models/GetEventOrganizerResponseModel.dart';
import '../Models/GetMyEventsReponseModel.dart';
import '../Models/GetSingleEventReponseModel.dart';
import '../Models/GetUsersListModel.dart';
import '../Models/RequestInvitationActionReponseModel.dart';

class EventProvider with ChangeNotifier {
  List<GetEventsModel> getEventsModel = [];
  bool checkValueEvent = false;

  mGetEvents() async {
    List<GetEventsModel> getEventsModel = [];
    var headers = {
      'Authorization': "Bearer " + (Storage.getJWT().isEmpty ? "" : Storage.getJWT())
    };
    var request = http.Request(
        'GET', Uri.parse('http://quickeeapi.pakwexpo.com/api/events/public'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String value = await response.stream.bytesToString();
      getEventsModel = getEventsModelFromJson(value);
      this.getEventsModel = getEventsModel;
      checkValueEvent = true;
      notifyListeners();
    } else {
      checkValueEvent = true;
      notifyListeners();
      print(response.reasonPhrase);
    }
  }

  List<GetEventTicketsModel> getEventTicketsModel = [];
  bool checkValueEventTicket = false;

  mGetEventTickets({required String id}) async {
    List<GetEventTicketsModel> getEventTicketsModel = [];
    this.getEventTicketsModel.clear();
    checkValueEventTicket = true;
    print(id);
    print(getEventTicketsModel.length);
    notifyListeners();
    var headers = {
      'Authorization': "Bearer " + (Storage.getJWT().isEmpty ? "" : Storage.getJWT())
    };
    var request = http.MultipartRequest(
        'GET', Uri.parse('http://quickeeapi.pakwexpo.com/api/tickets/$id'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String value = await response.stream.bytesToString();
      getEventTicketsModel = getEventTicketsModelFromJson(value);
      this.getEventTicketsModel = getEventTicketsModel;
      checkValueEventTicket = false;
      notifyListeners();
    } else {
      checkValueEventTicket = false;
      notifyListeners();
      print(response.reasonPhrase);
    }
  }

  int? selectTicketIndex;

  mupdateSelectTicket({required int index}) {
    this.selectTicketIndex = index;
    notifyListeners();
  }

  List<GetEventSeatsModel> getEventSeatsModel = [];
  bool checkValueEventSeats = false;

  mGetEventSeats({required String id}) async {
    List<GetEventSeatsModel> getEventSeatsModel = [];
    checkValueEventSeats = true;
    var headers = {
      'Authorization': "Bearer " + (Storage.getJWT().isEmpty ? "" : Storage.getJWT())
    };
    var request = http.MultipartRequest(
        'GET', Uri.parse('http://quickeeapi.pakwexpo.com/api/seat/$id'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String value = await response.stream.bytesToString();
      getEventSeatsModel = getEventSeatsModelFromJson(value);
      this.getEventSeatsModel = getEventSeatsModel;
      checkValueEventSeats = false;
      notifyListeners();
    } else {
      checkValueEventSeats = false;
      notifyListeners();
      print(response.reasonPhrase);
    }
  }

  ReservationModel? reservationModel;

  mupdateEventAndTicket(
      {required String eventId, required String ticketId, required int price}) {
    print("12");
    reservationModel = ReservationModel(
      eventId: eventId,
      ticketId: ticketId,
      price: price,
      quantity: 1,
      paymentMethod: "Paypal",
      seatId: [],
      userId: "1",
      seatName: [],
      seatTypeStatus: "1",
    );

    notifyListeners();
  }

  mAddQuantityTicket() {
    reservationModel!.quantity++;
    notifyListeners();
  }

  mSubtractRicket() {
    reservationModel!.quantity--;
    notifyListeners();
  }

  mAddSeatList({required int id, required String name}) {
    reservationModel!.seatId!.add(id);
    reservationModel!.seatName!.add(name);
    notifyListeners();
  }

  mSubtractSeatList({required int id, required String name}) {
    int index =
        reservationModel!.seatId!.indexWhere((element) => element == id);
    reservationModel!.seatId!.removeAt(index);
    int index12 =
        reservationModel!.seatName!.indexWhere((element) => element == name);
    reservationModel!.seatName!.removeAt(index12);
    notifyListeners();
  }

  String reservationMessage = "";
  String inviteMessage = "";

  mAddReservation() async {
    String reservationMessage = "";
    String seatId = "";
    reservationModel!.seatId!.forEach((element) {
      seatId += "${element},";
    });
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer " + (Storage.getJWT().isEmpty ? "" : Storage.getJWT())
    };
    var request = http.Request(
        'POST', Uri.parse('http://quickeeapi.pakwexpo.com/api/reservation'));
    request.body = json.encode({
      "seat_id": reservationModel!.seatId,
      "status": 1,
      "event_id": '${reservationModel!.eventId}',
      "ticket_id": '${reservationModel!.ticketId}',
      "payment_method": "Paypal",
      "user_id": '${reservationModel!.userId}',
      "seat_type_status": '${reservationModel!.seatTypeStatus}'
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      reservationMessage = "success";
      this.reservationMessage = reservationMessage;
      reservationModel = null;
      notifyListeners();
    } else {
      print(response.reasonPhrase);
      reservationMessage = "unsuccess";
      this.reservationMessage = reservationMessage;
      notifyListeners();
    }
  }

 Future<String> mSendInvitation(String eventId,String userId,String receiverId,String recieverName) async {

    var headers = {
      "Content-Type": "application/x-www-form-urlencoded",
      'Authorization': "Bearer " + (Storage.getJWT().isEmpty ? "" : Storage.getJWT())
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('http://quickeeapi.pakwexpo.com/api/invitation'));

    request.fields.addAll({
      'event_id': '$eventId',
      'user_id': '$userId',
      'receiver_id': '$receiverId',
      'receiver_name': '$recieverName',

    });

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    try {
  if (response.statusCode == 200) {
    inviteMessage = "success";
    this.inviteMessage = inviteMessage;
    notifyListeners();
    return inviteMessage;
  } else {
    print(response.reasonPhrase);
    inviteMessage = "unsuccess";
    this.inviteMessage = inviteMessage;
    notifyListeners();
    return inviteMessage;
  }
}catch(e){
  print(e);
  return "unsuccess";
}
  }

  String? eventFileName;
  var eventFileBytes;
  File? eventFile;

  muppdateeventBytes(String eventFileName, var eventFileBytes, File eventFile) {
    this.eventFileName = eventFileName;
    this.eventFileBytes = eventFileBytes;
    this.eventFile = eventFile;
    notifyListeners();
  }

  String checkMessageEventCreate = "";

  mCreatePrivateEvent({
    required String eventTitle,
    required String eventStartDate,
    required String eventEndDate,
    required String eventEventStartTime,
    required String eventEventEndTime,
    required String eventLocation,
    required String eventAbout,
    // required int catid,
  }) async {
    String checkMessageEventCreate = "";
    try {
      List<Location> locations = await locationFromAddress("${eventLocation}");
      var headers = {
        'Authorization': "Bearer " + (Storage.getJWT().isEmpty ? "" : Storage.getJWT())
      };
      var request = http.MultipartRequest(
          'POST', Uri.parse('http://quickeeapi.pakwexpo.com/api/events'));
      request.fields.addAll({
        'event_name': '$eventTitle',
        'event_start_time': '$eventEventStartTime',
        'event_start_date': '$eventStartDate',
        'about': '$eventAbout',
        'event_organizer': 'sd',
        'followers': '5',
        'user_id': '1',
        'location': '$eventLocation',
        'lattitude': '${locations.first.latitude}',
        'longitude': '${locations.first.longitude}',
        'event_title': '$eventTitle',
        'event_end_time': '$eventEventEndTime',
        'event_end_date': '$eventEventEndTime',
        'tickets_type': 'Private'
      });
      request.files.add(await http.MultipartFile.fromPath(
          'events_pic', '${eventFile!.path}'));
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
        checkMessageEventCreate = "success";
        this.checkMessageEventCreate = checkMessageEventCreate;
        notifyListeners();
      } else {
        print(await response.stream.bytesToString());
        print(response.reasonPhrase);
        checkMessageEventCreate = "unsuccess";
        this.checkMessageEventCreate = checkMessageEventCreate;
        notifyListeners();
      }
    } catch (e) {
      checkMessageEventCreate = "unsuccess";
      this.checkMessageEventCreate = checkMessageEventCreate;
      notifyListeners();
    }
  }

  TextEditingController eventLocation = TextEditingController();

  mUpdateLocationAddress(String address) {
    eventLocation = TextEditingController(text: address);
    notifyListeners();
  }

  List<GetMyPersonalEventsModel> getMyPersonalEvent = [];
  late GetMyEventsResponseModel getMyEvent ;
  late GetSingleEventReponseModel getSingleEventDetail ;
   GetEventOrganizerResponseModel? getEventOrganizer ;
  bool checkValueMyEvents = false;

  mPersonalEvents() async {
    List<GetMyPersonalEventsModel> getMyPersonalEvent = [];
    checkValueMyEvents = true;
    notifyListeners();
    var headers = {
      'Authorization': "Bearer " + (Storage.getJWT().isEmpty ? "" : Storage.getJWT())
    };
    var request = http.MultipartRequest('GET',
        Uri.parse('https://quickeeapi.pakwexpo.com/api/events/1/find/private'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String value = await response.stream.bytesToString();
      getMyPersonalEvent = getMyPersonalEventsModelFromJson(value);
      this.getMyPersonalEvent = getMyPersonalEvent;
      checkValueMyEvents = false;
      notifyListeners();
    } else {
      print(response.reasonPhrase);
      checkValueMyEvents = false;
      notifyListeners();
    }
  }
  mEvents() async {
   GetMyEventsResponseModel getMyEvent ;
  /*  checkValueMyEvents = true;
    notifyListeners();*/
    var headers = {
      'Authorization': "Bearer " + (Storage.getJWT().isEmpty ? "" : Storage.getJWT())
    };
    // var request = http.MultipartRequest('GET',
    //     Uri.parse('http://quickeeapi.pakwexpo.com/api/invitation'));
    final response = await http
        .get(Uri.parse('http://quickeeapi.pakwexpo.com/api/invitation'),headers: headers);
    // request.headers.addAll(headers);
try {
  // http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    // String value = await response.stream.bytesToString();
    // getMyEvent = getMyEventsModelFromJson(value);
    getMyEvent= GetMyEventsResponseModel.fromJson(jsonDecode(response.body));

    this.getMyEvent = getMyEvent;
    checkValueMyEvents = false;
    notifyListeners();
  } else {
    print(response.reasonPhrase);
    checkValueMyEvents = false;
    notifyListeners();
  }
}catch(e){
  print(e);
}
  }

  getSingleEvent(String eventId) async {
    GetSingleEventReponseModel getMyEvent ;
    /*  checkValueMyEvents = true;
    notifyListeners();*/
    var headers = {
      'Authorization': "Bearer " + (Storage.getJWT().isEmpty ? "" : Storage.getJWT())
    };
    // var request = http.MultipartRequest('GET',
    //     Uri.parse('http://quickeeapi.pakwexpo.com/api/invitation'));
    final response = await http
        .post(Uri.parse('http://quickeeapi.pakwexpo.com/api/events/find'),headers: headers,body: {
          "id":eventId,
          "api_key":(Storage.getJWT().isEmpty ? "" : Storage.getJWT())
    });
    // request.headers.addAll(headers);
    try {
      // http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        // String value = await response.stream.bytesToString();
        // getMyEvent = getMyEventsModelFromJson(value);
        getMyEvent= GetSingleEventReponseModel.fromJson(jsonDecode(response.body));

        this.getSingleEventDetail = getMyEvent;
        // checkValueMyEvents = false;
        notifyListeners();
      } else {
        print(response.reasonPhrase);
        // checkValueMyEvents = false;
        notifyListeners();
      }
    }catch(e){
      print(e);
    }
  }
  getEventOrganizers() async {
    GetEventOrganizerResponseModel getMyEvent ;
    /*  checkValueMyEvents = true;
    notifyListeners();*/
    var headers = {
      'Authorization': "Bearer " + (Storage.getJWT().isEmpty ? "" : Storage.getJWT())
    };
    // var request = http.MultipartRequest('GET',
    //     Uri.parse('http://quickeeapi.pakwexpo.com/api/invitation'));
    final response = await http
        .get(Uri.parse('http://quickeeapi.pakwexpo.com/api/organizer'),headers: headers);
    // request.headers.addAll(headers);
    try {
      // http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {

        // String value = await response.stream.bytesToString();
        // getMyEvent = getMyEventsModelFromJson(value);
        getMyEvent= GetEventOrganizerResponseModel.fromJson(jsonDecode(response.body));

        this.getEventOrganizer = getMyEvent;
        // checkValueMyEvents = false;
        notifyListeners();
      } else {
        print(response.reasonPhrase);
        // checkValueMyEvents = false;
        notifyListeners();
      }
    }catch(e){
      print("Exception: "+e.toString());
    }
  }
 Future<String> postSingleEventAction(String eventId,String status) async {
    RequestInvitationActionReponseModel getMyEvent ;
    /*  checkValueMyEvents = true;
    notifyListeners();*/
    var headers = {
      'Authorization': "Bearer " + (Storage.getJWT().isEmpty ? "" : Storage.getJWT())
    };
    // var request = http.MultipartRequest('GET',
    //     Uri.parse('http://quickeeapi.pakwexpo.com/api/invitation'));
    final response = await http
        .post(Uri.parse('http://quickeeapi.pakwexpo.com/api/invitation/status'),headers: headers,body: {
      "id":eventId,
      "status":status,
      "api_key":(Storage.getJWT().isEmpty ? "" : Storage.getJWT())
    });
    // request.headers.addAll(headers);
    try {
      // http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        // String value = await response.stream.bytesToString();
        // getMyEvent = getMyEventsModelFromJson(value);
        print(response.body);
        getMyEvent= RequestInvitationActionReponseModel.fromJson(jsonDecode(response.body));

        // checkValueMyEvents = false;
        return "Success";
      } else {
        print(response.reasonPhrase);
        // checkValueMyEvents = false
        return "Failure";

      }
    }catch(e){
      print(e);
      return "Something went wrong";
    }
  }

  List<GetUsersListModel> getUserList = [];

  bool checkValueUsers = false;

  mGetUsers() async {
    List<GetUsersListModel> getUserList = [];
    checkValueUsers = true;
    // notifyListeners();
    var headers = {
      'Authorization': "Bearer " + (Storage.getJWT().isEmpty ? "" : Storage.getJWT())
    };
    var response = await http.get(
        Uri.parse('http://quickeeapi.pakwexpo.com/api/users/list'),headers: headers);

    // var request = http.MultipartRequest(
    //     'GET', Uri.parse('http://quickeeapi.pakwexpo.com/api/users/list'));
    //
    // request.headers.addAll(headers);

    // http.StreamedResponse response = await request.send();
    try {
      if (response.statusCode == 200) {
        // getUserList = getUserListModelFromJson(value);
        // String value = await response.stream.bytesToString();

        // var body = jsonDecode(response.stream.bytesToString());
        print(response.body);
        //
        //
        // List jsonResponse = json.decode(response.body);
        // List<GetUsersListModel> post= jsonResponse.map((job) =>  GetUsersListModel.fromJson(job)).toList();

        List<GetUsersListModel> posts = productsResponseFromJson(response.body);
        // print(posts[0].name);

        this.getUserList = posts;
        checkValueUsers = false;
        notifyListeners();
      } else {
        print(response.reasonPhrase);
        checkValueUsers = false;
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  List<GetEventTableModel> getEventTableModel = [];

  mGetTablesEvent({required String id}) async {
    List<GetEventTableModel> getEventTableModel = [];
    var headers = {
      'Authorization': "Bearer " + (Storage.getJWT().isEmpty ? "" : Storage.getJWT())
    };
    var request = http.MultipartRequest(
        'GET', Uri.parse('http://quickeeapi.pakwexpo.com/api/table/$id'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String value = await response.stream.bytesToString();
      getEventTableModel = getEventTableModelFromJson(value);
      this.getEventTableModel = getEventTableModel;
      notifyListeners();
    } else {
      print(response.reasonPhrase);
    }
  }

  List<GetEventSeatHistoryModel> getEventSeatHsitoryModel = [];

  mGetEventSeatHistory() async {
    List<GetEventSeatHistoryModel> getEventSeatHsitoryModel = [];
    var headers = {
      'Authorization': "Bearer " + (Storage.getJWT().isEmpty ? "" : Storage.getJWT())
    };

    var request = http.MultipartRequest(
        'GET', Uri.parse('http://quickeeapi.pakwexpo.com/api/events/1/find'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String value = await response.stream.bytesToString();
      getEventSeatHsitoryModel = getEventSeatHistoryModelFromJson(value);
      this.getEventSeatHsitoryModel = getEventSeatHsitoryModel;
      notifyListeners();
    } else {
      print(response.reasonPhrase);
    }
  }
}
