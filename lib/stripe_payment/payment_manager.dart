import 'package:dio/dio.dart';
import 'package:e_commerce/stripe_payment/strip_key_api.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter/material.dart';

abstract class PaymentManager {
  static Future<void> makePayment({
    required int amount,
    required String currency,
  }) async {
    try {
      // 1 إنشاء PaymentIntent في Stripe والحصول على client_secret
      final String clientSecret = await _getClientSecret(
        (amount * 100)
            .toString(), // Stripe يحتاج المبلغ بأصغر وحدة (قرش أو سنت)
        currency,
      );

      // 2 تهيئة صفحة الدفع
      await _initializePayment(clientSecret);

      // 3 عرض صفحة الدفع للمستخدم
      await Stripe.instance.presentPaymentSheet();
    } catch (e) {
      rethrow;
    }
  }
}

///  تهيئة واجهة الدفع (Payment Sheet)
Future<void> _initializePayment(String clientSecret) async {
  await Stripe.instance.initPaymentSheet(
    paymentSheetParameters: SetupPaymentSheetParameters(
      paymentIntentClientSecret: clientSecret,
      merchantDisplayName: 'Ahmed Store', // يظهر للمستخدم
      style: ThemeMode.light,
      allowsDelayedPaymentMethods: true, // يتيح بطاقات مؤجلة الدفع
    ),
  );
}

///  إنشاء PaymentIntent عبر API Stripe
Future<String> _getClientSecret(String amount, String currency) async {
  Dio dio = Dio();

  var response = await dio.post(
    'https://api.stripe.com/v1/payment_intents',
    options: Options(
      headers: {
        'Authorization': 'Bearer ${StripKeyApi.secretKey}',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    ),
    data: {
      'amount': amount,
      'currency': currency,
      'automatic_payment_methods[enabled]': 'true', // مهم جدًا لتفعيل طرق الدفع
    },
  );

  return response.data['client_secret'];
}
