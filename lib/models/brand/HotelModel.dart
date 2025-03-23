import 'dart:convert';

HotelModal HotelModalFromJson(String str) => HotelModal.fromJson(json.decode(str));
Map<String, dynamic> hotelModelToJson(HotelModal data) => data.toJson();

class HotelModal {
  HotelModal({
    this.description,
    this.image,
    this.name,
    this.price,
    this.brandId,
    this.partnerId
  });

  String? description;
  String? image;
  String? name;
  String? brandId;
  String? partnerId;
  int? price;

  factory HotelModal.fromJson(Map<String, dynamic> json) => HotelModal(
    description: json["description"],
    image: json["image"],
    name: json["name"],
    price: json["price"],
    brandId: json["brand_id"],
    partnerId: json["partner_id"],
  );

  Map<String, dynamic> toJson() => {
    "description": description,
    "image": image,
    "name": name,
    "price": price,
    "brand_id": brandId,
    "partner_id": partnerId,
  };
}
