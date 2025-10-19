import 'package:firebase_auth/firebase_auth.dart';

abstract class StateSignin {}

class InialeStateSignin extends StateSignin {}

class LoadingStateSignin extends StateSignin {}

class VerifiedStateSignin extends StateSignin {
  final User user;
  VerifiedStateSignin({required this.user});
}

class CodeSentStateSignin extends StateSignin {
  // final String smsCode;
  CodeSentStateSignin();
}

class FailureStateSignin extends StateSignin {
  final String errorMessage;
  FailureStateSignin({required this.errorMessage});
}

class SignOutState extends StateSignin {}
