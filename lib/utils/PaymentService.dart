import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentService {
  final _razorpay = Razorpay();

  paymentInit() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
  }

  onSuccess() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
        (PaymentSuccessResponse successResponse) {
      Logger().i(successResponse.paymentId);
      Fluttertoast.showToast(msg: successResponse.paymentId!);
    });
  }

  handlePaymentSuccess(PaymentSuccessResponse successResponse) {
    Logger().i(successResponse.paymentId);
    Fluttertoast.showToast(msg: successResponse.paymentId!);
  }

  handlePaymentError(PaymentFailureResponse failureResponse) {
    Logger().i(failureResponse.message);
    Fluttertoast.showToast(msg: failureResponse.message!);
  }

  ExternalWalletResponse handleExternalWallet(
          ExternalWalletResponse walletResponse) =>
      walletResponse;

  void pushDataOnRazorpay(PaymentOptions data) async {
    var options = {
      'user_id': data.userId,
      'name': data.userName,
      'send_sms_hash': true,
      'amount': data.payableAmount * 100,
      'prefill': {'contact': data.phone, 'email': data.email},
      'key': data.key,
      "timeout": data.timeout,
      "theme.color": data.colorCode,
      'external': {
        'wallets': ['paytm']
      },
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }
}

class PaymentOptions {
  String userId;
  String userName;
  double payableAmount;
  String phone;
  String email;
  String key;
  String timeout;
  String colorCode;

  PaymentOptions(this.userId, this.userName, this.payableAmount, this.phone,
      this.email, this.key, this.timeout, this.colorCode);
}
