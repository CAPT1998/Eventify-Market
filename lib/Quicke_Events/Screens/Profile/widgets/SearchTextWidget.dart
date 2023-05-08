import 'package:flutter/material.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import 'package:quickie_event/Constant.dart';
import 'package:quickie_event/Quicke_Events/Providers/EventsProvider.dart';

class SearchBarWidget extends StatelessWidget {
  final String searchIcon = "assets/icons/search_icon.svg";
  @override
  Widget build(BuildContext context) {
    return Consumer<EventProvider>(builder: (_, provider, child) {
      return TypeAheadField(
        getImmediateSuggestions: true,
        textFieldConfiguration: TextFieldConfiguration(
          textAlignVertical: TextAlignVertical.center,
          autofocus: false,
          controller: provider.eventLocation,
          decoration: InputDecoration(
            alignLabelWithHint: true,
            labelText: "Location",
            labelStyle: Theme.of(context).textTheme.bodyText1!.merge(
                  TextStyle(color: Color.fromARGB(255, 61, 61, 61)),
                ),
            filled: true,
            fillColor: Colors.grey[50],
            border: InputBorder.none,
            errorBorder: OutlineInputBorder(
                borderRadius:
                    const BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: Colors.red)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius:
                    const BorderRadius.all(const Radius.circular(10.0)),
                borderSide: BorderSide(color: appColor)),
            enabledBorder: OutlineInputBorder(
                borderRadius:
                    const BorderRadius.all(const Radius.circular(10.0)),
                borderSide: BorderSide(color: Color(0XFFB8BCBF))),
            focusedBorder: OutlineInputBorder(
                borderRadius:
                    const BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: appColor)),
          ),
        ),
        suggestionsCallback: (pattern) async {
          return await BackendService.getSuggestions(pattern, pattern);
        },
        loadingBuilder: (context) {
          return CircularProgressIndicator();
        },
        itemBuilder: (context, suggestion) {
          // products_Model map = suggestion as products_Model;
          return ListTile(
            tileColor: Colors.white,
            title: Text(suggestion as String),
          );
        },
        onSuggestionSelected: (suggestion) {
          provider.mUpdateLocationAddress(suggestion as String);
        },
      );
    });
  }
}

List<AutocompletePrediction> predictions = [];

class BackendService {
  static Future<List<String>> getSuggestions(String query, name) async {
    if (query.length > 3) {
      final places = await FlutterGooglePlacesSdk(
          'AIzaSyB3AJ346V-wawHGxPZaeG5ZMndcXeVLCEU');
      FindAutocompletePredictionsResponse predictions =
          await places.findAutocompletePredictions(query);
      // print(predictions.predictions);
      return predictions.predictions.map((e) => e.fullText).toList();
    } else {
      return [];
    }
  }
}
