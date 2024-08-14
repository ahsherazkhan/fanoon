import 'package:formz/formz.dart';

enum TitleValidationError { invalid }

class Title extends FormzInput<String, TitleValidationError> {
  const Title.pure([super.value = '']) : super.pure();
  const Title.dirty([super.value = '']) : super.dirty();

  @override
  TitleValidationError? validator(String? value) {
    // The title of the post check
    return (value!.length >= 8 && value.length <= 50)
        ? null
        : TitleValidationError.invalid;
  }
}
