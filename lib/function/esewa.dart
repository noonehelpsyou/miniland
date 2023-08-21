import 'package:esewa_flutter_sdk/esewa_flutter_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:miniland/constant/esewa.dart';
import 'package:esewa_flutter_sdk/esewa_config.dart';
import 'package:esewa_flutter_sdk/esewa_payment.dart';
import 'package:esewa_flutter_sdk/esewa_payment_success_result.dart';


class Esewa {
  final String amount;
  Esewa({required this.amount,});

  pay() {
    try {
EsewaFlutterSdk.initPayment(
    esewaConfig: EsewaConfig(
      environment: Environment.test,
      clientId: kEsewaClientId,
      secretId: kEsewaSecretKey,
    ),
    esewaPayment: EsewaPayment(
    productId: "1d71jd81",
  productName: "Product One",
  productPrice: amount,
),
    onPaymentSuccess: (EsewaPaymentSuccessResult result) {
      debugPrint("Success");
      verify(result);
    },
    onPaymentFailure: () {
    debugPrint("Failure");
    },
    onPaymentCancellation: () {
    debugPrint("Cancelation");
    });
    } catch(e) {
    debugPrint("Exception $e");
    }
  }


  verify(EsewaPaymentSuccessResult result){
    //TODO:: after successful payment
  }
}