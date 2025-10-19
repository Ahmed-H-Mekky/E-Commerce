abstract class StateTimer {}

class InitalTimerStat extends StateTimer {}

class CurrentTimer extends StateTimer {
  final int seconde;
  CurrentTimer({required this.seconde});
}
