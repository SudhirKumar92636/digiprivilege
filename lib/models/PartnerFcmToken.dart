import 'dart:convert';

PartnerFcmToken partnerFcmTokenFromJson(String str) =>
    PartnerFcmToken.fromJson(json.decode(str));

String partnerFcmTokenToJson(PartnerFcmToken data) =>
    json.encode(data.toJson());

class PartnerFcmToken {
  PartnerFcmToken({
    this.fcmToken,
    this.partnerId,
  });

  String? fcmToken;
  String? partnerId;

  factory PartnerFcmToken.fromJson(Map<String, dynamic> json) =>
      PartnerFcmToken(
        fcmToken: json["fcm_token"],
        partnerId: json["partner_id"],
      );

  Map<String, dynamic> toJson() => {
        "fcm_token": fcmToken,
        "partner_id": partnerId,
      };
}