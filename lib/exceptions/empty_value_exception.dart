import 'package:interview_bankomat_app/constants.dart';
import 'package:interview_bankomat_app/exceptions/atm_exception.dart';

class EmptyValueException extends AtmException {
  const EmptyValueException() : super(message: Constants.emptyValueException);
}
