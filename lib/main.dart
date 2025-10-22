import 'package:e_commerce/Screen/opt.dart';
import 'package:e_commerce/Screen/pagBottomNavigationBarItem.dart/page_carte.dart';
import 'package:e_commerce/Screen/pagBottomNavigationBarItem.dart/page_favouret.dart';
import 'package:e_commerce/Screen/page_screen.dart';
import 'package:e_commerce/Screen/page_screen_deatils.dart';
import 'package:e_commerce/Screen/page_get_category.dart';
import 'package:e_commerce/Screen/sing_in_page.dart';
import 'package:e_commerce/cubit/cubitAddCart/cubit/cubit_add_cart.dart';
import 'package:e_commerce/cubit/cubitAddFavorite/cubit/cubit_favorite.dart';
import 'package:e_commerce/cubit/cubitSearch/cubit/cubit_search.dart';
import 'package:e_commerce/cubit/cubitSignIn/cubit/cubit_signin.dart';
import 'package:e_commerce/cubit/cubitGet/cubit/cuibit_all_category.dart';
import 'package:e_commerce/cubit/cubitGet/cubit/cuibte_category_name.dart';
import 'package:e_commerce/cubit/cubitGet/cubit/cuibte_get.dart';
import 'package:e_commerce/cubit/cubitSwitchPage/cubit/cubit_switch_page.dart';
import 'package:e_commerce/cubit/cubitTimer/cubit/cubit_timer.dart';
import 'package:e_commerce/stripe_payment/strip_key_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "key.env"); // مهم جداً
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final prefs = await SharedPreferences.getInstance();
  final bool logged = prefs.getBool('logged') ?? false; // تحديد حالة الدخول
  Stripe.publishableKey = StripKeyApi.publishableKey;

  await Stripe.instance.applySettings();
  runApp(MyApp(logged: logged)); //  تمرير القيمة
}

class MyApp extends StatelessWidget {
  final bool logged;
  const MyApp({super.key, required this.logged});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final cubit = CuibteAllProduect();
            cubit.getrResepons();
            return cubit;
          },
        ),
        BlocProvider(
          create: (context) {
            final cubit = CuibitAllCategory();
            cubit.allCategory();

            return cubit;
          },
        ),
        BlocProvider(create: (context) => CuibteCategoryName()),
        BlocProvider(create: (context) => CubitSignin()),
        BlocProvider(create: (context) => CubitSwitchPage()..switchPage(0)),
        BlocProvider(create: (context) => CubitTimer()),
        BlocProvider(create: (context) => Cubitaddcart()),
        //لو عاوز البيانت تحمل اول ما يفتح الصفحهعل طول
        BlocProvider(
          create: (context) {
            final cubit = CubitAddItemsToFavorite();
            cubit.loadFavorits();
            return cubit;
          },
        ),
        BlocProvider(create: (context) => CubitSearch()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: logged ? MyHomePage.id : SingInPage.id,
        routes: {
          SingInPage.id: (context) => const SingInPage(),
          Pagescreendeatils.id: (context) => Pagescreendeatils(),
          PageGetCategory.id: (context) => PageGetCategory(),
          Opt.id: (context) => Opt(),
          MyHomePage.id: (context) => const MyHomePage(),
          Pagefavouret.id: (context) => Pagefavouret(),
          Pagecarte.id: (context) => Pagecarte(),
        },
      ),
    );
  }
}
