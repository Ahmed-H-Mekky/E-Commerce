abstract class StatSearch {}

class InitialSearchState extends StatSearch {}

class LoadingSearchState extends StatSearch {}

class SuccessfulSearchState extends StatSearch {
  final List<dynamic> nameProducte;
  SuccessfulSearchState({required this.nameProducte});
}

class FailureSearchState extends StatSearch {
  final String message;
  FailureSearchState({required this.message});
}
