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
import '../Model/ProductCategoryResponseModel.dart';
import '../Model/ProductDetailResponseModel.dart';
import '../Model/ProductScreenResponseModel.dart';


class HomeProvider with ChangeNotifier {
  ProductCategoryResponseModel? getMyCategories ;
  ProductScreenResponseModel? getProductScreenData ;
  ProductDetailResponseModel? getProductDetailScreenData ;
  bool checkValueEvent = false;

  getProductCategories() async {
    ProductCategoryResponseModel getMyCategories ;
    /*  checkValueMyEvents = true;
    notifyListeners();*/
    var headers = {
      'Authorization': "Bearer " + (Storage.getJWT().isEmpty ? "" : Storage.getJWT())
    };
    // var request = http.MultipartRequest('GET',
    //     Uri.parse('http://quickeeapi.pakwexpo.com/api/invitation'));
    final response = await http
        .get(Uri.parse('http://quickeeapi.pakwexpo.com/api/categories'),headers: headers);
    // request.headers.addAll(headers);
    try {
      // http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        // String value = await response.stream.bytesToString();
        // getMyEvent = getMyEventsModelFromJson(value);
        getMyCategories= ProductCategoryResponseModel.fromJson(jsonDecode(response.body));
        print(jsonDecode(response.body));

        this.getMyCategories = getMyCategories;
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
  getProductScreenDate() async {
    ProductScreenResponseModel getProductScreenData ;
    /*  checkValueMyEvents = true;
    notifyListeners();*/
    var headers = {
      'Authorization': "Bearer " + (Storage.getJWT().isEmpty ? "" : Storage.getJWT())
    };
    // var request = http.MultipartRequest('GET',
    //     Uri.parse('http://quickeeapi.pakwexpo.com/api/invitation'));
    final response = await http
        .get(Uri.parse('http://quickeeapi.pakwexpo.com/api/products/cate'),headers: headers);
    // request.headers.addAll(headers);
    try {
      // http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        // String value = await response.stream.bytesToString();
        // getMyEvent = getMyEventsModelFromJson(value);
        getProductScreenData= ProductScreenResponseModel.fromJson(jsonDecode(response.body));
        print(jsonDecode(response.body));

        this.getProductScreenData = getProductScreenData;
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

  getProductDetailScreenDate(String productId) async {
    ProductDetailResponseModel getProductDetailScreenData ;
    /*  checkValueMyEvents = true;
    notifyListeners();*/
    var headers = {
      'Authorization': "Bearer " + (Storage.getJWT().isEmpty ? "" : Storage.getJWT())
    };
    // var request = http.MultipartRequest('GET',
    //     Uri.parse('http://quickeeapi.pakwexpo.com/api/invitation'));
    final response = await http
        .get(Uri.parse('http://quickeeapi.pakwexpo.com/api/products/category_id/'+productId),headers: headers);
    // request.headers.addAll(headers);
    try {
      // http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        // String value = await response.stream.bytesToString();
        // getMyEvent = getMyEventsModelFromJson(value);
        getProductDetailScreenData= ProductDetailResponseModel.fromJson(jsonDecode(response.body));
        print(jsonDecode(response.body));

        this.getProductDetailScreenData = getProductDetailScreenData;
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

}
