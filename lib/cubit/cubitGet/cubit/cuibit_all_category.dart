import 'package:e_commerce/cubit/cubitGet/state/state_all_category.dart';
import 'package:e_commerce/servers/serverApi/all_categories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CuibitAllCategory extends Cubit<StateAllCategory> {
  CuibitAllCategory() : super(IntialStateCategory());
  Future<void> allCategory() async {
    try {
      emit(LoadingStateCategory());
      List<String> lastCategory = await AllCategories().getAllCategory();
      emit(SuccessStateCategory(categoryList: lastCategory));
    } catch (e) {
      emit(FailureStateCategory(message: e.toString()));
    }
  }
}
