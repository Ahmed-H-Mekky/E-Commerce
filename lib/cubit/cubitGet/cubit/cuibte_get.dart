import 'package:e_commerce/cubit/cubitGet/state/states_get.dart';
import 'package:e_commerce/model/model_product.dart';
import 'package:e_commerce/servers/serverApi/all_products.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CuibteAllProduect extends Cubit<StatesAllProduect> {
  CuibteAllProduect() : super(IntialStateAllProduect());

  Future<void> getrResepons() async {
    try {
      emit(LoadingStateAllProduect());
      List<Modelproduct> data = await AllProductse().getAllCategory();
      emit(SuccessStateAllProduect(data: data));
    } catch (e) {
      emit(FailureStateAllProduect(message: e.toString()));
    }
  }
}
