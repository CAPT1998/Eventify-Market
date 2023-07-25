// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

List<LoginModel> loginModelFromJson(String str) {
  final List<dynamic> parsedList = json.decode(str);
  List<LoginModel> loginModels =
      parsedList.map((dynamic item) => LoginModel.fromJson(item)).toList();
  return loginModels;
}

String loginModelToJson(List<LoginModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LoginModel {
  bool? success;
  Data? data;
  String? message;

  LoginModel({
    required this.success,
    required this.data,
    required this.message,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        success: json["success"],
        data: Data.fromJson(json["data"]),
        message: json["message"],
      );
  Map<String, dynamic> toJson() =>
      {'success': success, 'data': data?.toJson(), 'message': message};
}

class Data {
  final int? id;
  final String? name;
  final String? email;
  final String? apiToken;
  final dynamic cardBrand;
  final dynamic cardLastFour;
  final dynamic paypalEmail;
  final String? createdAt;
  final String? updatedAt;
  final dynamic phone;
  final dynamic address;
  final dynamic gender;
  final dynamic language;
  final dynamic dateOfBirth;
  final bool? hasMedia;
  final List<Media>? media;

  Data({
    this.id,
    this.name,
    this.email,
    this.apiToken,
    this.cardBrand,
    this.cardLastFour,
    this.paypalEmail,
    this.createdAt,
    this.updatedAt,
    this.phone,
    this.address,
    this.gender,
    this.language,
    this.dateOfBirth,
    this.hasMedia,
    this.media,
  });

  Data.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        email = json['email'] as String?,
        apiToken = json['api_token'] as String?,
        cardBrand = json['card_brand'],
        cardLastFour = json['card_last_four'],
        paypalEmail = json['paypal_email'],
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?,
        phone = json['phone'],
        address = json['address'],
        gender = json['gender'],
        language = json['language'],
        dateOfBirth = json['date_of_birth'],
        hasMedia = json['has_media'] as bool?,
        media = (json['media'] as List?)
                ?.map((dynamic e) => Media.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [
              Media(
                id: 0,
                url: 'https://example.com/default-image.png',
              ),
            ];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'api_token': apiToken,
        'card_brand': cardBrand,
        'card_last_four': cardLastFour,
        'paypal_email': paypalEmail,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'phone': phone,
        'address': address,
        'gender': gender,
        'language': language,
        'date_of_birth': dateOfBirth,
        'has_media': hasMedia,
        'media': media?.map((e) => e.toJson()).toList()
      };
}

class Media {
  final int? id;
  final String? modelType;
  final String? modelId;
  final String? collectionName;
  final String? name;
  final String? fileName;
  final String? mimeType;
  final String? disk;
  final String? size;
  final List<dynamic>? manipulations;
  final CustomProperties? customProperties;
  final List<dynamic>? responsiveImages;
  final String? orderColumn;
  final String? createdAt;
  final String? updatedAt;
  String? url;
  final String? thumb;
  final String? icon;
  final String? formatedSize;

  Media({
    this.id,
    this.modelType,
    this.modelId,
    this.collectionName,
    this.name,
    this.fileName,
    this.mimeType,
    this.disk,
    this.size,
    this.manipulations,
    this.customProperties,
    this.responsiveImages,
    this.orderColumn,
    this.createdAt,
    this.updatedAt,
    this.url,
    this.thumb,
    this.icon,
    this.formatedSize,
  });

  Media.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        modelType = json['model_type'] as String?,
        modelId = json['model_id'] as String?,
        collectionName = json['collection_name'] as String?,
        name = json['name'] as String?,
        fileName = json['file_name'] as String?,
        mimeType = json['mime_type'] as String?,
        disk = json['disk'] as String?,
        size = json['size'] as String?,
        manipulations = json['manipulations'] as List?,
        customProperties =
            (json['custom_properties'] as Map<String, dynamic>?) != null
                ? CustomProperties.fromJson(
                    json['custom_properties'] as Map<String, dynamic>)
                : null,
        responsiveImages = json['responsive_images'] as List?,
        orderColumn = json['order_column'] as String?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?,
        url = json['url'] as String?,
        thumb = json['thumb'] as String?,
        icon = json['icon'] as String?,
        formatedSize = json['formated_size'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'model_type': modelType,
        'model_id': modelId,
        'collection_name': collectionName,
        'name': name,
        'file_name': fileName,
        'mime_type': mimeType,
        'disk': disk,
        'size': size,
        'manipulations': manipulations,
        'custom_properties': customProperties?.toJson(),
        'responsive_images': responsiveImages,
        'order_column': orderColumn,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'url': url,
        'thumb': thumb,
        'icon': icon,
        'formated_size': formatedSize
      };
}

class CustomProperties {
  final String? uuid;
  final int? userId;
  final GeneratedConversions? generatedConversions;

  CustomProperties({
    this.uuid,
    this.userId,
    this.generatedConversions,
  });

  CustomProperties.fromJson(Map<String, dynamic> json)
      : uuid = json['uuid'] as String?,
        userId = json['user_id'] as int?,
        generatedConversions =
            (json['generated_conversions'] as Map<String, dynamic>?) != null
                ? GeneratedConversions.fromJson(
                    json['generated_conversions'] as Map<String, dynamic>)
                : null;

  Map<String, dynamic> toJson() => {
        'uuid': uuid,
        'user_id': userId,
        'generated_conversions': generatedConversions?.toJson()
      };
}

class GeneratedConversions {
  final bool? thumb;
  final bool? icon;

  GeneratedConversions({
    this.thumb,
    this.icon,
  });

  GeneratedConversions.fromJson(Map<String, dynamic> json)
      : thumb = json['thumb'] as bool?,
        icon = json['icon'] as bool?;

  Map<String, dynamic> toJson() => {'thumb': thumb, 'icon': icon};
}
