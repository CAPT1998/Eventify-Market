// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
    LoginModel({
        required this.success,
        required this.data,
        required this.message,
    });

    bool success;
    Data data;
    String message;

    factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        success: json["success"],
        data: Data.fromJson(json["data"]),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
        "message": message,
    };
}

class Data {
    Data({
        required this.id,
        required this.name,
        required this.email,
        required this.apiToken,
        this.cardBrand,
        this.cardLastFour,
        this.paypalEmail,
        required this.createdAt,
        required this.updatedAt,
        this.phone,
        this.address,
        this.gender,
        this.language,
        this.dateOfBirth,
        required this.hasMedia,
        required this.media,
    });

    int id;
    String name;
    String email;
    String apiToken;
    dynamic cardBrand;
    dynamic cardLastFour;
    dynamic paypalEmail;
    DateTime createdAt;
    DateTime updatedAt;
    dynamic phone;
    dynamic address;
    dynamic gender;
    dynamic language;
    dynamic dateOfBirth;
    bool hasMedia;
    List<dynamic> media;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        apiToken: json["api_token"],
        cardBrand: json["card_brand"],
        cardLastFour: json["card_last_four"],
        paypalEmail: json["paypal_email"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        phone: json["phone"],
        address: json["address"],
        gender: json["gender"],
        language: json["language"],
        dateOfBirth: json["date_of_birth"],
        hasMedia: json["has_media"],
        media: List<dynamic>.from(json["media"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "api_token": apiToken,
        "card_brand": cardBrand,
        "card_last_four": cardLastFour,
        "paypal_email": paypalEmail,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "phone": phone,
        "address": address,
        "gender": gender,
        "language": language,
        "date_of_birth": dateOfBirth,
        "has_media": hasMedia,
        "media": List<dynamic>.from(media.map((x) => x)),
    };
}
