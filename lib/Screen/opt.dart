import 'package:e_commerce/Screen/page_screen.dart';
import 'package:e_commerce/cubit/cubitSignIn/cubit/cubit_signin.dart';
import 'package:e_commerce/cubit/cubitSignIn/state/state_signin.dart';
import 'package:e_commerce/cubit/cubitTimer/cubit/cubit_timer.dart';
import 'package:e_commerce/cubit/cubitTimer/state/state_timer.dart';
import 'package:e_commerce/helps/showe_snake_bare.dart';
import 'package:e_commerce/widget/custom_botton.dart';
import 'package:e_commerce/widget/custom_pinput.dart';
import 'package:e_commerce/widget/custom_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class Opt extends StatelessWidget {
  Opt({super.key});
  static const String id = 'opt';

  TextEditingController pinControllerPhone = TextEditingController();

  late String phoneNumber;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      phoneNumber = ModalRoute.of(context)!.settings.arguments as String;
      context.read<CubitSignin>().sendCode(phoneNumber: phoneNumber);
      context.read<CubitTimer>().timerfunction(seconde: 30);
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('التحقق من الرقم'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: BlocConsumer<CubitSignin, StateSignin>(
        listener: (context, state) async {
          // عند نجاح التحقق
          if (state is VerifiedStateSignin) {
            showSnakeBare(
              context: context,
              message: const Text('تم التحقق بنجاح'),
            );

            //  حفظ حالة الدخول في SharedPreferences
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('logged', true);

            //  الانتقال للصفحة الرئيسية بدون الرجوع
            if (context.mounted) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                MyHomePage.id,
                (route) => false,
              );
            }
          }
          //في حالة الخطأ
          else if (state is FailureStateSignin) {
            showSnakeBare(
              context: context,
              message: Text('خطأ: ${state.errorMessage}'),
            );
          }
        },
        builder: (context, state) {
          if (state is LoadingStateSignin) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 120),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: CustomRichText(
                  onTap: () {},
                  textSpanString:
                      'سيحتاج التطبيق إلى التحقق من رقم هاتفك. قد تسري رسوم من شركة الاتصالات.',
                  textSpanBotton: 'ما هو رقمي؟',
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 30),

              // حقل إدخال كود التحقق
              CustomPinput(pinController: pinControllerPhone),

              const SizedBox(height: 20),

              // زر تأكيد الكود
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: CustomBotton(
                  backgroundColor: Colors.blue,
                  onpressed: () {
                    final smsCode = pinControllerPhone.text.trim();
                    if (smsCode.isNotEmpty) {
                      context.read<CubitSignin>().verifyCode(smsCode: smsCode);
                    } else {
                      showSnakeBare(
                        context: context,
                        message: const Text('الرجاء إدخال الكود المرسل'),
                      );
                    }
                  },
                  text: const Text('تأكيد الكود'),
                  icon: null,
                  iconColor: null,
                ),
              ),

              const SizedBox(height: 20),

              // إعادة إرسال الكود + العداد
              BlocBuilder<CubitTimer, StateTimer>(
                builder: (context, state) {
                  if (state is CurrentTimer) {
                    return Column(
                      children: [
                        CustomRichText(
                          onTap: () {
                            if (state.seconde == 0) {
                              context.read<CubitSignin>().sendCode(
                                phoneNumber: phoneNumber,
                              );
                              context.read<CubitTimer>().timerfunction(
                                seconde: 30,
                              ); //  إعادة البدء
                              showSnakeBare(
                                context: context,
                                message: const Text('تم إعادة إرسال الكود'),
                              );
                            }
                          },
                          textSpanString: 'لم تستلم الكود؟ ',
                          textSpanBotton: 'أعد الإرسال',
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'يمكنك إعادة الإرسال بعد: ${state.seconde} ثانية',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    );
                  } else {
                    // عند البداية قبل بدء العداد
                    return CustomRichText(
                      onTap: () {
                        context.read<CubitTimer>().timerfunction(seconde: 30);
                      },
                      textSpanString: 'لم تستلم الكود؟ ',
                      textSpanBotton: 'أعد الإرسال',
                      textAlign: TextAlign.center,
                    );
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
