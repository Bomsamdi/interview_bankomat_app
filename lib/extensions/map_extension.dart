extension MapExtension on Map<int, int> {
  int get balance {
    int result = 0;
    for (final entry in entries) {
      result += entry.key * entry.value;
    }
    return result;
  }

  String get balanceTooltipString {
    String result = '';
    var tmp = Map<int, int>.from(this);
    tmp.removeWhere((key, value) => value == 0);
    for (var entry in tmp.entries) {
      result += "${entry.value} x ${entry.key}zł";
      if (tmp.entries.last.key != entry.key) {
        result += '\n';
      }
    }
    return result;
  }

  String get balanceString {
    String result = '';
    var tmp = Map<int, int>.from(this);
    tmp.removeWhere((key, value) => value == 0);
    for (var entry in tmp.entries) {
      result += "${entry.value} x ${entry.key}zł";
      if (tmp.entries.last.key != entry.key) {
        result += ', ';
      }
    }
    return result;
  }
}
