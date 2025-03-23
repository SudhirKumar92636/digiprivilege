import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

StayModel stayModelFromJson(String str) => StayModel.fromJson(json.decode(str));
String stayModelToJson(StayModel data) => json.encode(data.toJson());

class StayModel {
  StayModel(
      {this.amount,
      this.brandId,
      this.brandName,
      this.checkInDate,
      this.checkInDateTime,
      this.checkOutDate,
      this.checkOutDateTime,
      this.coupons,
      this.description,
      this.duration,
      this.hotelImage,
      this.id,
      this.membershipId,
      this.rooms,
      this.status,
      this.userId,
      this.agentId,
      this.rejectionReason,
      this.partnerId});

  num? amount;
  String? brandId;
  String? brandName;
  String? checkInDate;
  Timestamp? checkInDateTime;
  String? checkOutDate;
  Timestamp? checkOutDateTime;
  List<String>? coupons;
  String? description;
  int? duration;
  String? hotelImage;
  String? id;
  String? membershipId;
  String? rooms;
  String? status;
  String? userId;
  String? agentId;
  String? rejectionReason;
  String? partnerId;

  factory StayModel.fromJson(Map<String, dynamic> json) => StayModel(
        amount: json["amount"],
        brandId: json["brand_id"],
        brandName: json["brand_name"],
        checkInDate: json["check_in_date"],
        checkInDateTime: json["check_in_date_time"],
        checkOutDate: json["check_out_date"],
        checkOutDateTime: json["check_out_date_time"],
        coupons: List<String>.from(json["coupons"].map((x) => x)),
        description: json["description"],
        duration: json["duration"],
        hotelImage: json["hotel_image"],
        id: json["id"],
        membershipId: json["membership_id"],
        rooms: json["rooms"],
        status: json["status"],
        userId: json["user_id"],
        agentId: json["agent_id"],
        rejectionReason: json["rejection_reason"],
        partnerId: json["partner_id"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "brand_id": brandId,
        "brand_name": brandName,
        "check_in_date": checkInDate,
        "check_in_date_time": checkInDateTime,
        "check_out_date": checkOutDate,
        "check_out_date_time": checkOutDateTime,
        "coupons": List<dynamic>.from(coupons!.map((x) => x)),
        "description": description,
        "duration": duration,
        "hotel_image": hotelImage,
        "id": id,
        "membership_id": membershipId,
        "rooms": rooms,
        "status": status,
        "user_id": userId,
        "agent_id": agentId,
        "rejection_reason": rejectionReason,
        "partner_id": partnerId,
      };
}