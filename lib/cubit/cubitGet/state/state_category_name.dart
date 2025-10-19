import 'package:e_commerce/model/model_product.dart';

abstract class StateCategoryName {}

class InitailStateCategoryName extends StateCategoryName {}

class LoadingStateCategoryName extends StateCategoryName {}

class SuccessStateCategoryName extends StateCategoryName {
  final List<Modelproduct> data;
  SuccessStateCategoryName({required this.data});
}

class FailuerStateCategoryName extends StateCategoryName {
  final String message;

  FailuerStateCategoryName({required this.message});
}
