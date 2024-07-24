import 'package:interview_bankomat_app/constants.dart';
import 'package:interview_bankomat_app/exceptions/atm_exception.dart';

class WrongValueException extends AtmException {
  const WrongValueException({this.aditionalInfo})
      : super(message: Constants.wrongValueException);
  final String? aditionalInfo;

  @override
  String toString() => '$message ${aditionalInfo ?? ""}';
}
