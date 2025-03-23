import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

OrderDetailsModel orderDetailsModelFromJson(String str) =>
    OrderDetailsModel.fromJson(json.decode(str));

Map<String, dynamic> orderDetailsModelToJson(OrderDetailsModel data) =>
    data.toJson();

class OrderDetailsModel {
  OrderDetailsModel({
    this.id,
    this.orderId,
    this.userId,
    this.agentId,
    this.orderNo,
    this.createdAt,
    this.orderBy,
    this.membershipId,
    this.brandId,
    this.email,
    this.name,
    this.amount,
    this.status,
    this.receipt,
  });

  String? id;
  String? orderId;
  String? userId;
  String? agentId;
  String? orderNo;
  Timestamp? createdAt;
  String? orderBy;
  String? membershipId;
  String? brandId;
  String? email;
  String? name;
  String? amount;
  String? status;
  String? receipt;

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) =>
      OrderDetailsModel(
        id: json["id"],
        orderId: json["order_id"],
        userId: json["user_id"],
        agentId: json["agent_id"],
        orderNo: json["order_no"],
        createdAt: json["created_at"],
        orderBy: json["order_by"],
        membershipId: json["membership_id"],
        brandId: json["brand_id"],
        email: json["email"],
        name: json["name"],
        amount: json["amount"],
        status: json["status"],
        receipt: json["receipt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "user_id": userId,
        "agent_id": agentId,
        "order_no": orderNo,
        "created_at": createdAt,
        "order_by": orderBy,
        "membership_id": membershipId,
        "brand_id": brandId,
        "email": email,
        "name": name,
        "amount": amount,
        "status": status,
        "receipt": receipt,
      };
}