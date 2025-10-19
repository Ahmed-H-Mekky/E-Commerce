import 'package:e_commerce/Screen/pagBottomNavigationBarItem.dart/page_acount.dart';
import 'package:e_commerce/Screen/pagBottomNavigationBarItem.dart/page_carte.dart';
import 'package:e_commerce/Screen/pagBottomNavigationBarItem.dart/page_favouret.dart';
import 'package:e_commerce/Screen/pagBottomNavigationBarItem.dart/page_home.dart';
import 'package:e_commerce/Screen/pagBottomNavigationBarItem.dart/page_search.dart';
import 'package:flutter/material.dart';

class SwitchPage {
  SwitchPage({required this.index});
  final int index;
  Widget shosePag() {
    switch (index) {
      case 0:
        return const Pagehome();
      case 1:
        return Pagesearch();
      case 2:
        return const Pagecarte();
      case 3:
        return Pagefavouret();
      case 4:
        return const PageAcount();
      default:
        return const Pagehome();
    }
  }
}
