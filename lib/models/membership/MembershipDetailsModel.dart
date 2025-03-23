import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

MembershipDetailsModel membershipDetailsModelFromJson(String str) =>
    MembershipDetailsModel.fromJson(json.decode(str));

String membershipDetailsModelToJson(MembershipDetailsModel data) =>
    json.encode(data.toJson());

class MembershipDetailsModel {
  MembershipDetailsModel(
      {this.title,
      this.brandId,
      this.brandLogoUrl,
      this.brandName,
      this.createdAt,
      this.desc,
      this.duration,
      this.heroImageUrl,
      this.id,
      this.images,
      this.moreInfo,
      this.noOfCoupons,
      this.offers,
      this.price,
      this.searchArray,
      this.unit,
      this.is_food_without_stay});

  String? title;
  String? brandId;
  String? brandLogoUrl;
  String? brandName;
  Timestamp? createdAt;
  String? desc;
  String? duration;
  String? heroImageUrl;
  String? id;
  List<String>? images;
  String? moreInfo;
  int? noOfCoupons;
  String? offers;
  int? price;
  List<String>? searchArray;
  String? unit;
  bool? is_food_without_stay;

  factory MembershipDetailsModel.fromJson(Map<String, dynamic> json) =>
      MembershipDetailsModel(
        brandId: json["brand_id"],
        brandLogoUrl: json["brand_logo_url"],
        brandName: json["brand_name"],
        createdAt: json["created_at"],
        desc: json["desc"],
        duration: json["duration"],
        heroImageUrl: json["hero_image_url"],
        id: json["id"],
        images: List<String>.from(json["images"].map((x) => x)),
        moreInfo: json["more_info"],
        noOfCoupons: json["no_of_coupons"],
        offers: json["offers"],
        price: json["price"],
        searchArray: List<String>.from(json["search_array"].map((x) => x)),
        title: json['title'],
        unit: json["unit"],
        is_food_without_stay: json["is_food_without_stay"],
      );

  Map<String, dynamic> toJson() => {
        "brand_id": brandId,
        "brand_logo_url": brandLogoUrl,
        "brand_name": brandName,
        "created_at": createdAt,
        "desc": desc,
        "duration": duration,
        "hero_image_url": heroImageUrl,
        "id": id,
        "images": List<dynamic>.from(images!.map((x) => x)),
        "more_info": moreInfo,
        "no_of_coupons": noOfCoupons,
        "membership": offers,
        "price": price,
        "search_array": List<dynamic>.from(searchArray!.map((x) => x)),
        "title": title,
        "unit": unit,
        "is_food_without_stay": is_food_without_stay,
      };
}