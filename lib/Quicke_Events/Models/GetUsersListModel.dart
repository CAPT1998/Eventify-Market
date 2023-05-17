
import 'dart:convert';

List<GetUsersListModel> productsResponseFromJson(String str) =>
    List<GetUsersListModel>.from(
        json.decode(str).map((x) => GetUsersListModel.fromJson(x)));

String productsResponseToJson(List<GetUsersListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class GetUsersListModel {
  String? name;
  int? id;
  bool? hasMedia;
  List<Media>? media;

  GetUsersListModel(
      {this.name, this.id, this.hasMedia, this.media});

  GetUsersListModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];

    hasMedia = json['has_media'];
    if (json['media'] != null) {
      media = <Media>[];
      json['media'].forEach((v) {
        media!.add(new Media.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;

    data['has_media'] = this.hasMedia;
    if (this.media != null) {
      data['media'] = this.media!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomFields {
  Phone? phone;
  Phone? bio;
  Phone? address;
  VerifiedPhone? verifiedPhone;

  CustomFields({this.phone, this.bio, this.address, this.verifiedPhone});

  CustomFields.fromJson(Map<String, dynamic> json) {
    phone = json['phone'] != null ? new Phone.fromJson(json['phone']) : null;
    bio = json['bio'] != null ? new Phone.fromJson(json['bio']) : null;
    address =
    json['address'] != null ? new Phone.fromJson(json['address']) : null;
    verifiedPhone = json['verifiedPhone'] != null
        ? new VerifiedPhone.fromJson(json['verifiedPhone'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.phone != null) {
      data['phone'] = this.phone!.toJson();
    }
    if (this.bio != null) {
      data['bio'] = this.bio!.toJson();
    }
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    if (this.verifiedPhone != null) {
      data['verifiedPhone'] = this.verifiedPhone!.toJson();
    }
    return data;
  }
}

class Phone {
  String? value;
  String? view;
  String? name;

  Phone({this.value, this.view, this.name});

  Phone.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    view = json['view'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['view'] = this.view;
    data['name'] = this.name;
    return data;
  }
}

class VerifiedPhone {
  String? value;
  String? view;
  String? name;

  VerifiedPhone({this.value, this.view, this.name});

  VerifiedPhone.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    view = json['view'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['view'] = this.view;
    data['name'] = this.name;
    return data;
  }
}

class Media {
  int? id;
  String? modelType;
  String? modelId;
  String? collectionName;
  String? name;
  String? fileName;
  String? mimeType;
  String? disk;
  String? size;
  CustomProperties? customProperties;
  String? orderColumn;
  String? createdAt;
  String? updatedAt;
  String? url;
  String? thumb;
  String? icon;
  String? formatedSize;

  Media(
      {this.id,
        this.modelType,
        this.modelId,
        this.collectionName,
        this.name,
        this.fileName,
        this.mimeType,
        this.disk,
        this.size,
        this.customProperties,
        this.orderColumn,
        this.createdAt,
        this.updatedAt,
        this.url,
        this.thumb,
        this.icon,
        this.formatedSize});

  Media.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    modelType = json['model_type'];
    modelId = json['model_id'];
    collectionName = json['collection_name'];
    name = json['name'];
    fileName = json['file_name'];
    mimeType = json['mime_type'];
    disk = json['disk'];
    size = json['size'];

    customProperties = json['custom_properties'] != null
        ? new CustomProperties.fromJson(json['custom_properties'])
        : null;

    orderColumn = json['order_column'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    url = json['url'];
    thumb = json['thumb'];
    icon = json['icon'];
    formatedSize = json['formated_size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['model_type'] = this.modelType;
    data['model_id'] = this.modelId;
    data['collection_name'] = this.collectionName;
    data['name'] = this.name;
    data['file_name'] = this.fileName;
    data['mime_type'] = this.mimeType;
    data['disk'] = this.disk;
    data['size'] = this.size;

    if (this.customProperties != null) {
      data['custom_properties'] = this.customProperties!.toJson();
    }

    data['order_column'] = this.orderColumn;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['url'] = this.url;
    data['thumb'] = this.thumb;
    data['icon'] = this.icon;
    data['formated_size'] = this.formatedSize;
    return data;
  }
}

class CustomProperties {
  String? uuid;
  int? userId;
  GeneratedConversions? generatedConversions;

  CustomProperties({this.uuid, this.userId, this.generatedConversions});

  CustomProperties.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    userId = json['user_id'];
    generatedConversions = json['generated_conversions'] != null
        ? new GeneratedConversions.fromJson(json['generated_conversions'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['user_id'] = this.userId;
    if (this.generatedConversions != null) {
      data['generated_conversions'] = this.generatedConversions!.toJson();
    }
    return data;
  }
}

class GeneratedConversions {
  bool? thumb;
  bool? icon;

  GeneratedConversions({this.thumb, this.icon});

  GeneratedConversions.fromJson(Map<String, dynamic> json) {
    thumb = json['thumb'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['thumb'] = this.thumb;
    data['icon'] = this.icon;
    return data;
  }
}
