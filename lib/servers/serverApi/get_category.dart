import 'package:e_commerce/model/model_product.dart';
import 'package:e_commerce/servers/api/api_calsse.dart';

class GetCategoryName {
  Future<List<Modelproduct>> getCategory({required String categoryname}) async {
    List<dynamic> dataCatogry = await Api().getData(
      url: 'https://fakestoreapi.com/products/category/$categoryname',
    );
    List<Modelproduct> data = dataCatogry.map((e) {
      return Modelproduct.fromjson(e);
    }).toList();

    return data;
  }
}
