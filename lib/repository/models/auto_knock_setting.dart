enum AutoStop { count, countDown }

enum AutoStopTime { none, five, ten, fifteen, thirty, sixty }

class AutoKnockSetting {
  AutoKnockSetting({
    this.isAutoStop = false,
    this.autoStopType = AutoStop.count,
    this.autoStopTimeType = AutoStopTime.none,
    this.limitCount = 0,
    this.currentKnockCount = 0,
    this.countDownSecond = 0,
  });

  bool isAutoStop;
  AutoStop autoStopType;
  AutoStopTime autoStopTimeType;
  int limitCount;
  int currentKnockCount; // Use for auto stop count
  int countDownSecond;
}
