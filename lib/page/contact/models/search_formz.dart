import 'package:formz/formz.dart';

enum SearchValidationError { empty }

class SearchContact extends FormzInput<String, SearchValidationError>{
  const SearchContact.pure() : super.pure('');
  const SearchContact.dirty([String value = '']) : super.dirty(value);

  @override
  SearchValidationError? validator(String value) {
    return value.isNotEmpty == true ? null : SearchValidationError.empty;
  }
}