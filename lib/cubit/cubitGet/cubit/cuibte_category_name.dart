import 'package:e_commerce/cubit/cubitGet/state/state_category_name.dart';
import 'package:e_commerce/model/model_product.dart';
import 'package:e_commerce/servers/serverApi/get_category.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CuibteCategoryName extends Cubit<StateCategoryName> {
  CuibteCategoryName() : super(InitailStateCategoryName());
  Future<void> categoryName({required String categoryname}) async {
    try {
      emit(LoadingStateCategoryName());
      List<Modelproduct> data = await GetCategoryName().getCategory(
        categoryname: categoryname,
      );
      emit(SuccessStateCategoryName(data: data));
    } catch (e) {
      emit(FailuerStateCategoryName(message: e.toString()));
    }
  }
}
