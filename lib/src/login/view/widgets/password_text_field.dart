// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:crises_control/src/core/constants.dart';
import 'package:crises_control/src/core/utils/validation/text_validation.dart';

class PasswordEntry extends StatefulWidget {
  const PasswordEntry({
    Key? key,
    required TextEditingController passwordTextField,
    required FocusNode passwordTextFieldFocusNode,
    String? hintPassword,
    FormFieldValidator<String>? validator,
  })  : _passwordTextField = passwordTextField,
        _passwordTextFieldFocusNode = passwordTextFieldFocusNode,
        _hintPassword = hintPassword,
        _validator = validator,
        super(key: key);

  final TextEditingController _passwordTextField;
  final FocusNode _passwordTextFieldFocusNode;
  final String? _hintPassword;
  final FormFieldValidator<String>? _validator;

  @override
  State<PasswordEntry> createState() => PasswordEntryState();
}

class PasswordEntryState extends State<PasswordEntry> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: TextFormField(
        obscureText: true,
        enableSuggestions: false,
        autocorrect: false,
        controller: widget._passwordTextField,
        focusNode: widget._passwordTextFieldFocusNode,
        maxLength: 100,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              UIConstants.defaultCornerRadius,
            ),
          ),
          labelText: widget._hintPassword ?? AppLocalizations.of(context)!.hint_password,
          counterText: ""
        ),
        validator: widget._validator ?? (text) => TextValidator.canNotBeEmpty(text),
      ),
    );
  }
}
