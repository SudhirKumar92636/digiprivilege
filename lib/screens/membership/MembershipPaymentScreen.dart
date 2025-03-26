import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:membership/models/UserMembershipDetailsModel.dart';
import 'package:membership/models/membership/CouponDetailsModel.dart';
import 'package:membership/screens/membership/services/MembershipPaymentService.dart';
import 'package:membership/screens/membership/services/MembershipService.dart';
import 'package:membership/utils/Global/global.dart';
import 'package:membership/utils/data/data_storage.dart';
import 'package:membership/utils/functions/randomValues.dart';
import 'package:membership/utils/styles/buttonStyle.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../models/membership/MembershipDetailsModel.dart';
import '../../utils/styles/textStyle.dart';
import 'SuccessfulMembershipBuyScreen.dart';
import 'components/OfferDetailsComponent.dart';

class MembershipPaymentScreen extends StatefulWidget {
  final MembershipDetailsModel membershipDetailsData;
  final List<CouponDetailsModel> couponData;

  const MembershipPaymentScreen({
    Key? key,
    required this.membershipDetailsData,
    required this.couponData,
  }) : super(key: key);

  @override
  State<MembershipPaymentScreen> createState() =>
      _MembershipPaymentScreenState(membershipDetailsData);
}

class _MembershipPaymentScreenState extends State<MembershipPaymentScreen> {
  final MembershipDetailsModel membershipDetailsData;
  var id = "user_mem_${generateRandomString(10)}";

  _MembershipPaymentScreenState(this.membershipDetailsData);

