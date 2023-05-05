// To parse this JSON data, do
//
//     final getEventTicketsModel = getEventTicketsModelFromJson(jsonString);

import 'dart:convert';

List<GetEventTicketsModel> getEventTicketsModelFromJson(String str) =>
    List<GetEventTicketsModel>.from(
        json.decode(str).map((x) => GetEventTicketsModel.fromJson(x)));

String getEventTicketsModelToJson(List<GetEventTicketsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetEventTicketsModel {
  int id;
  String eventId;
  String name;
  String groupArtist;
  DateTime startDate;
  DateTime endDate;
  String venue;
  String gender;
  int capacity;
  int price;
  dynamic discountPrice;
  String? description;
  double? addressLatitude;
  double? addressLongitude;
  int mapZoom;
  DateTime createdAt;
  DateTime updatedAt;
  List<dynamic> customFields;
  bool hasMedia;
  List<Media> media;

  GetEventTicketsModel({
    required this.id,
    required this.eventId,
    required this.name,
    required this.groupArtist,
    required this.startDate,
    required this.endDate,
    required this.venue,
    required this.gender,
    required this.capacity,
    required this.price,
    this.discountPrice,
    this.description,
    this.addressLatitude,
    this.addressLongitude,
    required this.mapZoom,
    required this.createdAt,
    required this.updatedAt,
    required this.customFields,
    required this.hasMedia,
    required this.media,
  });

  factory GetEventTicketsModel.fromJson(Map<String, dynamic> json) =>
      GetEventTicketsModel(
        id: json["id"],
        eventId: json["event_id"],
        name: json["name"],
        groupArtist: json["group_artist"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        venue: json["venue"],
        gender: json["gender"],
        capacity: json["capacity"],
        price: json["price"],
        discountPrice: json["discount_price"],
        description: json["description"],
        addressLatitude: json["address_latitude"]?.toDouble(),
        addressLongitude: json["address_longitude"]?.toDouble(),
        mapZoom: json["map_zoom"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        customFields: List<dynamic>.from(json["custom_fields"].map((x) => x)),
        hasMedia: json["has_media"],
        media: List<Media>.from(json["media"].map((x) => Media.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "event_id": eventId,
        "name": name,
        "group_artist": groupArtist,
        "start_date": startDate.toIso8601String(),
        "end_date": endDate.toIso8601String(),
        "venue": venue,
        "gender": gender,
        "capacity": capacity,
        "price": price,
        "discount_price": discountPrice,
        "description": description,
        "address_latitude": addressLatitude,
        "address_longitude": addressLongitude,
        "map_zoom": mapZoom,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "custom_fields": List<dynamic>.from(customFields.map((x) => x)),
        "has_media": hasMedia,
        "media": List<dynamic>.from(media.map((x) => x.toJson())),
      };
}

class Media {
  int id;
  String modelType;
  String modelId;
  String collectionName;
  String name;
  String fileName;
  String mimeType;
  String disk;
  String size;
  List<dynamic> manipulations;
  CustomProperties customProperties;
  List<dynamic> responsiveImages;
  String orderColumn;
  DateTime createdAt;
  DateTime updatedAt;
  String url;
  String thumb;
  String icon;
  String formatedSize;

  Media({
    required this.id,
    required this.modelType,
    required this.modelId,
    required this.collectionName,
    required this.name,
    required this.fileName,
    required this.mimeType,
    required this.disk,
    required this.size,
    required this.manipulations,
    required this.customProperties,
    required this.responsiveImages,
    required this.orderColumn,
    required this.createdAt,
    required this.updatedAt,
    required this.url,
    required this.thumb,
    required this.icon,
    required this.formatedSize,
  });

  factory Media.fromJson(Map<String, dynamic> json) => Media(
        id: json["id"],
        modelType: json["model_type"],
        modelId: json["model_id"],
        collectionName: json["collection_name"],
        name: json["name"],
        fileName: json["file_name"],
        mimeType: json["mime_type"],
        disk: json["disk"],
        size: json["size"],
        manipulations: List<dynamic>.from(json["manipulations"].map((x) => x)),
        customProperties: CustomProperties.fromJson(json["custom_properties"]),
        responsiveImages:
            List<dynamic>.from(json["responsive_images"].map((x) => x)),
        orderColumn: json["order_column"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        url: json["url"],
        thumb: json["thumb"],
        icon: json["icon"],
        formatedSize: json["formated_size"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "model_type": modelType,
        "model_id": modelId,
        "collection_name": collectionName,
        "name": name,
        "file_name": fileName,
        "mime_type": mimeType,
        "disk": disk,
        "size": size,
        "manipulations": List<dynamic>.from(manipulations.map((x) => x)),
        "custom_properties": customProperties.toJson(),
        "responsive_images": List<dynamic>.from(responsiveImages.map((x) => x)),
        "order_column": orderColumn,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "url": url,
        "thumb": thumb,
        "icon": icon,
        "formated_size": formatedSize,
      };
}

class CustomProperties {
  String uuid;
  int userId;
  GeneratedConversions generatedConversions;

  CustomProperties({
    required this.uuid,
    required this.userId,
    required this.generatedConversions,
  });

  factory CustomProperties.fromJson(Map<String, dynamic> json) =>
      CustomProperties(
        uuid: json["uuid"],
        userId: json["user_id"],
        generatedConversions:
            GeneratedConversions.fromJson(json["generated_conversions"]),
      );

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "user_id": userId,
        "generated_conversions": generatedConversions.toJson(),
      };
}

class GeneratedConversions {
  bool thumb;
  bool icon;

  GeneratedConversions({
    required this.thumb,
    required this.icon,
  });

  factory GeneratedConversions.fromJson(Map<String, dynamic> json) =>
      GeneratedConversions(
        thumb: json["thumb"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "thumb": thumb,
        "icon": icon,
      };
}
