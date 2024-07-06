// ignore_for_file: use_super_parameters, deprecated_member_use, unused_field, unused_element

import 'package:crises_control/src/core/presentation/widgets/cc_activity_indicator.dart';
import 'package:crises_control/src/core/presentation/widgets/cc_alert_dialog.dart';
import 'package:crises_control/src/core/presentation/widgets/cc_text_field.dart';
import 'package:crises_control/src/core/router/page_arguments/page_arguments.dart';
import 'package:crises_control/src/core/router/route_constants.dart';
import 'package:crises_control/src/core/utils/validation/password_validation.dart';
import 'package:crises_control/src/login/bloc/login_first_time_bloc/login_first_time_bloc.dart';
import 'package:crises_control/src/login/repository/login_repository.dart';
import 'package:crises_control/src/login/view/widgets/password_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginFirstTimePage extends StatefulWidget {
  const LoginFirstTimePage({
    Key? key,
    required this.customerId,
    required this.userName,
    required this.rememberMe,
  }) : super(key: key);
  final String customerId;
  final String userName;
  final bool rememberMe;

  @override
  // _LoginFirstTimePageState createState() => _LoginFirstTimePageState();
  State<LoginFirstTimePage> createState() => _LoginFirstTimePageState();
}

class _LoginFirstTimePageState extends State<LoginFirstTimePage> {
  final CCLoadingOverlay _loadingOverlay = CCLoadingOverlay();

  final TextEditingController _oldPasswordTextField = TextEditingController();
  late FocusNode _oldPasswordTextFieldFocusNode;
  final TextEditingController _newPasswordTextField = TextEditingController();
  late FocusNode _newPasswordTextFieldFocusNode;
  final TextEditingController _confirmPasswordTextField =
      TextEditingController();
  late FocusNode _confirmPasswordTextFieldFocusNode;

