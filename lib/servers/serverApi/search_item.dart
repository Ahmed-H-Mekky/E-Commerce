import 'package:e_commerce/model/model_product.dart';
import 'package:e_commerce/servers/serverApi/all_products.dart';

class SearchItem {
  List<Modelproduct> searchresult = [];
  Future<List<Modelproduct>> getAllproduct = AllProductse().getAllCategory();
  Future<void> searchAtProduct({required String nameProduct}) async {
    List<Modelproduct> allProducts = await getAllproduct;
    searchresult = allProducts.where((element) {
      return element.title.toLowerCase().startsWith(nameProduct.toLowerCase());
    }).toList();
  }
}
