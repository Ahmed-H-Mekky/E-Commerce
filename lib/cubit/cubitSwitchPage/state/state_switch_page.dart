import 'package:flutter/widgets.dart';

abstract class StateSwitchPage {}

class InitalSwitchState extends StateSwitchPage {}

class ShoesPageSwitchState extends StateSwitchPage {
  final int index;
  final Widget page;

  ShoesPageSwitchState({required this.index, required this.page});
}
