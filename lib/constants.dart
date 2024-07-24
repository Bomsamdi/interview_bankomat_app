abstract class Constants {
  //General constants
  static const String appName = "Bankomat";
  static const String atmBalance = "Saldo bankomatu";
  static const String userBalance = "Saldo użytkownika";
  static const String withdrawValue = "Kwota do wypłaty";
  static const String withdraw = "Wypłać";
  static const String confirm = "Ok";

  //Denominations
  static const List<int> denominations = [200, 100, 50, 20, 10];

  //Withdraw dialog
  static const String withdrawTitle = 'Wypłata';
  static const String withdrawMessage = 'Wypłacono kwotę: ';

  //Errors and exceptions
  static const String errorTitle = 'Błąd';
  static const String emptyValueException =
      'Proszę wprowadzić kwotę do wypłaty.';
  static const String wrongValueException = 'Proszę wprowadzić poprawną kwotę.';
  static const String wrongValueAditionalInfo =
      'Kwota musi być wielokrotnością liczby 10.';
  static const String insufficientFundsException =
      'Niewystarczająca ilość środków na koncie.';
  static const String noDenominationsAvailableException =
      'Brak dostępnych nominałów do wypłaty tej kwoty.';
  static const String noDenominationsAvailableAdditionalInfo =
      'Maksymalna kwota dostępna do wypłaty w tym bankomacie: ';
  static const String unknownError = 'Wystąpił nieznany błąd.';
}
