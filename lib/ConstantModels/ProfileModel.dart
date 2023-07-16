class ProfileModel {
  final String? name;
  final int? id;
  final CustomFields? customFields;
  final bool? hasMedia;
  final List<dynamic>? media;

  ProfileModel({
    this.name,
    this.id,
    this.customFields,
    this.hasMedia,
    this.media,
  });

  ProfileModel.fromJson(Map<String, dynamic> json)
    : name = json['name'] as String?,
      id = json['id'] as int?,
      customFields = (json['custom_fields'] as Map<String,dynamic>?) != null ? CustomFields.fromJson(json['custom_fields'] as Map<String,dynamic>) : null,
      hasMedia = json['has_media'] as bool?,
      media = json['media'] as List?;

  Map<String, dynamic> toJson() => {
    'name' : name,
    'id' : id,
    'custom_fields' : customFields?.toJson(),
    'has_media' : hasMedia,
    'media' : media
  };
}

class CustomFields {
  final Phone? phone;
  final Bio? bio;
  final Address? address;
  final VerifiedPhone? verifiedPhone;

  CustomFields({
    this.phone,
    this.bio,
    this.address,
    this.verifiedPhone,
  });

  CustomFields.fromJson(Map<String, dynamic> json)
    : phone = (json['phone'] as Map<String,dynamic>?) != null ? Phone.fromJson(json['phone'] as Map<String,dynamic>) : null,
      bio = (json['bio'] as Map<String,dynamic>?) != null ? Bio.fromJson(json['bio'] as Map<String,dynamic>) : null,
      address = (json['address'] as Map<String,dynamic>?) != null ? Address.fromJson(json['address'] as Map<String,dynamic>) : null,
      verifiedPhone = (json['verifiedPhone'] as Map<String,dynamic>?) != null ? VerifiedPhone.fromJson(json['verifiedPhone'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'phone' : phone?.toJson(),
    'bio' : bio?.toJson(),
    'address' : address?.toJson(),
    'verifiedPhone' : verifiedPhone?.toJson()
  };
}

class Phone {
  final dynamic value;
  final dynamic view;
  final String? name;

  Phone({
    this.value,
    this.view,
    this.name,
  });

  Phone.fromJson(Map<String, dynamic> json)
    : value = json['value'],
      view = json['view'],
      name = json['name'] as String?;

  Map<String, dynamic> toJson() => {
    'value' : value,
    'view' : view,
    'name' : name
  };
}

class Bio {
  final dynamic value;
  final String? view;
  final String? name;

  Bio({
    this.value,
    this.view,
    this.name,
  });

  Bio.fromJson(Map<String, dynamic> json)
    : value = json['value'],
      view = json['view'] as String?,
      name = json['name'] as String?;

  Map<String, dynamic> toJson() => {
    'value' : value,
    'view' : view,
    'name' : name
  };
}

class Address {
  final dynamic value;
  final dynamic view;
  final String? name;

  Address({
    this.value,
    this.view,
    this.name,
  });

  Address.fromJson(Map<String, dynamic> json)
    : value = json['value'],
      view = json['view'],
      name = json['name'] as String?;

  Map<String, dynamic> toJson() => {
    'value' : value,
    'view' : view,
    'name' : name
  };
}

class VerifiedPhone {
  final dynamic value;
  final dynamic view;
  final String? name;

  VerifiedPhone({
    this.value,
    this.view,
    this.name,
  });

  VerifiedPhone.fromJson(Map<String, dynamic> json)
    : value = json['value'],
      view = json['view'],
      name = json['name'] as String?;

  Map<String, dynamic> toJson() => {
    'value' : value,
    'view' : view,
    'name' : name
  };
}