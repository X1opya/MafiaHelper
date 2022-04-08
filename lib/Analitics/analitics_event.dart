enum AnalyticEvent { shuffle, startGame, endGame }

extension AnalyticEventExtension on AnalyticEvent {
  String get name {
    switch (this) {
      case AnalyticEvent.shuffle:
        return "Shuffle_action";

      case AnalyticEvent.startGame:
        return "Start_new_game";

      case AnalyticEvent.endGame:
        return "End_game";
      default: return "";
    }
  }
}
