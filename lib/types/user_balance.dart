extension type UserBalance(int value) implements int {
  UserBalance operator +(Object other) {
    if (other is UserBalance) {
      return UserBalance(value + other.value);
    } else if (other is int) {
      return UserBalance(value + other);
    } else {
      throw Exception('Unsupported type');
    }
  }

  UserBalance operator -(Object other) {
    if (other is UserBalance) {
      return UserBalance(value - other.value);
    } else if (other is int) {
      return UserBalance(value - other);
    } else {
      throw Exception('Unsupported type');
    }
  }

  UserBalance operator *(Object other) {
    if (other is UserBalance) {
      return UserBalance(value * other.value);
    } else if (other is int) {
      return UserBalance(value * other);
    } else {
      throw Exception('Unsupported type');
    }
  }

  UserBalance operator /(Object other) {
    if (other is UserBalance) {
      return UserBalance(value ~/ other.value);
    } else if (other is int) {
      return UserBalance(value ~/ other);
    } else {
      throw Exception('Unsupported type');
    }
  }

  String toCurrency() {
    return '$this zł';
  }
}
