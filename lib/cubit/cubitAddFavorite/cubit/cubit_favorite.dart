import 'package:e_commerce/cubit/cubitAddFavorite/state/state_favorite.dart';
import 'package:e_commerce/servers/addFavorite/addItems.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CubitAddItemsToFavorite extends Cubit<StateFavorite> {
  final Additems _favoriteManager = Additems();

  CubitAddItemsToFavorite() : super(InitialStat());
  Future<void> loadFavorits() async {
    await _favoriteManager.loadFavorites();
    emit(StateAddFavoriteList(items: _favoriteManager.getAllFavorites()));
  }

  void addItems({required Map<String, dynamic> itemMap}) {
    _favoriteManager.additemesFavorit(
      mapItem: itemMap,
      add: () {
        emit(StateAddFavoriteList(items: _favoriteManager.getAllFavorites()));
      },
    );
  }

  void removeItem({required String title}) {
    _favoriteManager.removeFavorite(
      title: title,
      remove: () {
        emit(StateRemove(title: title));
        emit(StateAddFavoriteList(items: _favoriteManager.getAllFavorites()));
      },
    );
  }
}
