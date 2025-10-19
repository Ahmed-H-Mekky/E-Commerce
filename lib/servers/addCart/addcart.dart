// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';

// class Addcart {
//   List<Map<String, dynamic>> listAdd = [];
//   Future<void> loadAddCart() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? dataAtCart = prefs.getString('addCart');
//     if (dataAtCart != null) {
//       List<dynamic> listDecod = jsonDecode(dataAtCart);
//       listAdd = listDecod.map((elemnt) {
//         return Map<String, dynamic>.from(elemnt);
//       }).toList();
//       return;
//     }
//   }

//   Future<void> _saveDataCart() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('addCart', jsonEncode(listAdd));
//   }

//   Future<void> addcart({
//     required Map<String, dynamic> mapadd,
//     required Function() add,
//   }) async {
//     listAdd.add(mapadd);
//     await _saveDataCart();
//     add();
//   }

//   Future<void> rewoveCart({
//     required String nameProduct,
//     required Function() remove,
//   }) async {
//     listAdd = listAdd.where((e) {
//       return e['title'] != nameProduct;
//     }).toList();
//     await _saveDataCart();
//     remove();
//   }

//   List<Map<String, dynamic>> getAttItemToCart() {
//     return listAdd;
//   }
// }
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Addcart {
  List<Map<String, dynamic>> listAdd = [];

  Future<void> loadAddCart() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('cartlist');
    if (data != null) {
      List<dynamic> decoded = jsonDecode(data);
      listAdd = decoded.map((e) => Map<String, dynamic>.from(e)).toList();
    }
  }

  Future<void> _saveCart() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('cartlist', jsonEncode(listAdd));
  }

  Future<void> addcart({
    required Map<String, dynamic> mapadd,
    required Function() add,
  }) async {
    // ✅ تحقق هل المنتج موجود أصلاً
    int index = listAdd.indexWhere((item) => item['title'] == mapadd['title']);

    if (index != -1) {
      // ✅ لو موجود، زوّد الكمية بدل الإضافة الجديدة
      listAdd[index]['quantity'] += mapadd['quantity'];
    } else {
      // ✅ لو مش موجود، أضفه كمنتج جديد
      listAdd.add(mapadd);
    }

    // ✅ احفظ بعد التعديل
    await _saveCart();
    add();
  }

  Future<void> rewoveCart({
    required String nameProduct,
    required Function() remove,
  }) async {
    listAdd.removeWhere((item) => item['title'] == nameProduct);
    await _saveCart();
    remove();
  }
}
