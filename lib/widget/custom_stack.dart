import 'package:e_commerce/Screen/page_screen_deatils.dart';
import 'package:e_commerce/cubit/cubitAddFavorite/cubit/cubit_favorite.dart';
import 'package:e_commerce/cubit/cubitAddFavorite/state/state_favorite.dart';
import 'package:e_commerce/helps/showe_snake_bare.dart';
import 'package:e_commerce/model/model_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomStack extends StatelessWidget {
  CustomStack({super.key, required this.data});
  final Modelproduct data;
  // bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    final item = {
      'title': data.title,
      'price': data.price.toString(),
      'image': data.image.toString(),
    };
    return GestureDetector(
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
                      data.title,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            r'$'
                            '${data.price}',
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                          SizedBox(
                            child:
                                BlocBuilder<
                                  CubitAddItemsToFavorite,
                                  StateFavorite
                                >(
                                  builder: (context, state) {
                                    bool isFavorite = false;
                                    if (state is StateAddFavoriteList) {
                                      isFavorite = state.items.any(
                                        (item) => item['title'] == data.title,
                                      );
                                    }
                                    return IconButton(
                                      onPressed: () {
                                        if (isFavorite) {
                                          context
                                              .read<CubitAddItemsToFavorite>()
                                              .removeItem(title: data.title);
                                          showSnakeBare(
                                            context: context,
                                            message: Text(
                                              'تم الحذف من المفضلة',
                                            ),
                                          );
                                        } else {
                                          context
                                              .read<CubitAddItemsToFavorite>()
                                              .addItems(itemMap: item);
                                          showSnakeBare(
                                            context: context,
                                            message: Text(
                                              'تمت الإضافة للمفضلة',
                                            ),
                                          );
                                        }
                                      },
                                      icon: Icon(
                                        Icons.favorite,
                                        color: isFavorite
                                            ? Colors.red
                                            : Colors.grey,
                                      ),
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
                child: CachedNetworkImage(
                  imageUrl: data.image,
                  fit: BoxFit.fill,
                  width: 120,
                  height: 150,
                  memCacheWidth: 120,
                  memCacheHeight: 150,
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator(strokeWidth: 2)),
                  errorWidget: (context, url, error) =>
                      Icon(Icons.broken_image),
                ),
              ),
            ),
          ),
        ],
      ),

      onTap: () {
        Navigator.pushNamed(context, Pagescreendeatils.id, arguments: data);
      },
    );
  }
}
