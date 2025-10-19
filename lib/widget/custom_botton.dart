import 'package:flutter/material.dart';

class CustomBotton extends StatelessWidget {
  const CustomBotton({
    super.key,
    required this.onpressed,
    required this.text,
    required this.backgroundColor,
    required this.icon,
    required this.iconColor,
  });
  final VoidCallback? onpressed;
  final Text text;
  final Color backgroundColor;
  final Color? iconColor;

  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpressed,
      child: Container(
        width: double.infinity,
        height: 50,

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: backgroundColor,
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: iconColor),
            const SizedBox(width: 30),
            text,
          ],
        ),
      ),
    );
  }
}
