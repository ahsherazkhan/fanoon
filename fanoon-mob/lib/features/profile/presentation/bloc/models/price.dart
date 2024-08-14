import 'dart:developer';

import 'package:formz/formz.dart';

enum PriceValidationError { invalid }

class Price extends FormzInput<String, PriceValidationError> {
  const Price.pure([super.value = '']) : super.pure();
  const Price.dirty([super.value = '']) : super.dirty();

  @override
  PriceValidationError? validator(String? value) {
    int length = value!.length;
    // The title of the post check
    return ((length == 1 && value == '0') || value.isEmpty)
        ? PriceValidationError.invalid
        : null;
  }
}
