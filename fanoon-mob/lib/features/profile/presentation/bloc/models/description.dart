import 'package:formz/formz.dart';

enum DescriptionValidationError { invalid }

class Description extends FormzInput<String, DescriptionValidationError> {
  const Description.pure([super.value = '']) : super.pure();
  const Description.dirty([super.value = '']) : super.dirty();

  @override
  DescriptionValidationError? validator(String? value) {
    return ((value!.length >= 20 && value.length <= 500)
        ? null
        : DescriptionValidationError.invalid);
  }
}
