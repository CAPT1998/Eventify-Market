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

import '../../Constant.dart';
import '../../helper/storage_helper.dart';
import '../Models/CollectionsModel.dart';
import '../Models/GetEventOrganizerResponseModel.dart';
import '../Models/GetFavoriteEvents.dart';
import '../Models/GetMyEventsReponseModel.dart';
import '../Models/GetSingleEventReponseModel.dart';
import '../Models/GetUsersListModel.dart';
import '../Models/OrganizersEvent.dart';
import '../Models/RequestInvitationActionReponseModel.dart';
import '../Models/UserFavoriteOrganizer.dart';
import '../Widgets/api_url.dart';

class EventProvider with ChangeNotifier {
  List<GetEventsModel> getEventsModel = [];
  List<CollectionModel> collectionsmodel = [];
  List<UserFavoriteOrganizer> favoriteorganizers = [];
  List<UserFavoriteOrganizer> followingorganizers = [];
  List<CollectionModel> favoritecollection = [];
  List<CollectionModel> categoryevents = [];

  List<OrganizerEvent> organizerEventDetails2 = [];
  List<Getfavoriteevents> favoriteevents = [];
  String? followersText;
  //List<GetOrganizersEventsModel> OrganizerEventDetails = [];

  bool checkValueEvent = false;

  mGetEvents() async {
    List<GetEventsModel> getEventsModel = [];
    var headers = {
      'Authorization':
          "Bearer " + (Storage.getJWT().isEmpty ? "" : Storage.getJWT())
    };
    var request =
        http.Request('GET', Uri.parse('${AppUrl.baseUrl}/events/public'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String value = await response.stream.bytesToString();
      print(value);
      List<dynamic> jsonResponse = json.decode(value);
      List<GetEventsModel> getEventsModelList =
          jsonResponse.map<GetEventsModel>((eventData) {
        return GetEventsModel.fromJson(eventData);
      }).toList();

      this.getEventsModel = getEventsModelList;
      checkValueEvent = true;
      notifyListeners();
    } else {
      checkValueEvent = true;
      notifyListeners();
      print(response.reasonPhrase);
    }
  }

  getFavoriteEvents(String userid) async {
    List<Getfavoriteevents> favoriteevents = [];
    var headers = {
      'Authorization':
          "Bearer " + (Storage.getJWT().isEmpty ? "" : Storage.getJWT())
    };
    var request = http.Request(
        'GET', Uri.parse('${AppUrl.baseUrl}/users/$userid/favorite-events'));

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String value = await response.stream.bytesToString();

      Map<String, dynamic> jsonResponse = json.decode(value);
      List<dynamic> eventDataList = jsonResponse['data'];
      favoriteevents = eventDataList
          .map((eventData) => Getfavoriteevents.fromJson(eventData))
          .toList();
      this.favoriteevents = favoriteevents;
      // checkValueEvent = true;
      print(eventDataList.toString());

      notifyListeners();
    } else {
      notifyListeners();
      print(response.reasonPhrase);
    }
  }

  deleteFavoriteEvents(context, dynamic userid, dynamic eventid) async {
    print(eventid);
    print("dele fav event");
    print(userid);
    var headers = {
      'Authorization':
          "Bearer " + (Storage.getJWT().isEmpty ? "" : Storage.getJWT())
    };
    var request = http.Request('DELETE',
        Uri.parse('${AppUrl.baseUrl}/users/$userid/events/$eventid/favorite'));

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    print("done");

    var responseData = await response.stream.bytesToString();

    var jsonData = json.decode(responseData);
    String message = jsonData["message"];
    notifyListeners();

    SuccessFlushbar(
      context,
      "Success",
      "Event removed from favorites",
    );
  }

  addFavoriteEvents(context, dynamic userid, dynamic eventid) async {
    print(eventid);
    print("add fav event");
    print(userid);
    var headers = {
      'Authorization':
          "Bearer " + (Storage.getJWT().isEmpty ? "" : Storage.getJWT())
    };
    var request = http.Request('POST',
        Uri.parse('${AppUrl.baseUrl}/events/$eventid/favorite/$userid'));

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    var responseData = await response.stream.bytesToString();

    var jsonData = json.decode(responseData);
    String message = jsonData["message"];
    notifyListeners();

    SuccessFlushbar(
      context,
      "Success",
      "Event added to favorites",
    );
  }

