import 'package:e_commerce/servers/api/api_calsse.dart';

class AllCategories {
  Future<List<String>> getAllCategory() async {
    List<dynamic> dataCategory = await Api().getData(
      url: 'https://fakestoreapi.com/products/categories',
    );
    List<String> categories = dataCategory.map((e) => e.toString()).toList();

    return categories;
  }
}
