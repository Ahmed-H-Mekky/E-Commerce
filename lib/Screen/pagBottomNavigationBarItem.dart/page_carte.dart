import 'package:e_commerce/cubit/cubitAddCart/cubit/cubit_add_cart.dart';
import 'package:e_commerce/cubit/cubitAddCart/state/state_add_cart.dart';
import 'package:e_commerce/paymob/paymob_manger.dart';
import 'package:e_commerce/stripe_payment/payment_manager.dart';
import 'package:e_commerce/widget/paymob_web_vew.dart';
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

      //  نعرض المنتجات + الأزرار في الأسفل
      body: BlocBuilder<Cubitaddcart, Stateaddcart>(
        builder: (BuildContext context, state) {
          if (state is InitialStateAddCart ||
              (state is AddCartState && state.mapAdd.isEmpty)) {
            return const Center(
              child: Text(
                'السلة فارغة',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          } else if (state is AddCartState) {
            final items = state.mapAdd;

            //  نحسب المجموع الكلي
            final totalPrice = items.fold<double>(
              0.0,
              (sum, item) => sum + (item['price'] * item['quantity']),
            );

            return Column(
              children: [
                // 🛍️ قائمة المنتجات
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
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
                  ),
                ),

                //  قسم الدفع الاحترافي أسفل الصفحة
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 10,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      //  المجموع الكلي
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'الإجمالي:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '$totalPrice ج.م',
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      //  أزرار الدفع
                      Row(
                        children: [
                          //  زر Stripe
                          Expanded(
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(
                                  255,
                                  126,
                                  58,
                                  245,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () {
                                PaymentManager.makePayment(
                                  amount: totalPrice.toInt(),
                                  currency: "USD",
                                );
                              },
                              icon: const Icon(
                                Icons.credit_card,
                                color: Colors.amber,
                              ),
                              label: const Text(
                                'Stripe',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),

                          //  زر Paymob
                          Expanded(
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(
                                  255,
                                  2,
                                  147,
                                  7,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () =>
                                  _pay(context, totalPrice.toInt()),
                              icon: const Icon(
                                Icons.payment,
                                color: Colors.amber,
                              ),
                              label: const Text(
                                'Paymob',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  //  دالة الدفع عبر Paymob
  Future<void> _pay(BuildContext context, int amount) async {
    try {
      final paymentKey = await PaymobManager().getPaymentKey(amount, "EGP");

      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaymobWebView(paymentKey: paymentKey),
        ),
      );

      if (result == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تمت عملية الدفع بنجاح'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('فشلت عملية الدفع، يرجى المحاولة مرة أخرى'),
            backgroundColor: Colors.redAccent,
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e, stacktrace) {
      print('Pay Error: $e');
      print(stacktrace);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('حدث خطأ أثناء الدفع: $e'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }
}
