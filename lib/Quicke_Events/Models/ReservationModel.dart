import 'dart:collection';

import 'package:flutter/material.dart';

class ReservationModel {
  String? eventId;
  List<dynamic>? seatId;
  String? ticketId;
  String? userId;
  String? seatTypeStatus;
  String? paymentMethod;
  List<String>? seatName;
  int quantity;
  int? price;
  ReservationModel({
    this.eventId,
    this.seatId,
    this.ticketId,
    this.userId,
    this.seatTypeStatus,
    this.seatName,
    this.paymentMethod,
    this.quantity = 1,
    this.price,
  });
  factory ReservationModel.fromJson(Map<String, dynamic> parsedJson) {
    return ReservationModel(
      eventId: parsedJson["eventId"],
      seatId: parsedJson["seatId"],
      ticketId: parsedJson["ticketId"],
      userId: parsedJson["userId"],
      seatTypeStatus: parsedJson["seatTypeStatus"],
      paymentMethod: parsedJson["paymentMethod"],
      quantity: parsedJson["quantity"],
      price: parsedJson["price"],
      seatName: parsedJson["seatName"],
    );
  }
  Map<String, dynamic> ReservationToMap() {
    Map<String, dynamic> map = HashMap<String, dynamic>();
    map["eventId"] = this.eventId;
    map["seatId"] = this.seatId;
    map["ticketId"] = this.ticketId;
    map["userId"] = this.userId;
    map["seatTypeStatus"] = this.seatTypeStatus;
    map["paymentMethod"] = this.paymentMethod;
    map["quantity"] = this.quantity;
    map["price"] = this.price;
    map["seatName"] = this.seatName;
    return map;
  }
}
