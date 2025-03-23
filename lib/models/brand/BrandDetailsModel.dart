import 'dart:convert';
import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';

BrandDetailsModel brandDetailsModelFromJson(String str) =>
    BrandDetailsModel.fromJson(json.decode(str));

Map<String, dynamic> brandDetailsModelToJson(BrandDetailsModel data) =>
    data.toJson();

class BrandDetailsModel {
  BrandDetailsModel(
      {this.name,
      this.description,
      this.logoUrl,
      this.addressLine1,
      this.addressLine2,
      this.city,
      this.pincode,
      this.state,
      this.country,
      this.id,
      this.createdAt,
      this.ratings,
      this.noVoters,
      this.support,
      this.price});

  String? name;
  String? description;
  String? logoUrl;
  String? addressLine1;
  String? addressLine2;
  String? city;
  String? pincode;
  String? state;
  String? country;
  String? id;
  Timestamp? createdAt;
  String? ratings;
  String? noVoters;
  Support? support;
  num? price;

  factory BrandDetailsModel.fromJson(Map<String, dynamic> json) =>
      BrandDetailsModel(
          name: json["name"],
          description: json["description"],
          logoUrl: json["logo_url"],
          addressLine1: json["address_line1"],
          addressLine2: json["address_line2"],
          city: json["city"],
          pincode: json["pincode"],
          state: json["state"],
          country: json["country"],
          id: json["id"],
          createdAt: json["created_at"],
          ratings: json["ratings"],
          noVoters: json["no_voters"],
          price: json["price"],
          support: Support.fromJson(json["support"]));

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "logo_url": logoUrl,
        "address_line1": addressLine1,
        "address_line2": addressLine2,
        "city": city,
        "pincode": pincode,
        "state": state,
        "country": country,
        "id": id,
        "created_at": createdAt,
        "ratings": ratings,
        "price": price,
        "no_voters": noVoters,
        "support": support?.toJson(),
      };
}

Support supportFromJson(String str) => Support.fromJson(json.decode(str));

String supportToJson(Support data) => json.encode(data.toJson());

class Support {
  Support({
    this.email,
    this.contact,
  });

  String? email;
  String? contact;

  factory Support.fromJson(Map<String, dynamic> json) => Support(
        email: json["email"],
        contact: json["contact"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "contact": contact,
      };
}
