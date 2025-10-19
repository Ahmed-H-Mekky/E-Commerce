abstract class StateAllCategory {}

class IntialStateCategory extends StateAllCategory {}

class LoadingStateCategory extends StateAllCategory {}

class SuccessStateCategory extends StateAllCategory {
  final List<String> categoryList;
  SuccessStateCategory({required this.categoryList});
}

class FailureStateCategory extends StateAllCategory {
  final String message;
  FailureStateCategory({required this.message});
}
