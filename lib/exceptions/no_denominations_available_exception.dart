import 'package:interview_bankomat_app/constants.dart';
import 'package:interview_bankomat_app/exceptions/atm_exception.dart';

class NoDenominationsAvailableException extends AtmException {
  const NoDenominationsAvailableException({this.aditionalInfo})
      : super(message: Constants.noDenominationsAvailableException);
  final String? aditionalInfo;

  @override
  String toString() => '$message ${aditionalInfo ?? ""}';
}
