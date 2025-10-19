import 'package:e_commerce/Screen/page_screen_deatils.dart';
import 'package:e_commerce/cubit/cubitAddFavorite/cubit/cubit_favorite.dart';
import 'package:e_commerce/cubit/cubitAddFavorite/state/state_favorite.dart';
import 'package:e_commerce/model/model_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Pagefavouret extends StatelessWidget {
  const Pagefavouret({super.key});
  static const String id = 'Pagefavouret';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('المفضلة'), centerTitle: true),
      body: BlocBuilder<CubitAddItemsToFavorite, StateFavorite>(
        builder: (context, state) {
          if (state is StateAddFavoriteList) {
            final favoriteItems = state.items;

            if (favoriteItems.isEmpty) {
              return const Center(child: Text('لا توجد عناصر في المفضلة'));
            }
            return ListView.builder(
              itemCount: favoriteItems.length,
              itemBuilder: (context, index) {
                final item = favoriteItems[index];
                return Dismissible(
                  key: Key(item['title']), // مفتاح فريد لكل عنصر
                  background: Container(
                    color: Colors.red,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    context.read<CubitAddItemsToFavorite>().removeItem(
                      title: item['title'],
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${item['title']} تم حذفه من المفضلة'),

                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                  child: InkWell(
                    child: Card(
                      child: ListTile(
                        leading: Image.network(item['image']),
                        title: Text(item['title']),
                        subtitle: Text('\$${item['price']}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            context.read<CubitAddItemsToFavorite>().removeItem(
                              title: item['title'],
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '${item['title']} تم حذفه من المفضلة',
                                ),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    onTap: () {
                      final product = Modelproduct(
                        title: item['title'] ?? '',
                        price: (item['price'] is int)
                            ? (item['price'] as int).toDouble()
                            : item['price'] ?? 0.0,
                        image: item['image'] ?? '',
                        category: item['category'] ?? '',
                        description: item['description'] ?? '',
                        rating: null,
                      );
                      Navigator.pushNamed(
                        context,
                        Pagescreendeatils.id,
                        arguments: product,
                      );
                    },
                  ),
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
