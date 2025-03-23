import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

UserDetailsModel userDetailsModelFromJson(String str) =>
    UserDetailsModel.fromJson(json.decode(str));

Map<String, dynamic> userDetailsModelToJson(UserDetailsModel data) =>
    data.toJson();

class UserDetailsModel {
  UserDetailsModel({
    this.createdAt,
    this.agentId,
    this.email,
    this.firstName,
    this.lastName,
    this.gender,
    this.type,
    this.updatedAt,
    this.number,
    this.userId,
    this.status,
    this.newUser,
    this.userType,
    this.referralCode,
    this.searchArray,
    this.otherReferralCode,
    this.address
  });

  Timestamp? createdAt;
  String? agentId;
  String? email;
  String? firstName;
  String? lastName;
  String? gender;
  String? type;
  Timestamp? updatedAt;
  String? number;
  String? userId;
  bool? status;
  bool? newUser;
  UserType? userType;
  String? referralCode;
  String? otherReferralCode;
  String? address;
  List<String>? searchArray;

  factory UserDetailsModel.fromJson(Map<String, dynamic> json) =>
      UserDetailsModel(
        createdAt: json["created_at"],
        agentId: json["agent_id"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        gender: json["gender"],
        type: json["type"],
        updatedAt: json["updated_at"],
        number: json["number"],
        userId: json["user_id"],
        status: json["status"],
        newUser: json["new_user"],
        address: json["address"],
        userType: UserType.fromJson(json["user_type"]),
        referralCode: json["referral_code"],
        otherReferralCode: json["other_referral_code"],
        searchArray: List<String>.from(json["searchArray"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "created_at": createdAt,
        "agent_id": agentId,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "gender": gender,
        "type": type,
        "updated_at": updatedAt,
        "number": number,
        "user_id": userId,
        "status": status,
        "new_user": newUser,
        "user_type": userType?.toJson(),
        "referral_code": referralCode,
        "address": address,
        "other_referral_code": otherReferralCode,
        "searchArray": List<String>.from(searchArray!.map((x) => x)),
      };
}

class UserType {
  UserType({
    this.isUser,
    this.isAgent,
  });

  bool? isUser;
  bool? isAgent;

  factory UserType.fromJson(Map<String, dynamic> json) => UserType(
        isUser: json["is_user"],
        isAgent: json["is_agent"],
      );

  Map<String, dynamic> toJson() => {
        "is_user": isUser ?? true,
        "is_agent": isAgent ?? false,
      };
}