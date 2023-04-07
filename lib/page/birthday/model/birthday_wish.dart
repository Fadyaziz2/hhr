import 'package:formz/formz.dart';

enum BirthWishValidationError { empty }

class BirthdayWish extends FormzInput<String, BirthWishValidationError>{
  const BirthdayWish.pure() : super.pure('');
  const BirthdayWish.dirty([String value = '']) : super.dirty(value);

  @override
  BirthWishValidationError? validator(String value) {
    return value.isNotEmpty == true ? null : BirthWishValidationError.empty;
  }
}