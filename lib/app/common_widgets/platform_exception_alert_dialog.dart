import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../common_widgets/platform_alert_dialog.dart';

class PlatformExceptionAlertDialog extends PlatformAlertDialog {
  PlatformExceptionAlertDialog({
    @required String title,
    @required PlatformException exception,
  }) : super(
          title: title,
          content: _messge(exception),
          defaultActionText: 'Ok',
        );

  static String _messge(PlatformException exception) {
    if (exception.code == 'Error performing setData') {
      return 'Yo do not have permissions for this operation.';
    }
    return _errors[exception.code] ?? exception.message;
  }

  static Map<String, String> _errors = {
    'ERROR_WEAK_PASSWORD': "The password is not strong enough",
    'ERROR_INVALID_EMAIL': 'Invalid email address',
    'ERROR_EMAIL_ALREADY_IN_USE': 'Email Already exist',
    'ERROR_WRONG_PASSWORD': 'Incorrect email address or password',
    'ERROR_USER_NOT_FOUND':
        'you do not have account with thi email, please create an account',
  };
}
