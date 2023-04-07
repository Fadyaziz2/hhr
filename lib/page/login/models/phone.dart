import 'package:formz/formz.dart';

enum PhoneValidationError { empty }


class Email extends FormzInput<String, PhoneValidationError>{

  const Email.pure() : super.pure('');
  const Email.dirty([String value = '']) : super.dirty(value);

  @override
  PhoneValidationError? validator(String value) {
    return value.isNotEmpty == true ? null : PhoneValidationError.empty;
  }
}