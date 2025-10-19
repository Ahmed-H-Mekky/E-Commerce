import 'package:e_commerce/model/model_product.dart';
import 'package:e_commerce/servers/api/api_calsse.dart';

class PostAddProdut {
  Future<Modelproduct> postAdd({
    required String title,
    required String price,
    required String description,
    required String image,
    required String category,
  }) async {
    Map<String, dynamic> data = await Api().postAddProduct(
      url: 'https://fakestoreapi.com/products',
      token: null,
      bodyData: {
        "title": title,
        "price": price,
        "description": description,
        "image": image,
        "category": category,
      },
    );
    return Modelproduct.fromjson(data);
  }
}
