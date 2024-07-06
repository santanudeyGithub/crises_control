// ignore_for_file: use_super_parameters

import 'package:crises_control/src/core/errors/cc_error.dart';
import 'package:crises_control/src/core/presentation/widgets/cc_activity_indicator.dart';
import 'package:crises_control/src/core/presentation/widgets/cc_alert_dialog.dart';
import 'package:crises_control/src/core/presentation/widgets/cc_text_field.dart';
import 'package:crises_control/src/core/router/route_constants.dart';
import 'package:crises_control/src/login/cubit/login_first_otp_cubit/login_first_otp_cubit.dart';
import 'package:crises_control/src/login/view/widgets/login_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginFirstOtpPage extends StatefulWidget {
  const LoginFirstOtpPage({
    Key? key,
    required this.customerId,
    required this.oldPassword,
    required this.newPassword,
    required this.userName,
    required this.rememberMe,
  }) : super(key: key);
  final String customerId;
  final String oldPassword;
  final String newPassword;
  final String userName;
  final bool rememberMe;

  @override
  // _LoginFirstOtpPageState createState() => _LoginFirstOtpPageState();
  State<LoginFirstOtpPage> createState() => _LoginFirstOtpPageState();
}

class _LoginFirstOtpPageState extends State<LoginFirstOtpPage> {
  final CCLoadingOverlay _loadingOverlay = CCLoadingOverlay();

  final TextEditingController _otpCodeTextField = TextEditingController();
  late FocusNode _otpCodeTextFieldFocusNode;

  final _otpFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _otpCodeTextFieldFocusNode = FocusNode();
  }

  @override
  void dispose() {
    //make sure to dispose of focus nodes as if not, it can create memory leaks
    _otpCodeTextFieldFocusNode.dispose();
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
            child: Center(
              child: BlocListener<LoginFirstOtpCubit, LoginFirstOtpState>(
                listener: (context, state) {
                  _handleStateChanges(state, context);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      children: [
                        Text(
                          AppLocalizations.of(context)
                              !.label_two_step_verification,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          AppLocalizations.of(context)
                              !.label_verify_otp_verification,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Form(
                          key: _otpFormKey,
                          child: Column(children: [
                            LoginTextField(
                              textEditingController: _otpCodeTextField,
                              textEntryFocusNode: _otpCodeTextFieldFocusNode,
                              labelText: AppLocalizations.of(context)
                                  !.hint_enter_otp_code,
                            ),
                          ]),
                        ),
                        const SizedBox(height: 10),
                        TextButton(
                          onPressed: () async {
                            await context
                                .read<LoginFirstOtpCubit>()
                                .onResendOtp(
                                  widget.oldPassword,
                                  widget.newPassword,
                                  _otpCodeTextField.text,
                                );
                          },
                          style: ButtonStyle(
                            overlayColor:
                                MaterialStateProperty.all(Colors.white),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    AppLocalizations.of(context)
                                        !.btn_resend_code,
                                    style: Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        _ContinueButton(
                          oldPassword: widget.oldPassword,
                          newPassword: widget.newPassword,
                          otpCodeTextField: _otpCodeTextField,
                          customerId: widget.customerId,
                          userName: widget.userName,
                          rememberMe: widget.rememberMe,
                          formKey: _otpFormKey,
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
    );
  }

  void _handleStateChanges(LoginFirstOtpState state, BuildContext context) {
    if (state is LoginFirstOtpLoading) {
      _loadingOverlay.show(context);
    } else {
      _loadingOverlay.hide();
    }

    //Failure
    if (state is SubmitOtpFailure) {
      showDialog(
        context: context,
        builder: (context) => CCError.displayErrorAlert(state.error, context),
      );
    }
    if (state is LoginFailure) {
      showDialog(
        context: context,
        builder: (context) => CCError.displayErrorAlert(state.error, context),
      );
    }
    if (state is ResendOtpFailure) {
      showDialog(
        context: context,
        builder: (context) => CCError.displayErrorAlert(state.error, context),
      );
    }

    //Success
    if (state is ResendOtpSuccess) {
      showDialog(
        context: context,
        builder: (context) =>          
            const CCAlertDialog(
          title: "Alert",
          description: "Verification code has been sent to the mobile number.",
          actions: [
            OkAlertButton(),
          ],
        ),
      );
    }
    if (state is LoginSuccess) {
      Navigator.pushNamed(
        context,
        RouteConstants.homePage,
      );
    }
  }
}

class _ContinueButton extends StatelessWidget {
  const _ContinueButton({
    Key? key,
    required String oldPassword,
    required String newPassword,
    required TextEditingController otpCodeTextField,
    required String customerId,
    required String userName,
    required bool rememberMe,
    required this.formKey,
  })  : _oldPassword = oldPassword,
        _newPassword = newPassword,
        _otpCodeTextField = otpCodeTextField,
        _customerId = customerId,
        _userName = userName,
        _rememberMe = rememberMe,
        super(key: key);
  final GlobalKey<FormState> formKey;
  final String _oldPassword;
  final String _newPassword;
  final TextEditingController _otpCodeTextField;
  final String _customerId;
  final String _userName;
  final bool _rememberMe;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.all(20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(50),
        ),
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            await context.read<LoginFirstOtpCubit>().onSubmitOtp(
                  oldPassword: _oldPassword,
                  newPassword: _newPassword,
                  otpCode: _otpCodeTextField.text,
                  userName: _userName,
                  rememberMe: _rememberMe,
                  customerId: _customerId,
                );
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
