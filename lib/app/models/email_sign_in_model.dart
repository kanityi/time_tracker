import 'package:time_tracker/app/sign_in/enums/email_sign_type.dart';
import 'package:time_tracker/app/sign_in/validation/validators.dart';

class EmailSignInModel with EmailAndpasswordValidators {
  EmailSignInModel({
    this.email = '',
    this.password = '',
    this.formType = EmailSigninFormType.signIn,
    this.isLoading = false,
    this.submitted = false,
  });
  final String email;
  final String password;
  final EmailSigninFormType formType;
  final bool isLoading;
  final bool submitted;

  String get primaryButtonText {
    return formType == EmailSigninFormType.signIn
        ? 'Sign in'
        : 'Create an Account';
  }

  String get secondaryButtonText {
    return formType == EmailSigninFormType.signIn
        ? 'Do not have an account? Register'
        : 'Alredy have an account? Sign in';
  }

  bool get canSubmit {
    return emailValidator.isValid(email) &&
        passwordValidator.isValid(password) &&
        !isLoading;
  }

  String get passwordErrorText {
    bool showErrorText = submitted && !passwordValidator.isValid(password);
    return showErrorText ? invalidPasswordErrorText : null;
  }

  String get emailErrorText {
    bool showErrorText = submitted && !emailValidator.isValid(email);
    return showErrorText ? invalidEmailErrorText : null;
  }

  EmailSignInModel copyWith({
    String email,
    String password,
    EmailSigninFormType formType,
    bool isLoading,
    bool submitted,
  }) {
    return EmailSignInModel(
      email: email ?? this.email,
      password: password ?? this.password,
      formType: formType ?? this.formType,
      isLoading: isLoading ?? this.isLoading,
      submitted: submitted ?? this.submitted,
    );
  }
}
