import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Additems {
  List<Map<String, dynamic>> listFavorite = [];
  Future<void> loadFavorites() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? data = prefs.getString('favoritslist');
    if (data != null) {
      List<dynamic> decod = await jsonDecode(data);
      listFavorite = decod.map((e) {
        return Map<String, dynamic>.from(e);
      }).toList();
    }
  }

  Future<void> _saveFavorites() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('favoritslist', jsonEncode(listFavorite));
  }

  Future<void> additemesFavorit({
    required Map<String, dynamic> mapItem,
    required Function() add,
  }) async {
    bool items = listFavorite.any((item) {
      return item['title'] == mapItem['title'];
    });
    if (!items) {
      listFavorite.add(mapItem);
      //حفظ
      await _saveFavorites();
      add();
    }
  }

  Future<void> removeFavorite({
    required String title,
    required Function() remove,
  }) async {
    listFavorite = listFavorite.where((favo) {
      return favo['title'] != title;
    }).toList();
    //ازاله
    await _saveFavorites();
    remove();
  }

  List<Map<String, dynamic>> getAllFavorites() {
    return listFavorite;
  }
}
