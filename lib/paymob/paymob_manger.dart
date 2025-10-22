import 'package:dio/dio.dart';
import 'package:e_commerce/paymob/constants.dart';

class PaymobManager {
  Future<String> getPaymentKey(int amount, String currency) async {
    try {
      String authToken = await _getAuthToken();

      int orderId = await _getOrderId(
        authToken: authToken,
        amount: amount,
        currency: currency,
      );

      String paymentKey = await _getPaymentKey(
        authToken: authToken,
        orderId: orderId,
        amount: amount,
        currency: currency,
      );

      return paymentKey;
    } catch (e, stacktrace) {
      rethrow;
    }
  }

  Future<String> _getAuthToken() async {
    final Response response = await Dio().post(
      "https://accept.paymob.com/api/auth/tokens",
      data: {"api_key": KConstants.apiKey},
    );
    return response.data["token"];
  }

  Future<int> _getOrderId({
    required String authToken,
    required int amount,
    required String currency,
  }) async {
    final Response response = await Dio().post(
      "https://accept.paymob.com/api/ecommerce/orders",
      data: {
        "auth_token": authToken,
        "amount_cents": amount * 100, // اضرب في 100
        "currency": currency,
        "delivery_needed": false,
        "items": [],
      },
    );
    return response.data["id"];
  }

  Future<String> _getPaymentKey({
    required String authToken,
    required int orderId,
    required int amount,
    required String currency,
  }) async {
    final Response response = await Dio().post(
      "https://accept.paymob.com/api/acceptance/payment_keys",
      data: {
        "auth_token": authToken,
        "amount_cents": amount * 100,
        "order_id": orderId.toString(),
        "integration_id": KConstants.cardPaymentMethodIntegrationId,
        "currency": currency,
        "expiration": 3600,
        "billing_data": {
          "first_name": "Clifford",
          "last_name": "Nicolas",
          "email": "claudette09@exa.com",
          "phone_number": "+86(8)9135210487",
          "apartment": "NA",
          "floor": "NA",
          "street": "NA",
          "building": "NA",
          "shipping_method": "NA",
          "postal_code": "NA",
          "city": "NA",
          "country": "NA",
          "state": "NA",
        },
      },
    );
    return response.data["token"];
  }
}
