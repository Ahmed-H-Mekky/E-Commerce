import 'package:e_commerce/cubit/cubitSignIn/state/state_signin.dart';
import 'package:e_commerce/servers/serverApi/Sign_in_number.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CubitSignin extends Cubit<StateSignin> {
  final SignInNumber signInNumber = SignInNumber();

  CubitSignin() : super(InialeStateSignin());

  // إرسال الكود
  Future<void> sendCode({required String phoneNumber}) async {
    try {
      await signInNumber.verificationNumber(
        phoneNumber: phoneNumber,
        //  عند نجاح التحقق التلقائي، نخبر الكيوبت
        onVerified: (user) {
          emit(VerifiedStateSignin(user: user));
        },
        //  عند إرسال الكود
        onCodeSent: () {
          emit(CodeSentStateSignin());
        },
      );
    } catch (e) {
      //  عند فشل التحقق
      emit(FailureStateSignin(errorMessage: e.toString()));
    }
  }

  // تسجبل الخروج
  Future<void> signout() async {
    try {
      await signInNumber.signOut();
      emit(SignOutState());
    } catch (e) {
      emit(FailureStateSignin(errorMessage: e.toString()));
    }
  }

  // التحقق اليدوي
  Future<void> verifyCode({required String smsCode}) async {
    try {
      emit(LoadingStateSignin());
      final userCredential = await signInNumber.verifyCode(smsCode: smsCode);
      emit(VerifiedStateSignin(user: userCredential.user!));
    } catch (e) {
      emit(FailureStateSignin(errorMessage: e.toString()));
    }
  }
}
