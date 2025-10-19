import 'package:e_commerce/Screen/page_screen_deatils.dart';
import 'package:e_commerce/cubit/cubitSearch/cubit/cubit_search.dart';
import 'package:e_commerce/cubit/cubitSearch/state/stat_search.dart';
import 'package:e_commerce/helps/showe_snake_bare.dart';
import 'package:e_commerce/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class Pagesearch extends StatelessWidget {
  Pagesearch({super.key});

  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 120, right: 15, left: 15),
            child: Customtextfield(
              icon: const Icon(Icons.search),
              textHint: const Text('Search'),
              textEditingController: textEditingController,
            ),
          ),

          const SizedBox(height: 20),

          TextButton(
            onPressed: () {
              context.read<CubitSearch>().search(
                nameProduct: textEditingController.text,
              );
            },
            child: const Text(
              'Search',
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
          ),

          Expanded(
            child: BlocBuilder<CubitSearch, StatSearch>(
              builder: (context, state) {
                if (state is LoadingSearchState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is SuccessfulSearchState) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8, left: 8),
                    child: ListView.builder(
                      itemCount: state.nameProducte.length,
                      itemBuilder: (context, index) {
                        final product = state.nameProducte[index];
                        return GestureDetector(
                          child: ListTile(
                            leading: Image.network(
                              product.image,
                              width: 50,
                              height: 50,
                            ),
                            title: Text(product.title),
                            subtitle: Text('\$${product.price.toString()}'),
                          ),
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              Pagescreendeatils.id,
                              arguments: product,
                            );
                            context.read<CubitSearch>().clearSearch();
                          },
                        );
                      },
                    ),
                  );
                } else if (state is FailureSearchState) {
                  showSnakeBare(context: context, message: Text(state.message));
                  return const Center(child: Text('حدث خطأ أثناء البحث'));
                }
                return const Center(child: Text('ابحث عن منتج'));
              },
            ),
          ),
        ],
      ),
    );
  }
}
