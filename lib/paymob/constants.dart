import 'package:flutter_dotenv/flutter_dotenv.dart';

class KConstants {
  static String get apiKey => dotenv.env['API_KEY'] ?? '';
  static String get cardPaymentMethodIntegrationId =>
      dotenv.env['CARD_METHOD_ID'] ?? '';
  static String get secretKey => dotenv.env['Secret_Key'] ?? '';
  static String get publishableKey => dotenv.env['Publishable_Key'] ?? '';
}
