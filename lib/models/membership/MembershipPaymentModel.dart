import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

MembershipPaymentModel membershipPaymentModelFromJson(String str) =>
    MembershipPaymentModel.fromJson(json.decode(str));

Map<String, dynamic> membershipPaymentModelToJson(
        MembershipPaymentModel data) =>
    data.toJson();

class MembershipPaymentModel {
  MembershipPaymentModel({
    this.id,
    this.agentId,
    this.userId,
    this.orderId,
    this.paymentId,
    this.price,
    this.paymentStatus,
    this.paymentDate,
    this.createdAt,
    this.contact,
    this.brandId,
  });

  String? id;
  String? agentId;
  String? userId;
  String? orderId;
  String? paymentId;
  int? price;
  String? paymentStatus;
  Timestamp? paymentDate;
  Timestamp? createdAt;
  Contact? contact;
  String? brandId;

  factory MembershipPaymentModel.fromJson(Map<String, dynamic> json) =>
      MembershipPaymentModel(
        id: json["id"],
        agentId: json["agent_id"],
        userId: json["user_id"],
        orderId: json["order_id"],
        paymentId: json["payment_id"],
        price: json["price"],
        paymentStatus: json["payment_status"],
        paymentDate: json["payment_date"],
        createdAt: json["created_at"],
        contact: Contact.fromJson(json["contact"]),
        brandId: json['brand_id'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "agent_id": agentId,
        "user_id": userId,
        "order_id": orderId,
        "payment_id": paymentId,
        "price": price,
        "payment_status": paymentStatus,
        "payment_date": paymentDate,
        "created_at": createdAt,
        "contact": contact?.toJson(),
        "brand_id": brandId,
      };
}

class Contact {
  Contact({
    this.mobile,
    this.email,
  });

  String? mobile;
  String? email;

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        mobile: json["mobile"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "mobile": mobile,
        "email": email,
      };
}
