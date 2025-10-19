import 'package:e_commerce/cubit/cubitAddCart/cubit/cubit_add_cart.dart';
import 'package:e_commerce/cubit/cubitAddCart/state/state_add_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Pagecarte extends StatelessWidget {
  const Pagecarte({super.key});
  static const String id = 'Pagecarte';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        title: const Text(
          '🛒 عربة المشتريات',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        elevation: 4,
      ),

      body: BlocBuilder<Cubitaddcart, Stateaddcart>(
        builder: (BuildContext context, state) {
          if (state is InitialStateAddCart) {
            return const Center(
              child: Text(
                'السلة فارغة',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          } else if (state is AddCartState) {
            final items = state.mapAdd;
            if (items.isEmpty) {
              return const Center(
                child: Text(
                  'السلة فارغة',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];

                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //  الصورة
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            item['image'],
                            width: 70,
                            height: 70,
                            fit: BoxFit.fill,
                          ),
                        ),

                        const SizedBox(width: 12),

                        //  التفاصيل
                        Expanded(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['title'],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 6),

                              if (item['selectedSize'] != null)
                                Text(
                                  'المقاس: ${item['selectedSize']}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54,
                                  ),
                                ),

                              const SizedBox(height: 8),

                              Row(
                                children: [
                                  Text(
                                    'السعر: ',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey[800],
                                    ),
                                  ),
                                  Text(
                                    '${item['price'] * item['quantity']} ج.م',
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.orange,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 18),
                                  Text(
                                    'الكمية: ${item['quantity']}',
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.deepPurple,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 8),

                        //  زر الحذف
                        IconButton(
                          icon: const Icon(
                            Icons.delete_forever,
                            color: Colors.red,
                            size: 28,
                          ),
                          onPressed: () {
                            context.read<Cubitaddcart>().removCart(
                              nameproduct: item['title'],
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '${item['title']} تم حذفه من السلة',
                                  textDirection: TextDirection.rtl,
                                ),
                                backgroundColor: Colors.redAccent,
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is RemovCartState) {
            return const Center(
              child: Text(
                'تم تحديث السلة',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
