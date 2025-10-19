import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce/cubit/cubitTimer/state/state_timer.dart';
import 'package:e_commerce/servers/timer/timer.dart';

class CubitTimer extends Cubit<StateTimer> {
  CubitTimer() : super(InitalTimerStat());

  final TimerClass _timerClass = TimerClass();

  // بدء العداد
  void timerfunction({required int seconde}) {
    _timerClass.stopTimer(); // إيقاف أي مؤقت سابق
    // تشغيل المؤقت
    _timerClass.startTimer(
      seconds: seconde,
      currentSeconde: (remaining) {
        emit(CurrentTimer(seconde: remaining)); // تحديث كل ثانية
      },
      onComplete: () {
        emit(CurrentTimer(seconde: 0)); // عند الانتهاء
      },
    );
  }
}
