class ProductDetailResponseModel {
  String? message;
  List<Product>? product;

  ProductDetailResponseModel({this.message, this.product});

  ProductDetailResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['product'] != null) {
      product = <Product>[];
      json['product'].forEach((v) {
        product!.add(new Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.product != null) {
      data['product'] = this.product!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class Product {
  int? id;
  String? name;
  int? price;
  String? discountPrice;
  String? description;
  int? capacity;
  int? packageItemsCount;
  String? unit;
  String? rate;
  String? itemsAvailable;
  bool? featured;
  bool? deliverable;
  int? storeId;
  int? categoryId;
  int? brandId;
  String? createdAt;
  String? updatedAt;
  bool? hasMedia;
  Store? store;
  List<Media>? media;

  Product(
      {this.id,
        this.name,
        this.price,
        this.discountPrice,
        this.description,
        this.capacity,
        this.packageItemsCount,
        this.unit,
        this.rate,
        this.itemsAvailable,
        this.featured,
        this.deliverable,
        this.storeId,
        this.categoryId,
        this.brandId,
        this.createdAt,
        this.updatedAt,
        this.hasMedia,
        this.store,
        this.media});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    discountPrice = json['discount_price'];
    description = json['description'];
    capacity = json['capacity'];
    packageItemsCount = json['package_items_count'];
    unit = json['unit'];
    rate = json['rate'];
    itemsAvailable = json['itemsAvailable'];
    featured = json['featured'];
    deliverable = json['deliverable'];
    storeId = json['store_id'];
    categoryId = json['category_id'];
    brandId = json['brand_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];

    hasMedia = json['has_media'];
    store = json['store'] != null ? new Store.fromJson(json['store']) : null;
    if (json['media'] != null) {
      media = <Media>[];
      json['media'].forEach((v) {
        media!.add(new Media.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['discount_price'] = this.discountPrice;
    data['description'] = this.description;
    data['capacity'] = this.capacity;
    data['package_items_count'] = this.packageItemsCount;
    data['unit'] = this.unit;
    data['rate'] = this.rate;
    data['itemsAvailable'] = this.itemsAvailable;
    data['featured'] = this.featured;
    data['deliverable'] = this.deliverable;
    data['store_id'] = this.storeId;
    data['category_id'] = this.categoryId;
    data['brand_id'] = this.brandId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;

    data['has_media'] = this.hasMedia;
    if (this.store != null) {
      data['store'] = this.store!.toJson();
    }
    if (this.media != null) {
      data['media'] = this.media!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Store {
  int? id;
  String? name;
  int? deliveryFee;
  String? phone;
  bool? hasMedia;
  String? rate;
  List<Media>? media;

  Store(
      {this.id,
        this.name,
        this.deliveryFee,
        this.phone,
        this.hasMedia,
        this.rate,
        this.media});

  Store.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    deliveryFee = json['delivery_fee'];
    phone = json['phone'];

    hasMedia = json['has_media'];
    rate = json['rate'];
    if (json['media'] != null) {
      media = <Media>[];
      json['media'].forEach((v) {
        media!.add(new Media.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['delivery_fee'] = this.deliveryFee;
    data['phone'] = this.phone;

    data['has_media'] = this.hasMedia;
    data['rate'] = this.rate;
    if (this.media != null) {
      data['media'] = this.media!.map((v) => v.toJson()).toList();
    }
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