  followorganizer(context, dynamic userid, dynamic organizerid) async {
    print(organizerid);
    print("organizer follow");
    print(userid);
    var headers = {
      'Authorization':
          "Bearer " + (Storage.getJWT().isEmpty ? "" : Storage.getJWT())
    };
    var request = http.Request('POST',
        Uri.parse('${AppUrl.baseUrl}/organizers/$organizerid/follow/$userid'));

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    print(response.statusCode);

    print("donde");
    print(response.stream);

    var responseData = await response.stream.bytesToString();

    var jsonData = json.decode(responseData);
    String message = jsonData["message"];
    var followercount = jsonData["followers_count"];
    int followerCountValue = followercount ?? 0;
    followersText = "$followerCountValue Followers";
    notifyListeners();

    SuccessFlushbar(
      context,
      "Success",
      message,
    );
  }

  unfolloworganizer(context, dynamic userid, dynamic organizerid) async {
    print(organizerid);
    print("organizer follow");
    print(userid);
    var headers = {
      'Authorization':
          "Bearer " + (Storage.getJWT().isEmpty ? "" : Storage.getJWT())
    };
    var request = http.Request(
        'DELETE',
        Uri.parse(
            '${AppUrl.baseUrl}/organizers/$organizerid/unfollow/$userid'));

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print("donde");
      print(response.stream);

      var responseData = await response.stream.bytesToString();

      var jsonData = json.decode(responseData);
      String message = jsonData["message"];
      var followercount = jsonData["followers_count"];
      int followerCountValue = followercount ?? 0;
      followersText = "$followerCountValue Followers";
      notifyListeners();

      SuccessFlushbar(
        context,
        "Success",
        message,
      );
    }
  }

  fetchOrganizerEvents() async {
    List<OrganizerEvent> organizerEventDetails2 = [];

    final url = '${AppUrl.baseUrl}/organizer';
    var headers = {
      'Authorization':
          "Bearer " + (Storage.getJWT().isEmpty ? "" : Storage.getJWT())
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);
        List<dynamic> eventDetailsJson = jsonBody['Organizer_event_details'];

        organizerEventDetails2 = eventDetailsJson
            .map((json) => OrganizerEvent.fromJson(json))
            .toList();

        this.organizerEventDetails2 = organizerEventDetails2;
        print(organizerEventDetails2);
        notifyListeners();
      } else {}
    } catch (e) {}
  }

  List<GetEventTicketsModel> getEventTicketsModel = [];
  bool checkValueEventTicket = false;

  mGetEventTickets({required String id}) async {
    List<GetEventTicketsModel> getEventTicketsModel = [];
    this.getEventTicketsModel.clear();
    checkValueEventTicket = true;
    print(id);
    print(getEventTicketsModel.length);
    //notifyListeners();
    var headers = {
      'Authorization':
          "Bearer " + (Storage.getJWT().isEmpty ? "" : Storage.getJWT())
    };
    var request = http.MultipartRequest(
        'GET', Uri.parse('${AppUrl.baseUrl}/tickets/$id'));
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
      'Authorization':
          "Bearer " + (Storage.getJWT().isEmpty ? "" : Storage.getJWT())
    };
    var request =
        http.MultipartRequest('GET', Uri.parse('${AppUrl.baseUrl}/seat/$id'));

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
      'Authorization':
          "Bearer " + (Storage.getJWT().isEmpty ? "" : Storage.getJWT())
    };
    var request =
        http.Request('POST', Uri.parse('${AppUrl.baseUrl}/reservation'));
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

  Future<String> mSendInvitation(String eventId, String userId,
      String receiverId, String recieverName) async {
    var headers = {
      "Content-Type": "application/x-www-form-urlencoded",
      'Authorization':
          "Bearer " + (Storage.getJWT().isEmpty ? "" : Storage.getJWT())
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${AppUrl.baseUrl}/invitation'));

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
    } catch (e) {
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
      List<dynamic> locations = await locationFromAddress("${eventLocation}");
      var headers = {
        'Authorization':
            "Bearer " + (Storage.getJWT().isEmpty ? "" : Storage.getJWT())
      };
      var request =
          http.MultipartRequest('POST', Uri.parse('${AppUrl.baseUrl}/events'));
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
  late GetMyEventsResponseModel getMyEvent;
  late GetSingleEventReponseModel getSingleEventDetail;
  GetEventOrganizerResponseModel? getEventOrganizer;
  bool checkValueMyEvents = false;

  mPersonalEvents() async {
    List<GetMyPersonalEventsModel> getMyPersonalEvent = [];
    checkValueMyEvents = true;
    notifyListeners();
    var headers = {
      'Authorization':
          "Bearer " + (Storage.getJWT().isEmpty ? "" : Storage.getJWT())
    };
    var request = http.MultipartRequest(
        'GET', Uri.parse('${AppUrl.baseUrl}/events/1/find/private'));

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
    GetMyEventsResponseModel getMyEvent;
    /*  checkValueMyEvents = true;
    notifyListeners();*/
    var headers = {
      'Authorization':
          "Bearer " + (Storage.getJWT().isEmpty ? "" : Storage.getJWT())
    };
    final response = await http.get(Uri.parse('${AppUrl.baseUrl}/invitation'),
        headers: headers);
    // request.headers.addAll(headers);
    try {
      // http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        // String value = await response.stream.bytesToString();
        // getMyEvent = getMyEventsModelFromJson(value);
        getMyEvent =
            GetMyEventsResponseModel.fromJson(jsonDecode(response.body));

        this.getMyEvent = getMyEvent;
        checkValueMyEvents = false;
        notifyListeners();
      } else {
        print(response.reasonPhrase);
        checkValueMyEvents = false;
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  getSingleEvent(String eventId) async {
    GetSingleEventReponseModel getMyEvent;
    /*  checkValueMyEvents = true;
    notifyListeners();*/
    var headers = {
      'Authorization':
          "Bearer " + (Storage.getJWT().isEmpty ? "" : Storage.getJWT())
    };
    final response = await http.post(Uri.parse('${AppUrl.baseUrl}/events/find'),
        headers: headers,
        body: {
          "id": eventId,
          "api_key": (Storage.getJWT().isEmpty ? "" : Storage.getJWT())
        });
    // request.headers.addAll(headers);
    try {
      // http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        // String value = await response.stream.bytesToString();
        // getMyEvent = getMyEventsModelFromJson(value);
        getMyEvent =
            GetSingleEventReponseModel.fromJson(jsonDecode(response.body));

        this.getSingleEventDetail = getMyEvent;
        // checkValueMyEvents = false;
        notifyListeners();
      } else {
        print(response.reasonPhrase);
        // checkValueMyEvents = false;
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  getEventOrganizers() async {
    GetEventOrganizerResponseModel getMyEvent;
    /*  checkValueMyEvents = true;
    notifyListeners();*/
    var headers = {
      'Authorization':
          "Bearer " + (Storage.getJWT().isEmpty ? "" : Storage.getJWT())
    };
    final response = await http.get(Uri.parse('${AppUrl.baseUrl}/organizer'),
        headers: headers);
    // request.headers.addAll(headers);
    try {
      // http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        // String value = await response.stream.bytesToString();
        // getMyEvent = getMyEventsModelFromJson(value);
        getMyEvent =
            GetEventOrganizerResponseModel.fromJson(jsonDecode(response.body));

        this.getEventOrganizer = getMyEvent;
        // checkValueMyEvents = false;
        notifyListeners();
      } else {
        print(response.reasonPhrase);
        // checkValueMyEvents = false;
        notifyListeners();
      }
    } catch (e) {
      print("Exception: " + e.toString());
    }
  }

  Future<String> postSingleEventAction(String eventId, String status) async {
    RequestInvitationActionReponseModel getMyEvent;
    /*  checkValueMyEvents = true;
    notifyListeners();*/
    var headers = {
      'Authorization':
          "Bearer " + (Storage.getJWT().isEmpty ? "" : Storage.getJWT())
    };
    final response = await http.post(
        Uri.parse('${AppUrl.baseUrl}/invitation/status'),
        headers: headers,
        body: {
          "id": eventId,
          "status": status,
          "api_key": (Storage.getJWT().isEmpty ? "" : Storage.getJWT())
        });
    // request.headers.addAll(headers);
    try {
      // http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        // String value = await response.stream.bytesToString();
        // getMyEvent = getMyEventsModelFromJson(value);
        print(response.body);
        getMyEvent = RequestInvitationActionReponseModel.fromJson(
            jsonDecode(response.body));

        // checkValueMyEvents = false;
        return "Success";
      } else {
        print(response.reasonPhrase);
        // checkValueMyEvents = false
        return "Failure";
      }
    } catch (e) {
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
      'Authorization':
          "Bearer " + (Storage.getJWT().isEmpty ? "" : Storage.getJWT())
    };
    var response = await http.get(Uri.parse('${AppUrl.baseUrl}/users/list'),
        headers: headers);

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
      'Authorization':
          "Bearer " + (Storage.getJWT().isEmpty ? "" : Storage.getJWT())
    };
    var request =
        http.MultipartRequest('GET', Uri.parse('${AppUrl.baseUrl}/table/$id'));
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
    print("here");

    var headers = {
      'Authorization':
          "Bearer " + (Storage.getJWT().isEmpty ? "" : Storage.getJWT())
    };

    var request = http.MultipartRequest(
        'GET', Uri.parse('${AppUrl.baseUrl}/events/1/find'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    print("here");
    print(response.statusCode);

    if (response.statusCode == 200) {
      String value = await response.stream.bytesToString();
      print(value);
      getEventSeatHsitoryModel = getEventSeatHistoryModelFromJson(value);
      this.getEventSeatHsitoryModel = getEventSeatHsitoryModel;
      notifyListeners();
    } else {
      print(response.reasonPhrase);
    }
  }

  getcollectionevets() async {
    List<CollectionModel> collectionsmodel = [];
    var headers = {
      'Authorization':
          "Bearer " + (Storage.getJWT().isEmpty ? "" : Storage.getJWT())
    };
    var request =
        http.Request('GET', Uri.parse('${AppUrl.baseUrl}/collections'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String value = await response.stream.bytesToString();
      print(value);
      Map<String, dynamic> jsonResponse = json.decode(value);
      List<dynamic> eventDataList = jsonResponse['data'];
      collectionsmodel = eventDataList
          .map((eventData) => CollectionModel.fromJson(eventData))
          .toList();
      this.collectionsmodel = collectionsmodel;
      notifyListeners();
    } else {
      notifyListeners();
      print(response.reasonPhrase);
    }
  }

  addFavoriteOrganizer(context, dynamic userid, dynamic organizerid) async {
    print(organizerid);
    print("add fav organizer");
    print(userid);
    var headers = {
      'Authorization':
          "Bearer " + (Storage.getJWT().isEmpty ? "" : Storage.getJWT())
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            '${AppUrl.baseUrl}/users/$userid/organizers/$organizerid/favorite'));

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    var responseData = await response.stream.bytesToString();

    var jsonData = json.decode(responseData);
    String message = jsonData["message"];
    notifyListeners();

    SuccessFlushbar(
      context,
      "Success",
      message,
    );
  }

  getFavoriteOrganzers(String userid) async {
    List<UserFavoriteOrganizer> favoriteorganizers = [];
    var headers = {
      'Authorization':
          "Bearer " + (Storage.getJWT().isEmpty ? "" : Storage.getJWT())
    };
    var request = http.Request('GET',
        Uri.parse('${AppUrl.baseUrl}/users/$userid/favorite-organizers'));

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String value = await response.stream.bytesToString();

      Map<String, dynamic> jsonResponse = json.decode(value);
      List<dynamic> eventDataList = jsonResponse['data'];
      favoriteorganizers = eventDataList
          .map((eventData) => UserFavoriteOrganizer.fromJson(eventData))
          .toList();
      this.favoriteorganizers = favoriteorganizers;
      // checkValueEvent = true;
      print(eventDataList.toString());

      notifyListeners();
    } else {
      notifyListeners();
      print(response.reasonPhrase);
    }
  }

  removeFavoriteOrganizer(context, dynamic userid, dynamic organizerid) async {
    print(organizerid);
    print("remov fav organizer");
    print(userid);
    var headers = {
      'Authorization':
          "Bearer " + (Storage.getJWT().isEmpty ? "" : Storage.getJWT())
    };
    var request = http.Request('DELETE',
        Uri.parse('${AppUrl.baseUrl}/users/$userid/organizers/$organizerid'));

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    var responseData = await response.stream.bytesToString();

    var jsonData = json.decode(responseData);
    String message = jsonData["message"];
    notifyListeners();

    SuccessFlushbar(
      context,
      "Success",
      message,
    );
  }

  getFollowingOrganzers(String userid) async {
    List<UserFavoriteOrganizer> followingorganizers = [];
    var headers = {
      'Authorization':
          "Bearer " + (Storage.getJWT().isEmpty ? "" : Storage.getJWT())
    };
    var request = http.Request('GET',
        Uri.parse('${AppUrl.baseUrl}/users/$userid/followed-organizers'));

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String value = await response.stream.bytesToString();

      Map<String, dynamic> jsonResponse = json.decode(value);
      List<dynamic> eventDataList = jsonResponse['data'];
      followingorganizers = eventDataList
          .map((eventData) => UserFavoriteOrganizer.fromJson(eventData))
          .toList();
      this.followingorganizers = followingorganizers;
      // checkValueEvent = true;
      print(eventDataList.toString());

      notifyListeners();
    } else {
      notifyListeners();
      print(response.reasonPhrase);
    }
  }

  addFavoritecollection(context, dynamic userid, dynamic collectionid) async {
    print(collectionid);
    print("add fav collection");
    print(userid);
    var headers = {
      'Authorization':
          "Bearer " + (Storage.getJWT().isEmpty ? "" : Storage.getJWT())
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            '${AppUrl.baseUrl}/users/$userid/collections/$collectionid/favorite'));

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    var responseData = await response.stream.bytesToString();

    var jsonData = json.decode(responseData);
    String message = jsonData["message"];
    notifyListeners();

    SuccessFlushbar(
      context,
      "Success",
      message,
    );
  }

  removeFavoritecollection(
      context, dynamic userid, dynamic collectionid) async {
    print(collectionid);
    print("remov fav collection");
    print(userid);
    var headers = {
      'Authorization':
          "Bearer " + (Storage.getJWT().isEmpty ? "" : Storage.getJWT())
    };
    var request = http.Request(
        'DELETE',
        Uri.parse(
            '${AppUrl.baseUrl}/users/$userid/collections/$collectionid/favorite'));

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    var responseData = await response.stream.bytesToString();

    var jsonData = json.decode(responseData);
    String message = jsonData["message"];
    notifyListeners();

    SuccessFlushbar(
      context,
      "Success",
      message,
    );
  }

  getFavoritecollection(String userid) async {
    List<CollectionModel> favoritecollection = [];
    var headers = {
      'Authorization':
          "Bearer " + (Storage.getJWT().isEmpty ? "" : Storage.getJWT())
    };
    var request = http.Request('GET',
        Uri.parse('${AppUrl.baseUrl}/users/$userid/favorite-collections'));

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String value = await response.stream.bytesToString();

      Map<String, dynamic> jsonResponse = json.decode(value);
      List<dynamic> eventDataList = jsonResponse['data'];
      favoritecollection = eventDataList
          .map((eventData) => CollectionModel.fromJson(eventData))
          .toList();
      this.favoritecollection = favoritecollection;
      // checkValueEvent = true;
      print(eventDataList.toString());

      notifyListeners();
    } else {
      notifyListeners();
      print(response.reasonPhrase);
    }
  }
}
