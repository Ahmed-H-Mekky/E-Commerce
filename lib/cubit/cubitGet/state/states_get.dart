import 'package:e_commerce/model/model_product.dart';

abstract class StatesAllProduect {}

class IntialStateAllProduect extends StatesAllProduect {}

class LoadingStateAllProduect extends StatesAllProduect {}

class SuccessStateAllProduect extends StatesAllProduect {
  final List<Modelproduct> data;
  SuccessStateAllProduect({required this.data});
}
class FailureStateAllProduect extends StatesAllProduect {
  final String message;
  FailureStateAllProduect({required this.message});
}
