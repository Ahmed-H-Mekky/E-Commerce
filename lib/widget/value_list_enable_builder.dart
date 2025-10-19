import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ValueListEnableBuilderBotton<T> extends StatelessWidget {
  const ValueListEnableBuilderBotton({
    super.key,
    required this.valueListenable,
    required this.list,
    required this.value1,
    required this.value2,
    required this.color1,
    required this.color2,
  });
  final ValueNotifier<T> valueListenable;
  final List<T> list;
  final double value1;
  final double value2;
  final Color color1;
  final Color color2;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<T>(
      valueListenable: valueListenable,
      builder: (BuildContext context, value, _) {
        return Row(
          children: List.generate(list.length, (index) {
            final bool isActive = value == index;

            return Container(
              margin: EdgeInsets.all(10),
              width: isActive ? value1 : value2,
              height: isActive ? value1 : value2,
              decoration: BoxDecoration(
                color: isActive ? color1 : color2,
                borderRadius: BorderRadius.circular(50),
              ),
            );
          }),
        );
      },
    );
  }
}
