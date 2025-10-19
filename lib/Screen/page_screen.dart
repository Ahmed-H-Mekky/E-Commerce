import 'package:e_commerce/Screen/pagBottomNavigationBarItem.dart/page_carte.dart';
import 'package:e_commerce/cubit/cubitAddCart/cubit/cubit_add_cart.dart';
import 'package:e_commerce/cubit/cubitAddCart/state/state_add_cart.dart';
import 'package:e_commerce/cubit/cubitGet/cubit/cuibit_all_category.dart';
import 'package:e_commerce/cubit/cubitGet/cubit/cuibte_get.dart';
import 'package:e_commerce/cubit/cubitSwitchPage/cubit/cubit_switch_page.dart';
import 'package:e_commerce/cubit/cubitSwitchPage/state/state_switch_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});
  static const String id = 'MyHomePage';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CubitSwitchPage, StateSwitchPage>(
      builder: (context, state) {
        if (state is ShoesPageSwitchState) {
          return Scaffold(
            appBar: state.index == 0
                ? AppBar(
                    backgroundColor: Colors.transparent,
                    title: const Text('الحسين ستور'),
                    centerTitle: true,
                    actions: [
                      //  BlocBuilder لعرض عداد السلة
                      BlocBuilder<Cubitaddcart, Stateaddcart>(
                        builder: (context, cartState) {
                          int itemCount = 0;

                          if (cartState is AddCartState) {
                            itemCount = cartState.mapAdd.length;
                          }

                          return Stack(
                            clipBehavior: Clip.none,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, Pagecarte.id);
                                },
                                icon: const Icon(
                                  FontAwesomeIcons.cartShopping,
                                  color: Colors.black,
                                ),
                              ),
                              if (itemCount > 0)
                                Positioned(
                                  right: 6,
                                  top: 6,
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Text(
                                      '$itemCount',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                    ],
                  )
                : null,

            body: state.page,

            bottomNavigationBar: BottomNavigationBar(
              currentIndex: state.index,
              onTap: (value) {
                context.read<CubitSwitchPage>().switchPage(value);

                if (value == 0) {
                  // تحميل البيانات فقط عند العودة للصفحة الرئيسية
                  context.read<CuibteAllProduect>().getrResepons();
                  context.read<CuibitAllCategory>().allCategory();
                }
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home, color: Colors.grey),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.searchengin, color: Colors.grey),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.cartShopping, color: Colors.grey),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite, color: Colors.grey),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person, color: Colors.grey),
                  label: '',
                ),
              ],
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
