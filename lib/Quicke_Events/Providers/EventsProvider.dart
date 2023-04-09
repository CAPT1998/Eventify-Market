import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
        'GET', Uri.parse('http://quickeeapi.pakwexpo.com/api/event/details/1'));
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
}
