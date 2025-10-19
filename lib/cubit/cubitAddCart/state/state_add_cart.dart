abstract class Stateaddcart {}

class InitialStateAddCart extends Stateaddcart {}

class AddCartState extends Stateaddcart {
  final List<Map<String, dynamic>> mapAdd;
  AddCartState({required this.mapAdd});
}

class RemovCartState extends Stateaddcart {
  final String nameProduct;
  RemovCartState({required this.nameProduct});
}
