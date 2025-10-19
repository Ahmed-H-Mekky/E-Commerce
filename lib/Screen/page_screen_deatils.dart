import 'package:e_commerce/cubit/cubitAddCart/cubit/cubit_add_cart.dart';
import 'package:e_commerce/helps/showe_snake_bare.dart';
import 'package:e_commerce/model/model_product.dart';
import 'package:e_commerce/widget/custom_botton.dart';
import 'package:e_commerce/widget/value_list_enable_builder.dart';
import 'package:e_commerce/widget/value_list_enable_builder_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Pagescreendeatils extends StatelessWidget {
  Pagescreendeatils({super.key});

  static String id = 'Pagescreendeatils';

  final PageController pageController = PageController();

  //  مراقبة التغير في الصفحات
  final ValueNotifier<int> currentPage = ValueNotifier(0);

  //  القيم المختارة للمقاس واللون
  final ValueNotifier<String?> selectedSize = ValueNotifier(null);
  final ValueNotifier<Color?> selectedColor = ValueNotifier(null);

  //  عداد الكمية
  final ValueNotifier<int> currentQuantity = ValueNotifier(1);
  final List<String> sizeList = ['S', 'M', 'L', 'XL'];
  final List<Color> colorList = [
    Colors.blue,
    Colors.grey,
    Colors.black,
    Colors.red,
  ];
  @override
  Widget build(BuildContext context) {
    final Modelproduct data =
        ModalRoute.of(context)!.settings.arguments as Modelproduct;
    final List<String> image = [data.image];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          data.title.split(' ').take(2).join(' '),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              //  عرض الصور
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: SizedBox(
                  height: 450,
                  width: double.infinity,
                  child: Stack(
                    alignment: AlignmentGeometry.center,
                    children: [
                      PageView.builder(
                        itemCount: image.length,
                        controller: pageController,
                        onPageChanged: (value) => currentPage.value = value,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Expanded(
                                child: Container(
                                  color: Colors.black12,
                                  child: Image.network(
                                    image[index],
                                    fit: BoxFit.fill,
                                    width: double.infinity,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          }
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        },
                                  ),
                                ),
                              ),
                              ListTile(
                                title: Text(data.title),
                                subtitle: Text(
                                  '${data.price.toString()} ج.م',
                                  style: const TextStyle(
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      Positioned(
                        bottom: 8,
                        child: ValueListEnableBuilderBotton(
                          valueListenable: currentPage,
                          list: image,
                          value1: 12,
                          value2: 8,
                          color1: const Color.fromARGB(255, 174, 23, 250),
                          color2: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 5),

              //  عرض منتجات الراجالي والسيدات
              if (data.category == "men's clothing" ||
                  data.category == "women's clothing") ...[
                const Text(
                  'المقاسات المتوفرة',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 10),
                ValueListEnableBuilderBottonMap(
                  valueListenable: selectedSize,
                  list: sizeList,
                  value1: 40,
                  value2: 40,
                  color1: Colors.purple,
                  color2: Colors.grey,
                  colorText1: Colors.white,
                  colorText2: Colors.black,
                ),
                const SizedBox(height: 10),
                const Text(
                  'الألوان المتاحة',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 10),
                ValueListEnableBuilderBottonMap(
                  valueListenable: selectedColor,
                  list: colorList,
                  value1: 40,
                  value2: 40,
                  color1: null,
                  color2: null,
                  colorText1: null,
                  colorText2: null,
                ),
              ],

              //   عرض منتجات الإلكترونيات
              if (data.category == 'electronics') ...[
                const Text(
                  'الألوان المتاحة',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                ValueListEnableBuilderBottonMap(
                  valueListenable: selectedColor,
                  list: colorList,
                  value1: 40,
                  value2: 40,
                  color1: null,
                  color2: null,
                  colorText1: null,
                  colorText2: null,
                ),
              ],
            ],
          ),
        ),
      ),

      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, -3),
                blurRadius: 6,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: ValueListenableBuilder<int>(
                  valueListenable: currentQuantity,
                  builder: (context, value, _) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.purple, width: 1.5),
                      ),

                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              if (value > 1) {
                                currentQuantity.value--;
                              }
                            },
                            icon: Icon(Icons.remove),
                          ),
                          Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1),
                              border: Border.all(color: Colors.black),
                            ),
                            child: Center(child: Text(value.toString())),
                          ),
                          IconButton(
                            onPressed: () {
                              currentQuantity.value++;
                            },
                            icon: Icon(Icons.add),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 4,
                child: CustomBotton(
                  onpressed: () {
                    final cubitCart = context.read<Cubitaddcart>();
                    cubitCart.addCart(
                      addMapp: {
                        'title': data.title,
                        'price': data.price,
                        'image': data.image,
                        'quantity': currentQuantity.value,
                        'selectedColor': selectedColor.value,
                        'selectedSize': selectedSize.value,
                      },
                    );

                    int addCart = currentQuantity.value;
                    showSnakeBare(
                      context: context,
                      message: Text(
                        'تمت إضافة ${data.title}  $addCart إلى عربة المشتريات',
                        textDirection: TextDirection.rtl,
                      ),
                    );
                  },
                  text: Text(
                    'أضف إلى السلة',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  backgroundColor: Colors.purple,
                  icon: FontAwesomeIcons.cartShopping,
                  iconColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
