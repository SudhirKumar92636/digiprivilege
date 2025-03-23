import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

UserMembershipDetailsModel userMembershipDetailsModelFromJson(String str) =>
    UserMembershipDetailsModel.fromJson(json.decode(str));

Map<String, dynamic> userMembershipDetailsModelToJson(
        UserMembershipDetailsModel data) =>
    data.toJson();

class UserMembershipDetailsModel {
  UserMembershipDetailsModel({
    this.agentId,
    this.createdAt,
    this.description,
    this.id,
    this.imageUrl,
    this.membershipId,
    this.membershipStatus,
    this.paymentId,
    this.images,
    this.paymentStatus,
    this.purchaseAt,
    this.title,
    this.userId,
    this.brandId,
    this.brandName,
    this.brandLogoUrl,
    this.duration,
    this.unit,
    this.price,
    this.isVerified,
    this.isFoodWithoutStay,
    this.orderId,
    this.userName,
    this.partnerId,
    this.membershipNumber,
  });

  String? agentId;
  Timestamp? createdAt;
  String? description;
  String? id;
  String? imageUrl;
  String? membershipId;
  String? membershipStatus;
  String? paymentId;
  List<String>? images;
  String? paymentStatus;
  Timestamp? purchaseAt;
  String? title;
  String? userId;
  String? userName;
  String? brandId;
  String? brandName;
  String? brandLogoUrl;
  String? duration;
  String? unit;
  String? price;
  String? orderId;
  bool? isVerified;
  bool? isFoodWithoutStay;
  String? partnerId;
  String? membershipNumber;

  factory UserMembershipDetailsModel.fromJson(Map<String, dynamic> json) =>
      UserMembershipDetailsModel(
        agentId: json["agent_id"],
        createdAt: json["created_at"],
        description: json["description"],
        id: json["id"],
        imageUrl: json["image_url"],
        membershipId: json["membership_id"],
        membershipStatus: json["membership_status"],
        paymentId: json["payment_id"],
        images: List<String>.from(json["images"].map((x) => x)),
        paymentStatus: json["payment_status"],
        purchaseAt: json["purchase_at"],
        title: json["title"],
        userId: json["user_id"],
        userName: json["user_name"],
        brandId: json['brand_id'],
        brandName: json['brand_name'],
        brandLogoUrl: json['brand_logo_url'],
        duration: json["duration"],
        unit: json["unit"],
        price: json["price"],
        isVerified: json["is_verified"],
        isFoodWithoutStay: json["is_food_without_stay"],
        orderId: json["order_id"],
        partnerId: json["partner_id"],
        membershipNumber: json["membership_number"],

        // brandList: List<BrandList>.from(json["brand_list"].map((x) => BrandList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "agent_id": agentId,
        "created_at": createdAt,
        "description": description,
        "id": id,
        "image_url": imageUrl,
        "membership_id": membershipId,
        "membership_status": membershipStatus,
        "payment_id": paymentId,
        "images": List<dynamic>.from(images!.map((x) => x)),
        "payment_status": paymentStatus,
        "purchase_at": purchaseAt,
        "title": title,
        "user_id": userId,
        "user_name": userName,
        "brand_id": brandId,
        "brand_name": brandName,
        "brand_logo_url": brandLogoUrl,
        "duration": duration,
        "unit": unit,
        "price": price,
        "is_verified": isVerified,
        "is_food_without_stay": isFoodWithoutStay,
        "order_id": orderId,
        "partner_id": partnerId,
        "membership_number": membershipNumber,
      };
}

class BrandList {
  BrandList({
    this.description,
    this.image,
    this.name,
    this.price,
  });

  String? description;
  String? image;
  String? name;
  int? price;

  factory BrandList.fromJson(Map<String, dynamic> json) => BrandList(
        description: json["description"],
        image: json["image"],
        name: json["name"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "image": image,
        "name": name,
        "price": price,
      };
}
