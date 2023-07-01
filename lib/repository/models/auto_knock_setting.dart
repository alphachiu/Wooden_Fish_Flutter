enum AutoStop { count, countDown }

class AutoKnockSetting {
  AutoKnockSetting(
      {this.isAutoStop = false,
      this.type = AutoStop.count,
      this.limitCount = 0,
      this.currentCount = 0,
      this.countDownCount = 0});

  bool isAutoStop;
  AutoStop type;
  int limitCount;
  int currentCount;
  int countDownCount;
}
