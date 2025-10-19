import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInNumber {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  String? verificationId;
  int? resendToken;
  String? userPhone;

  Future<void> verificationNumber({
    required String phoneNumber,
    int? forceToken,
    Function(User)? onVerified, //  عند نجاح التحقق التلقائي
    Function()? onCodeSent, //  عند إرسال الكود
    Function(String error)? onFailed, // عند فشل العملية
  }) async {
    userPhone = phoneNumber;

    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 30),
      forceResendingToken: forceToken,

      // في حال التحقق التلقائي
      verificationCompleted: (credential) async {
        //لو تم التحقق يعمل تسجيل دخول
        final verificationNum = await auth.signInWithCredential(credential);
        onVerified?.call(verificationNum.user!); // نبلغ الكيوبت بنجاح التحقق
      },

      //  في حال فشل العملية
      verificationFailed: (FirebaseAuthException e) {
        onFailed?.call(e.message ?? 'حدث خطأ غير متوقع');
      },

      //  عند إرسال الكود
      codeSent: (String verId, int? token) async {
        verificationId = verId;
        resendToken = token;
        // بحفظ الرقم في الفيربيز
        var usersRef = firestore.collection('users');
        //بعمل مقارنه هل ارقم موجود ولا لاءه حتي لا يتكرر
        var query = await usersRef.where('phone', isEqualTo: phoneNumber).get();

        if (query.docs.isEmpty) {
          await usersRef.add({'phone': phoneNumber});
        }

        onCodeSent?.call();
      },

      //  عند انتهاء الوقت المخصص للكود
      codeAutoRetrievalTimeout: (String verId) {
        verificationId = verId;
      },
    );
  }

  // التحقق من الكود لو اليدوي لو لم يتحقق اتوماتيكي
  Future<UserCredential> verifyCode({required String smsCode}) async {
    if (verificationId == null) {
      throw Exception('لم يتم العثور على معرف التحقق');
    } else {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId!,
        smsCode: smsCode,
      );

      final userCredential = await auth.signInWithCredential(credential);

      // بعد تسجيل الدخول بنجاح، احفظ رقم الهاتف في Firestore إن لم يكن موجود
      final usersRef = firestore.collection('users');
      final query = await usersRef.where('phone', isEqualTo: userPhone).get();

      if (query.docs.isEmpty) {
        await usersRef.add({'phone': userPhone});
      }
      return userCredential;
    }
  }

  Future<void> signOut() async {
    //  تسجيل الخروج من Firebase
    await FirebaseAuth.instance.signOut();

    //  إزالة حالة الدخول من SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('logged');
  }
}
