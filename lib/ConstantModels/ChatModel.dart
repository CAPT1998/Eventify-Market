class ChatModel {
  final int? id;
  final String? senderId;
  final String? receiverId;
  final String? message;
  final String? createdAt;
  final String? updatedAt;
  final Sender? sender;
  final Receiver? receiver;

  ChatModel({
    this.id,
    this.senderId,
    this.receiverId,
    this.message,
    this.createdAt,
    this.updatedAt,
    this.sender,
    this.receiver,
  });

  ChatModel.fromJson(Map<String, dynamic> json)
    : id = json['id'] as int?,
      senderId = json['sender_id'] as String?,
      receiverId = json['receiver_id'] as String?,
      message = json['message'] as String?,
      createdAt = json['created_at'] as String?,
      updatedAt = json['updated_at'] as String?,
      sender = (json['sender'] as Map<String,dynamic>?) != null ? Sender.fromJson(json['sender'] as Map<String,dynamic>) : null,
      receiver = (json['receiver'] as Map<String,dynamic>?) != null ? Receiver.fromJson(json['receiver'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'sender_id' : senderId,
    'receiver_id' : receiverId,
    'message' : message,
    'created_at' : createdAt,
    'updated_at' : updatedAt,
    'sender' : sender?.toJson(),
    'receiver' : receiver?.toJson()
  };
}

class Sender {
  final int? id;
  final String? name;
  final String? email;
  final String? apiToken;
  final String? deviceToken;
  final dynamic stripeId;
  final dynamic cardBrand;
  final dynamic cardLastFour;
  final dynamic trialEndsAt;
  final dynamic braintreeId;
  final dynamic paypalEmail;
  final String? createdAt;
  final String? updatedAt;
  final dynamic phone;
  final dynamic address;
  final dynamic gender;
  final dynamic language;
  final dynamic dateOfBirth;
  final CustomFields? customFields;
  final bool? hasMedia;
  final List<dynamic>? media;

  Sender({
    this.id,
    this.name,
    this.email,
    this.apiToken,
    this.deviceToken,
    this.stripeId,
    this.cardBrand,
    this.cardLastFour,
    this.trialEndsAt,
    this.braintreeId,
    this.paypalEmail,
    this.createdAt,
    this.updatedAt,
    this.phone,
    this.address,
    this.gender,
    this.language,
    this.dateOfBirth,
    this.customFields,
    this.hasMedia,
    this.media,
  });

  Sender.fromJson(Map<String, dynamic> json)
    : id = json['id'] as int?,
      name = json['name'] as String?,
      email = json['email'] as String?,
      apiToken = json['api_token'] as String?,
      deviceToken = json['device_token'] as String?,
      stripeId = json['stripe_id'],
      cardBrand = json['card_brand'],
      cardLastFour = json['card_last_four'],
      trialEndsAt = json['trial_ends_at'],
      braintreeId = json['braintree_id'],
      paypalEmail = json['paypal_email'],
      createdAt = json['created_at'] as String?,
      updatedAt = json['updated_at'] as String?,
      phone = json['phone'],
      address = json['address'],
      gender = json['gender'],
      language = json['language'],
      dateOfBirth = json['date_of_birth'],
      customFields = (json['custom_fields'] as Map<String,dynamic>?) != null ? CustomFields.fromJson(json['custom_fields'] as Map<String,dynamic>) : null,
      hasMedia = json['has_media'] as bool?,
      media = json['media'] as List?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'email' : email,
    'api_token' : apiToken,
    'device_token' : deviceToken,
    'stripe_id' : stripeId,
    'card_brand' : cardBrand,
    'card_last_four' : cardLastFour,
    'trial_ends_at' : trialEndsAt,
    'braintree_id' : braintreeId,
    'paypal_email' : paypalEmail,
    'created_at' : createdAt,
    'updated_at' : updatedAt,
    'phone' : phone,
    'address' : address,
    'gender' : gender,
    'language' : language,
    'date_of_birth' : dateOfBirth,
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

class Receiver {
  final int? id;
  final String? name;
  final String? email;
  final String? apiToken;
  final dynamic deviceToken;
  final dynamic stripeId;
  final dynamic cardBrand;
  final dynamic cardLastFour;
  final dynamic trialEndsAt;
  final dynamic braintreeId;
  final dynamic paypalEmail;
  final String? createdAt;
  final String? updatedAt;
  final dynamic phone;
  final dynamic address;
  final dynamic gender;
  final dynamic language;
  final dynamic dateOfBirth;
  final CustomFields? customFields;
  final bool? hasMedia;
  final List<dynamic>? media;

  Receiver({
    this.id,
    this.name,
    this.email,
    this.apiToken,
    this.deviceToken,
    this.stripeId,
    this.cardBrand,
    this.cardLastFour,
    this.trialEndsAt,
    this.braintreeId,
    this.paypalEmail,
    this.createdAt,
    this.updatedAt,
    this.phone,
    this.address,
    this.gender,
    this.language,
    this.dateOfBirth,
    this.customFields,
    this.hasMedia,
    this.media,
  });

  Receiver.fromJson(Map<String, dynamic> json)
    : id = json['id'] as int?,
      name = json['name'] as String?,
      email = json['email'] as String?,
      apiToken = json['api_token'] as String?,
      deviceToken = json['device_token'],
      stripeId = json['stripe_id'],
      cardBrand = json['card_brand'],
      cardLastFour = json['card_last_four'],
      trialEndsAt = json['trial_ends_at'],
      braintreeId = json['braintree_id'],
      paypalEmail = json['paypal_email'],
      createdAt = json['created_at'] as String?,
      updatedAt = json['updated_at'] as String?,
      phone = json['phone'],
      address = json['address'],
      gender = json['gender'],
      language = json['language'],
      dateOfBirth = json['date_of_birth'],
      customFields = (json['custom_fields'] as Map<String,dynamic>?) != null ? CustomFields.fromJson(json['custom_fields'] as Map<String,dynamic>) : null,
      hasMedia = json['has_media'] as bool?,
      media = json['media'] as List?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'email' : email,
    'api_token' : apiToken,
    'device_token' : deviceToken,
    'stripe_id' : stripeId,
    'card_brand' : cardBrand,
    'card_last_four' : cardLastFour,
    'trial_ends_at' : trialEndsAt,
    'braintree_id' : braintreeId,
    'paypal_email' : paypalEmail,
    'created_at' : createdAt,
    'updated_at' : updatedAt,
    'phone' : phone,
    'address' : address,
    'gender' : gender,
    'language' : language,
    'date_of_birth' : dateOfBirth,
    'custom_fields' : customFields?.toJson(),
    'has_media' : hasMedia,
    'media' : media
  };
}

