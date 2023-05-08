import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quickie_event/Quicke_Events/Models/GetCategoryModel.dart';

class CategoryPRovider with ChangeNotifier {
  List<GetCategoryModel> getcategoryMode = [];
  bool checkValueCategory = false;
  mGetCategory() async {
    List<GetCategoryModel> getcategoryMode = [];
     checkValueCategory = true;
    notifyListeners();
    var headers = {
      'Authorization':
          'Bearer PivvPlsQWxPl1bB5KrbKNBuraJit0PrUZekQUgtLyTRuyBq921atFtoR1HuA'
    };
    var request = http.MultipartRequest('GET',
        Uri.parse('https://quickeeapi.pakwexpo.com/api/event/categories'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String value = await response.stream.bytesToString();
      getcategoryMode = getCategoryModelFromJson(value);
      this.getcategoryMode = getcategoryMode;
      checkValueCategory = false;
      notifyListeners();
    } else {
      print(response.reasonPhrase);
      checkValueCategory = false;
      notifyListeners();
    }
  }
}
