import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quickie_event/Quicke_Events/Models/GetEventSeatsModel.dart';
import 'package:quickie_event/Quicke_Events/Models/GetEventTicketsModel.dart';
import 'package:quickie_event/Quicke_Events/Models/GetEventsModel.dart';

class EventProvider with ChangeNotifier {
  List<GetEventsModel> getEventsModel = [];
  mGetEvents() async {
    List<GetEventsModel> getEventsModel = [];
    var headers = {
      'Authorization':
          'Bearer PivvPlsQWxPl1bB5KrbKNBuraJit0PrUZekQUgtLyTRuyBq921atFtoR1HuA'
    };
    var request = http.Request(
        'GET', Uri.parse('http://quickeeapi.pakwexpo.com/api/events'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String value = await response.stream.bytesToString();
      getEventsModel = getEventsModelFromJson(value);
      this.getEventsModel = getEventsModel;
      notifyListeners();
    } else {
      print(response.reasonPhrase);
    }
  }

  List<GetEventTicketsModel> getEventTicketsModel = [];
  bool checkValueEventTicket = false;
  mGetEventTickets({required String id}) async {
    List<GetEventTicketsModel> getEventTicketsModel = [];
    checkValueEventTicket = true;
    notifyListeners();
    var headers = {
      'Authorization':
          'Bearer PivvPlsQWxPl1bB5KrbKNBuraJit0PrUZekQUgtLyTRuyBq921atFtoR1HuA'
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
      'Authorization':
          'Bearer PivvPlsQWxPl1bB5KrbKNBuraJit0PrUZekQUgtLyTRuyBq921atFtoR1HuA'
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
}
