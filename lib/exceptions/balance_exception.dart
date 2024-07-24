import 'package:interview_bankomat_app/constants.dart';
import 'package:interview_bankomat_app/exceptions/atm_exception.dart';

class BalanceException extends AtmException {
  const BalanceException()
      : super(message: Constants.insufficientFundsException);
}
