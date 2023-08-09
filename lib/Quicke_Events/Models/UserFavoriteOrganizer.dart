import 'dart:convert';

List<UserFavoriteOrganizer> getEventsModelFromJson(String str) =>
    List<UserFavoriteOrganizer>.from(
        json.decode(str).map((x) => UserFavoriteOrganizer.fromJson(x)));

String getEventsModelToJson(List<UserFavoriteOrganizer> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserFavoriteOrganizer {
  final int? id;
  final String? organizerName;
  final String? organizerImage;
  final String? createdAt;
  final String? updatedAt;
  final String? bio;
  final dynamic location;
  final String? collectionId;
  final Pivot? pivot;

  UserFavoriteOrganizer({
    this.id,
    this.organizerName,
    this.organizerImage,
    this.createdAt,
    this.updatedAt,
    this.bio,
    this.location,
    this.collectionId,
    this.pivot,
  });

  UserFavoriteOrganizer.fromJson(Map<String, dynamic> json)
    : id = json['id'] as int?,
      organizerName = json['organizer_name'] as String?,
      organizerImage = json['organizer_image'] as String?,
      createdAt = json['created_at'] as String?,
      updatedAt = json['updated_at'] as String?,
      bio = json['bio'] as String?,
      location = json['location'],
      collectionId = json['collection_id'] as String?,
      pivot = (json['pivot'] as Map<String,dynamic>?) != null ? Pivot.fromJson(json['pivot'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'organizer_name' : organizerName,
    'organizer_image' : organizerImage,
    'created_at' : createdAt,
    'updated_at' : updatedAt,
    'bio' : bio,
    'location' : location,
    'collection_id' : collectionId,
    'pivot' : pivot?.toJson()
  };
}

class Pivot {
  final String? userId;
  final String? organizerId;

  Pivot({
    this.userId,
    this.organizerId,
  });

  Pivot.fromJson(Map<String, dynamic> json)
    : userId = json['user_id'] as String?,
      organizerId = json['organizer_id'] as String?;

  Map<String, dynamic> toJson() => {
    'user_id' : userId,
    'organizer_id' : organizerId
  };
}