  late Razorpay _razorpay;
  String newOrderId = "";

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  Future<void> generate_ODID() async {
    var userId = await AppData.getString(userIdKey);
    var userName = await AppData.getString(firstNameKey);
    var userNumber = await AppData.getString(mobileKey);
    var userEmail = await AppData.getString(emailKey);
    var receipt = "order_${generateRandomString(10)}";
    var memNumber = generateRandomInteger(5);
    var orderOptions = {
      'amount': (membershipDetailsData.price ?? 0) * 100,
      'currency': "INR",
      'receipt': receipt
    };
    final client = HttpClient();
    final request =
        await client.postUrl(Uri.parse('https://api.razorpay.com/v1/orders'));
    request.headers
        .set(HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");
    String basicAuth = 'Basic ${base64Encode(utf8.encode(
            '${'rzp_test_VGLEqLlosyRIg3'}:${'mKBa1xPDGaMAVdtBBHBnn82h'}'))}';
    request.headers.set(HttpHeaders.authorizationHeader, basicAuth);
    request.add(utf8.encode(json.encode(orderOptions)));
    final response = await request.close();
    response.transform(utf8.decoder).listen((contents) {
      String orderId = contents.split(',')[0].split(":")[1];
      orderId = orderId.substring(1, orderId.length - 1);

      Map<String, dynamic> checkoutOptions = {
         'user_id': userId,
        'key': 'rzp_test_VGLEqLlosyRIg3',
        'amount': ((membershipDetailsData.price ?? 0) * 100).toInt(),
        'name': userName ?? 'User',
         'order_id': (orderId??"0").toInt(),
        'theme': {'color': "#000000"},
        'description': 'Payment for membership',
        'prefill': {
          'contact': userNumber,
          'email': (userEmail ?? 'test@example.com').toString()
        },
        'external': {
          'wallets': ['paytm']
        }
      };




      try {
          MembershipPaymentService()
              .addUserMembershipData(
              UserMembershipDetailsModel(
                  id: id,
                  agentId: agentId,
                  brandId: membershipDetailsData.brandId,
                  membershipId: membershipDetailsData.id,
                  createdAt: Timestamp.now(),
                  userId: userId,
                  userName: userName,
                  description: membershipDetailsData.desc ?? "",
                  title: membershipDetailsData.title,
                  paymentStatus: "success",
                  paymentId: "r",
                  imageUrl: membershipDetailsData.heroImageUrl,
                  membershipStatus: "active",
                  membershipNumber: memNumber,
                  purchaseAt: Timestamp.now(),
                  brandLogoUrl: membershipDetailsData.brandLogoUrl,
                  brandName: membershipDetailsData.brandName,
                  images: membershipDetailsData.images,
                  duration: membershipDetailsData.duration,
                  unit: membershipDetailsData.unit,
                  price: membershipDetailsData.price.toString(),
                  orderId: orderId,
                  isVerified: false,
                  isFoodWithoutStay:
                  membershipDetailsData.is_food_without_stay),
              id)
              .then((preValue) {
            MembershipService()
                .getAllHotel(userId, widget.membershipDetailsData.id ?? "")
                .then((inValue) => {

              for (var element = 0; element < inValue.length; ++element){
                  MembershipPaymentService().addUserMembershipBrandData(inValue[element], id, "user_bra_${generateRandomString(10)}")
                }
            });
          });
          _razorpay.open(checkoutOptions);
        } catch (e) {
          print("Error show:---${e.toString()}");
          Fluttertoast.showToast(msg: "Something went wrong");
        }
      // });
    });
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    Fluttertoast.showToast(msg: " Payment SUCCESSFUL");
    const SuccessfulMembershipBuyScreen().launch(context);
  }

  Future<void> addCouponList(
      List<CouponDetailsModel> list, String userId) async {
    var userFName = await AppData.getString(firstNameKey);
    var userLName = await AppData.getString(lastNameKey);

    if (userId == null) {
      userId = FirebaseAuth.instance.currentUser!.uid;
    }
    for (var i = 0; i < list.length; ++i) {
      int numberOfCoupons = list[i].number_of_coupons ?? 1;
      if (list[i].number_of_coupons != null) {
        for (var j = 0; j < numberOfCoupons; ++j) {
          var couponId = "user_cou_${generateRandomString(10)}";
          MembershipPaymentService().addCouponsDetails(couponId, {
            "id": couponId,
            "agent_id": agentId,
            "brand_id": list[i].brand_id,
            "brand_name": list[i].brandName,
            "membership_id": id,
            "user_id": userId,
            "user_name": "$userFName $userLName",
            "created_at": Timestamp.now(),
            "coupon_id": list[i].couponId,
            "purchased_at": Timestamp.now(),
            "payment_status": "success",
            "coupon_status": "active",
            "current_status": "active",
            "title": list[i].title,
            "description": list[i].description,
            "expire_on": list[i].expireOn,
            "partner_id": list[i].partnerId ?? "",
            "is_booking": list[i].isBooking,
            "booking_date": "",
            "coupon_image": list[i].couponImage,
            "coupon_type": list[i].couponType,
            "brand_logo": list[i].brandLogo,
            "color": list[i].colorCode,
            "number_of_people": list[i].number_of_people,
            "number_of_coupons": 1,
            "tearms_of_use": list[i].termOfUse,
            "price": list[i].price,
            "type": list[i].type,
            "rejection_reason": " ",
            "is_stay": false
          });
        }
      } else {
        var couponId = "user_cou_${generateRandomString(10)}";
        MembershipPaymentService().addCouponsDetails(couponId, {
          "id": couponId,
          "agent_id": agentId,
          "brand_name": membershipDetailsData.brandName,
          "membership_id": widget.membershipDetailsData.id,
          "user_id": userId,
          "user_name": "$userFName $userLName",
          "created_at": Timestamp.now(),
          "coupon_id": list[i].couponId,
          "purchased_at": Timestamp.now(),
          "payment_status": "success",
          "coupon_status": "active",
          "current_status": "active",
          "title": list[i].title,
          "description": list[i].description,
          "expire_on": list[i].expireOn,
          "partner_id": list[i].partnerId ?? "",
          "is_booking": list[i].isBooking,
          "coupon_image": list[i].couponImage,
          "coupon_type": list[i].couponType,
          "brand_logo": list[i].brandLogo,
          "color": list[i].colorCode,
          "number_of_people": list[i].number_of_people,
          "number_of_coupons": 1,
          "tearms_of_use": list[i].termOfUse,
          "price": list[i].price,
          "type": list[i].type,
          "brand_id": list[i].brand_id,
          "rejection_reason": " ",
          "is_stay": false
        });
      }
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    paymentFailedDialog(context, generate_ODID);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("error response $response")));
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(msg: "EXTERNAL_WALLET: ");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 10.h,
      decoration: boxDecorationWithRoundedCorners(
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    "Total Price : ",
                    style: GoogleFonts.aleo(),
                  ),
                  Text(
                    "$rupee${membershipDetailsData.price}",
                    style: boldTextStyle(),
                  ),
                ],
              ),
            ],
          ),
          ElevatedButton(
            style: elevatedButtonStyle(6.h, 50.w),
            onPressed: () {
              generate_ODID();
            },
            child: Text(
              " Buy Now ",
              style: boldTextStyle(size: 20),
            ),
          )
        ],
      ),
    );
  }
}