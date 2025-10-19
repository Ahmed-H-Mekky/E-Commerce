import 'package:e_commerce/cubit/cubitAddCart/state/state_add_cart.dart';
import 'package:e_commerce/servers/addCart/addcart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Cubitaddcart extends Cubit<Stateaddcart> {
  Cubitaddcart() : super(InitialStateAddCart());
  Addcart addcart = Addcart();

  Future<void> loadAdd() async {
    await addcart.loadAddCart();
    emit(AddCartState(mapAdd: addcart.listAdd));
  }

  Future<void> addCart({required Map<String, dynamic> addMapp}) async {
    await addcart.addcart(
      mapadd: addMapp,
      add: () {
        emit(AddCartState(mapAdd: addcart.listAdd));
      },
    );
  }

  Future<void> removCart({required String nameproduct}) async {
    await addcart.rewoveCart(
      nameProduct: nameproduct,
      remove: () {
        emit(RemovCartState(nameProduct: nameproduct));
        emit(AddCartState(mapAdd: addcart.listAdd));
      },
    );
  }
}
