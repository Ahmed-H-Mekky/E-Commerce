import 'package:e_commerce/cubit/cubitSearch/state/stat_search.dart';
import 'package:e_commerce/servers/serverApi/search_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CubitSearch extends Cubit<StatSearch> {
  CubitSearch() : super(InitialSearchState());

  Future<void> search({required String nameProduct}) async {
    emit(LoadingSearchState());
    try {
      final searchItem = SearchItem();
      await searchItem.searchAtProduct(nameProduct: nameProduct);
      emit(SuccessfulSearchState(nameProducte: searchItem.searchresult));
    } catch (e) {
      emit(FailureSearchState(message: e.toString()));
    }
  }

  void clearSearch() {
    emit(InitialSearchState());
  }
}
