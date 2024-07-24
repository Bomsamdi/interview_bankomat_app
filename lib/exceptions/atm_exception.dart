import 'package:interview_bankomat_app/constants.dart';

abstract class AtmException implements Exception {
  final String title;
  final String message;

  const AtmException({
    this.title = Constants.errorTitle,
    required this.message,
  });

  @override
  String toString() => message;
}
