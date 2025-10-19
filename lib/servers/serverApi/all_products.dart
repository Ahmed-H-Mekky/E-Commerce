import 'package:e_commerce/model/model_product.dart';
import 'package:e_commerce/servers/api/api_calsse.dart';

class AllProductse {
  Future<List<Modelproduct>> getAllCategory() async {
    List<dynamic> dataAllCatrgory = await Api().getData(
      url: 'https://fakestoreapi.com/products',
    );

    List<Modelproduct> products = dataAllCatrgory.map((e) {
      return Modelproduct.fromjson(e);
    }).toList();

    return products;
  }
}
