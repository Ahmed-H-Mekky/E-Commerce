import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ValueListEnableBuilderBottonMap<T> extends StatelessWidget {
  const ValueListEnableBuilderBottonMap({
    super.key,
    required this.valueListenable,
    required this.list,
    required this.value1,
    required this.value2,
    required this.color1,
    required this.color2,
    required this.colorText1,
    required this.colorText2,
  });
  final ValueNotifier<T> valueListenable;
  final List<T> list;
  final double value1;
  final double value2;
  final Color? color1;
  final Color? color2;
  final Color? colorText1;
  final Color? colorText2;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<T>(
      valueListenable: valueListenable,
      builder: (BuildContext context, value, _) {
        return Row(
          children: list.map((index) {
            final bool isActive = value == index;

            return GestureDetector(
              onTap: () => valueListenable.value = index,
              child: Container(
                margin: EdgeInsets.all(10),
                width: isActive ? value1 : value2,
                height: isActive ? value1 : value2,
                decoration: BoxDecoration(
                  color: isActive ? color1 : color2,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Center(
                  child: index is String
                      ? Text(
                          index.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isActive ? colorText1 : colorText2,
                          ),
                        )
                      : Container(
                          width: value1,
                          height: value2,
                          decoration: BoxDecoration(
                            color: index as Color,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isActive
                                  ? const Color.fromARGB(255, 3, 202, 27)
                                  : Colors.grey,
                              width: isActive ? 2 : 1,
                            ),
                          ),
                        ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
