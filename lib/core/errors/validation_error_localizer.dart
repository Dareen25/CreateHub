import 'validation_error.dart';

extension ValidationErrorLocalization on ValidationError {
  String localize() => switch (this) {
    ValidationError.emailRequired => 'Email is required.',
    ValidationError.invalidEmail => 'Enter a valid email address.',
    ValidationError.invalidPassword => 'Enter a valid password.',
    ValidationError.confirmPasswordRequired => 'Please confirm your password.',
    ValidationError.passwordsDoNotMatch => 'Passwords do not match.',
    ValidationError.otpRequired => 'Code is required.',
    ValidationError.invalidOtp => 'Enter a valid code.',
    ValidationError.invalidEgyptianPhone => 'Enter a valid phone number.',
    ValidationError.nameTooShort => 'Name must be at least three characters.',
    ValidationError.nameOnlyLetters => 'Use letters only.',
    ValidationError.idNumberRequired => 'ID number is required.',
    ValidationError.enterIdNumber => 'Enter a valid ID number.',
  };
}
