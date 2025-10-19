import 'package:e_commerce/Screen/sing_in_page.dart';
import 'package:e_commerce/cubit/cubitSignIn/cubit/cubit_signin.dart';
import 'package:e_commerce/cubit/cubitSignIn/state/state_signin.dart';
import 'package:e_commerce/helps/showe_snake_bare.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PageAcount extends StatelessWidget {
  const PageAcount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الملف الشخصي'), centerTitle: true),
      body: Center(
        child: BlocConsumer<CubitSignin, StateSignin>(
          listener: (context, state) {
            if (state is FailureStateSignin) {
              showSnakeBare(
                context: context,
                message: Text(state.errorMessage.toString()),
              );
            } else if (state is SignOutState) {
              // ✅ عند نجاح تسجيل الخروج، ننتقل لصفحة تسجيل الدخول
              Navigator.pushNamedAndRemoveUntil(
                context,
                SingInPage.id,
                (route) => false,
              );
            }
          },
          builder: (context, state) {
            return ElevatedButton.icon(
              icon: const Icon(Icons.logout),
              label: const Text('تسجيل الخروج'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                textStyle: const TextStyle(fontSize: 18),
              ),
              onPressed: () {
                context.read<CubitSignin>().signout();
              },
            );
          },
        ),
      ),
    );
  }
}
