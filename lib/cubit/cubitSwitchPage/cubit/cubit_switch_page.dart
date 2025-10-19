import 'package:e_commerce/cubit/cubitSwitchPage/state/state_switch_page.dart';
import 'package:e_commerce/servers/switch_page/switch_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CubitSwitchPage extends Cubit<StateSwitchPage> {
  CubitSwitchPage() : super(InitalSwitchState());

  int currentIndex = 0;
  void switchPage(int index) {
    final page = SwitchPage(index: index).shosePag();
    currentIndex = index;

    emit(ShoesPageSwitchState(page: page, index: index));
  }
}
