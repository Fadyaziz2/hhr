
class BreakBackHistory {
  BreakBackHistory({
    this.todayHistory,
  });

  List<TodayHistory>? todayHistory;

  factory BreakBackHistory.fromJson(Map<String, dynamic> json) => BreakBackHistory(
    todayHistory: List<TodayHistory>.from(json["today_history"].map((x) => TodayHistory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {"today_history": List<dynamic>.from(todayHistory!.map((x) => x.toJson()))};
}

class TodayHistory {
  TodayHistory({
    this.reason,
    this.breakTimeDuration,
    this.breakBackTime,
  });

  String? reason;
  String? breakTimeDuration;
  String? breakBackTime;

  factory TodayHistory.fromJson(Map<String, dynamic> json) => TodayHistory(
    reason: json["reason"],
    breakTimeDuration: json["break_time_duration"],
    breakBackTime: json["break_back_time"],
  );

  Map<String, dynamic> toJson() => {
    "reason": reason,
    "break_time_duration": breakTimeDuration,
    "break_back_time": breakBackTime,
  };
}