  final _firstTimeLoginFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _oldPasswordTextFieldFocusNode = FocusNode();
    _newPasswordTextFieldFocusNode = FocusNode();
    _confirmPasswordTextFieldFocusNode = FocusNode();
  }

  @override
  void dispose() {
    //make sure to dispose of focus nodes as if not, it can create memory leaks
    _oldPasswordTextFieldFocusNode.dispose();
    _newPasswordTextFieldFocusNode.dispose();
    _confirmPasswordTextFieldFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: unfocusTextField,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: BlocProvider(
              create: (context) => LoginFirstTimeBloc(
                RepositoryProvider.of<LoginRepository>(context),
              ),
              child: Center(
                child: BlocListener<LoginFirstTimeBloc, LoginFirstTimeState>(
                  listener: (context, state) {
                    if (state is SubmitNewPasswordFailure) {
                      // _handleErrorAlert(context, state);
                      Navigator.pushNamed(
                        context,
                        RouteConstants.loginFirstOtpPage,
                        arguments: LoginFirstOtpPageArguments(
                          customerId: widget.customerId,
                          oldPassword: _oldPasswordTextField.text,
                          newPassword: _newPasswordTextField.text,
                          userName: widget.userName,
                          rememberMe: widget.rememberMe,
                        ),
                      );
                    }
                    if (state is LoginFirstTimeLoading) {
                      _loadingOverlay.show(context);
                    } else {
                      _loadingOverlay.hide();
                    }
                    if (state is SubmitNewPasswordSuccess) {
                      Navigator.pushNamed(
                        context,
                        RouteConstants.loginFirstOtpPage,
                        arguments: LoginFirstOtpPageArguments(
                          customerId: widget.customerId,
                          oldPassword: _oldPasswordTextField.text,
                          newPassword: _newPasswordTextField.text,
                          userName: widget.userName,
                          rememberMe: widget.rememberMe,
                        ),
                      );
                    }
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Column(
                        children: [
                          Text(
                            AppLocalizations.of(context)!.label_reset_header,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            AppLocalizations.of(context)
                                !.label_reset_description,
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          Form(
                            key: _firstTimeLoginFormKey,
                            child: Column(children: [
                              PasswordEntry(
                                passwordTextField: _oldPasswordTextField,
                                passwordTextFieldFocusNode:
                                    _oldPasswordTextFieldFocusNode,
                                hintPassword: AppLocalizations.of(context)
                                    !.hint_enter_old_password,
                                validator: (text) =>
                                    PasswordValidator.isValidPassword(
                                        text, context),
                              ),
                              PasswordEntry(
                                passwordTextField: _newPasswordTextField,
                                passwordTextFieldFocusNode:
                                    _newPasswordTextFieldFocusNode,
                                hintPassword: AppLocalizations.of(context)
                                    !.hint_enter_new_password,
                                validator: (text) =>
                                    PasswordValidator.isValidPassword(
                                        text,
                                        context,
                                        _confirmPasswordTextField.text),
                              ),
                              PasswordEntry(
                                passwordTextField: _confirmPasswordTextField,
                                passwordTextFieldFocusNode:
                                    _confirmPasswordTextFieldFocusNode,
                                hintPassword: AppLocalizations.of(context)
                                    !.hint_enter_confirm_new_password,
                                validator: (text) =>
                                    PasswordValidator.isValidPassword(text,
                                        context, _newPasswordTextField.text),
                              ),
                            ]),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                      Column(
                        children: [
                          _ContinueButton(
                            oldPasswordTextField: _oldPasswordTextField,
                            newPasswordTextField: _newPasswordTextField,
                            confirmPasswordTextField: _confirmPasswordTextField,
                            formKey: _firstTimeLoginFormKey,
                          ),
                          const _CancelButton(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> _handleErrorAlert(
      BuildContext context, SubmitNewPasswordFailure state) {
    String description;

    switch (state.error.errorTitle) {
      case 'Login Failure':
        description = AppLocalizations.of(context)!.e009;
        break;
      case 'No Connectivity':
        description = AppLocalizations.of(context)!.e001;
        break;
      case 'Customer ID is required':
        description = AppLocalizations.of(context)!.enter_customer_id;
        break;
      default:
        description = AppLocalizations.of(context)!.e003;
    }

    return showDialog(
      context: context,
      builder: (context) => CCAlertDialog(
        title: state.error.errorTitle,
        description: description,
        actions: const [
          OkAlertButton(),
        ],
      ),
    );
  }
}

class _ContinueButton extends StatelessWidget {
  const _ContinueButton({
    Key? key,
    required TextEditingController oldPasswordTextField,
    required TextEditingController newPasswordTextField,
    required TextEditingController confirmPasswordTextField,
    required this.formKey,
  })  : _oldPasswordTextField = oldPasswordTextField,
        _newPasswordTextField = newPasswordTextField,
        _confirmPasswordTextField = confirmPasswordTextField,
        super(key: key);
  final GlobalKey<FormState> formKey;
  final TextEditingController _oldPasswordTextField;
  final TextEditingController _newPasswordTextField;
  final TextEditingController _confirmPasswordTextField;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.all(20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(50),
        ),
        onPressed: () {
          if (formKey.currentState!.validate()) {
            String? isPasswordSecureMsg = PasswordValidator.isPasswordSecure(
                _newPasswordTextField.text, context);
            if (isPasswordSecureMsg != null) {
              // isPasswordSecureMsg;
              showDialog(
                context: context,
                builder: (context) => CCAlertDialog(
                  title: AppLocalizations.of(context)
                      !.alert_fp_title_error, 
                  description: isPasswordSecureMsg,
                  actions: const [
                    OkAlertButton(),
                  ],
                ),
              );
            } else {
              BlocProvider.of<LoginFirstTimeBloc>(context).add(
                SubmitNewPassword(
                    _oldPasswordTextField.text, _newPasswordTextField.text),
              );
            }
          }
        },
        child: Text(
          AppLocalizations.of(context)!.btn_continue,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

class _CancelButton extends StatelessWidget {
  const _CancelButton() : super();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.all(20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(50),
            backgroundColor: Colors.grey),
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(
          AppLocalizations.of(context)!.btn_dialog_cancel,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
