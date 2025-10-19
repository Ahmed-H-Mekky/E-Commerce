import 'package:e_commerce/Screen/page_screen_deatils.dart';
import 'package:e_commerce/cubit/cubitAddFavorite/cubit/cubit_favorite.dart';
import 'package:e_commerce/cubit/cubitAddFavorite/state/state_favorite.dart';
import 'package:e_commerce/cubit/cubitGet/cubit/cuibte_category_name.dart';
import 'package:e_commerce/cubit/cubitGet/state/state_category_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class PageGetCategory extends StatelessWidget {
  PageGetCategory({super.key});
  static const String id = 'PageGetCategory';
  late String categoryName;
  // bool isfavorit = false;
  @override
  Widget build(BuildContext context) {
    categoryName = ModalRoute.of(context)!.settings.arguments as String;
    context.read<CuibteCategoryName>().categoryName(categoryname: categoryName);
    return Scaffold(
      appBar: AppBar(title: Text(categoryName), centerTitle: true),
      body: BlocBuilder<CuibteCategoryName, StateCategoryName>(
        builder: (context, state) {
          if (state is LoadingStateCategoryName) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SuccessStateCategoryName) {
            return GridView.builder(
              itemCount: state.data.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 16,
                childAspectRatio: 0.8,
              ),
              itemBuilder: (BuildContext context, int index) {
                final product = state.data[index];
                final itemMap = {
                  'title': product.title,
                  'price': product.price,
                  'image': product.image,
                };
                return Padding(
                  padding: const EdgeInsets.only(top: 120.0),
                  child: GestureDetector(
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 30,
                                offset: Offset(10, 10),
                                spreadRadius: .2,
                                color: Colors.grey.withValues(alpha: .2),
                              ),
                            ],
                          ),

                          width: 200,
                          height: 140,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 40),

                                  Text(
                                    state.data[index].title,
                                    style: TextStyle(
                                      color: const Color.fromARGB(
                                        255,
                                        91,
                                        90,
                                        90,
                                      ).withValues(alpha: 1),
                                      fontSize: 12,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          r'$'
                                          '${state.data[index].price}',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                          ),
                                        ),

                                        SizedBox(
                                          child:
                                              BlocBuilder<
                                                CubitAddItemsToFavorite,
                                                StateFavorite
                                              >(
                                                builder: (context, state) {
                                                  if (state
                                                      is StateAddFavoriteList) {
                                                    bool isfavorit = false;

                                                    isfavorit = state.items.any((
                                                      elemint,
                                                    ) {
                                                      return elemint['title'] ==
                                                          product.title;
                                                    });
                                                    return IconButton(
                                                      icon: Icon(
                                                        Icons.favorite,
                                                        color: isfavorit
                                                            ? Colors.red
                                                            : Colors.grey,
                                                      ),
                                                      onPressed: () {
                                                        if (isfavorit) {
                                                          context
                                                              .read<
                                                                CubitAddItemsToFavorite
                                                              >()
                                                              .removeItem(
                                                                title: product
                                                                    .title,
                                                              );
                                                        } else {
                                                          context
                                                              .read<
                                                                CubitAddItemsToFavorite
                                                              >()
                                                              .addItems(
                                                                itemMap:
                                                                    itemMap,
                                                              );
                                                        }
                                                      },
                                                    );
                                                  }
                                                  return Center(
                                                    child: Text(''),
                                                  );
                                                },
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: -100,
                          left: 60,
                          child: SizedBox(
                            width: 120,
                            height: 150,
                            child: ClipRRect(
                              borderRadius: BorderRadiusGeometry.circular(12),
                              child: Image.network(
                                state.data[index].image,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        Pagescreendeatils.id,
                        arguments: state.data[index],
                      );
                    },
                  ),
                );
              },
            );
          } else if (state is FailuerStateCategoryName) {
            return Center(child: Text('حدث خطأ: ${state.message}'));
          }

          return const Center(child: Text('جاري تحميل البيانات...'));
        },
      ),
    );
  }
}
