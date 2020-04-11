import 'package:flutter/material.dart';
import 'package:time_tracker/app/common_widgets/custom_rased_button.dart';

class SignInButton extends CustomRaisedButton {
  SignInButton({
    Key key,
    @required String text,
    Color color,
    Color textColor,
    VoidCallback onPressed,
  })  : assert(text != null),
        super(
          key: key,
          child: Text(
            text,
            style: TextStyle(color: textColor, fontSize: 15.0),
          ),
          color: color,
          onPressed: onPressed,
        );
}
