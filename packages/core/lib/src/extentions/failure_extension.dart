import 'package:core/src/failure/failure.dart';

extension FailureExtension on Failure {
  bool get isSuccess => failureType == FailureType.none;
}
