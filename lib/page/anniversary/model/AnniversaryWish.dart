import 'package:formz/formz.dart';

enum AnniversaryWishValidationError { empty }

class AnniversaryWish
    extends FormzInput<String, AnniversaryWishValidationError> {
  const AnniversaryWish.pure() : super.pure('');

  const AnniversaryWish.dirty([String value = '']) : super.dirty(value);

  @override
  AnniversaryWishValidationError? validator(String value) {
    return value.isNotEmpty == true
        ? null
        : AnniversaryWishValidationError.empty;
  }
}
