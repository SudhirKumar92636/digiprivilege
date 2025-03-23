import 'dart:convert';

OfferDetailsModel offerDetailsModelFromJson(String str) =>
    OfferDetailsModel.fromJson(json.decode(str));

String offerDetailsModelToJson(OfferDetailsModel data) =>
    json.encode(data.toJson());

class OfferDetailsModel {
  String? hero_image_url;
  String? id;
  String? desc;
  String? price;
  String? title;

  OfferDetailsModel({
    this.hero_image_url,
    this.id,
    this.desc,
    this.price,
    this.title,
  });

  factory OfferDetailsModel.fromJson(Map<String, dynamic> json) =>
      OfferDetailsModel(
        hero_image_url: json["hero_image_url"],
        id: json["id"],
        price: json["price"],
        desc: json["desc"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "hero_image_url": hero_image_url,
        "id": id,
        "price": price,
        "desc": desc,
        "title": title,
      };
}