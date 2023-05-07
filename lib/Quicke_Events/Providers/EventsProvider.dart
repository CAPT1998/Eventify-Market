import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quickie_event/Quicke_Events/Models/GetEventSeatsModel.dart';
import 'package:quickie_event/Quicke_Events/Models/GetEventTicketsModel.dart';
import 'package:quickie_event/Quicke_Events/Models/GetEventsModel.dart';
import 'package:quickie_event/Quicke_Events/Models/ReservationModel.dart';

class EventProvider with ChangeNotifier {
  List<GetEventsModel> getEventsModel = [];
  bool checkValueEvent = false;
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

  mSubtractSeatList({required int id,required String name}) {
    int index =
        reservationModel!.seatId!.indexWhere((element) => element == id);
    reservationModel!.seatId!.removeAt(index);
     int index12 =
        reservationModel!.seatName!.indexWhere((element) => element == name);
    reservationModel!.seatName!.removeAt(index12);
    notifyListeners();
  }

  String reservationMessage = "";
  mAddReservation() async {
    String reservationMessage = "";
    String seatId = "";
    reservationModel!.seatId!.forEach((element) {
      seatId += "${element},";
    });
    var headers = {
      'Authorization':
          'Bearer PivvPlsQWxPl1bB5KrbKNBuraJit0PrUZekQUgtLyTRuyBq921atFtoR1HuA'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('http://quickeeapi.pakwexpo.com/api/reservation'));
    request.fields.addAll({
      'seat_type_status': '${reservationModel!.seatTypeStatus}',
      'event_id': '${reservationModel!.eventId}',
      'ticket_id': '${reservationModel!.ticketId}',
      'user_id': '${reservationModel!.userId}',
      'seat_id': '$seatId',
      'payment_method': 'Paypal'
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
}
