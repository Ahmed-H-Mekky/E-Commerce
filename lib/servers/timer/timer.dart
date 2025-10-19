import 'dart:async';

// كلاس بسيط لإدارة المؤقت فقط
class TimerClass {
  Timer? timer; // المؤقت الحالي
  void startTimer({
    required int seconds,
    required Function onComplete,
    required Function(int remainingSeconds) currentSeconde,
  }) {
    timer?.cancel();

    timer = Timer.periodic(Duration(seconds: 1), (time) {
      if (seconds <= 0) {
        time.cancel();
        onComplete();
      } else {
        seconds--;
        currentSeconde(seconds);
      }
    });
  }

  void stopTimer() {
    timer?.cancel();
  }
}
