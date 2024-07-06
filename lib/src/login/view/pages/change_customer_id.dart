// ignore_for_file: inference_failure_on_function_invocation, inference_failure_on_instance_creation, prefer_const_constructors
import 'package:crises_control/src/core/constants.dart';
import 'package:crises_control/src/core/errors/cc_error.dart';
import 'package:crises_control/src/core/models/authentication_credentials.dart';
import 'package:crises_control/src/core/presentation/widgets/cc_activity_indicator.dart';
import 'package:crises_control/src/core/presentation/widgets/cc_alert_dialog.dart';
import 'package:crises_control/src/core/presentation/widgets/cc_text_field.dart';
import 'package:crises_control/src/core/router/page_arguments/page_arguments.dart';
import 'package:crises_control/src/core/router/route_constants.dart';
import 'package:crises_control/src/login/bloc/customer_id_bloc/customer_id_bloc.dart';
import 'package:crises_control/src/login/bloc/login_bloc/login_bloc.dart';
import 'package:crises_control/src/login/view/pages/forgot_password.dart';
import 'package:crises_control/src/login/view/pages/login_page.dart';
import 'package:crises_control/src/login/view/widgets/app_version_text.dart';
import 'package:crises_control/src/login/view/widgets/company_logo_widget.dart';
import 'package:crises_control/src/login/view/widgets/login_text_field.dart';
import 'package:crises_control/src/login/view/widgets/privecy_policy_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mason/mason.dart';

class ChangeCustomerIdPage extends StatefulWidget {
  const ChangeCustomerIdPage({super.key});

  @override
  State<ChangeCustomerIdPage> createState() => _ChangeCustomerIdPageState();
}

class _ChangeCustomerIdPageState extends State<ChangeCustomerIdPage> {
  final _loadingOverlay = CCLoadingOverlay();
  final _customerIdTextEntry = TextEditingController();
  late FocusNode _customerIdTextEntryFocusNode;

  @override
  void initState() {
    super.initState();
    _customerIdTextEntryFocusNode = FocusNode();
    if (kDebugMode)
      _customerIdTextEntry.text = 'cc-eec-tw'; //TODO hardcoded for convenience
  }

  @override
  void dispose() {
    _customerIdTextEntryFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var language = AppLocalizations.of(context);
    return GestureDetector(
      onTap: unfocusTextField,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Center(
            child: BlocConsumer<CustomerIdBloc, CustomerIdState>(
              listener: (context, state) {
                _handleStateChanges(state, context);
              },
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Text(
                        //language!.welcome_message,
                        'Change Customer ID',
                        style: GoogleFonts.roboto(
                          fontSize: 28.0,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff3A3A3A),
                        ),
                      ),
                    ),
                    const Spacer(),
                    const CompanyLogoView(
                      height: 150,
                      width: 150,
                    ),

                    SizedBox(height: 10.0),

                    // Opacity(
                    //   opacity: 0.5,
                    //   child: Text(
                    //     language.welcome_message_1,
                    //     style: GoogleFonts.urbanist(
                    //       fontSize: 20.0,
                    //       fontWeight: FontWeight.w400,
                    //       color: Color(0xff0B223C),
                    //     ),
                    //   ),
                    // ),

                    const SizedBox(height: 50.0),

                    LoginTextField(
                      textEntryFocusNode: _customerIdTextEntryFocusNode,

                      labelText: language!.customer_id,

                      textEditingController: _customerIdTextEntry,

                      //suggestionText: language!.enter_customer_id,
                    ),
                    // LoginTextField(
                    //  textEntryFocusNode: _customerIdTextEntryFocusNode,
                    //  labelText: 'Enter Customer ID',
                    //   textEditingController: _customerIdTextEntry,
                    //  ),
                    _NextButton(
                      customerIdTextEntry: _customerIdTextEntry,
                    ),
                    const _ForgotCustomerIdTextButton(),
                    const CancelButton(),
                    const Spacer(
                      flex: 4,
                    ),
                    const AppVersionText(),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _handleStateChanges(CustomerIdState state, BuildContext context) {
    if (state is CustomerIdLoading) {
      _loadingOverlay.show(context);
    } else {
      _loadingOverlay.hide();
    }
    if (state is CustomerIdFailure) {
      showDialog(
        context: context,
        builder: (context) => CCError.displayErrorAlert(state.error, context),
      );
    }
    if (state is CustomerIdSuccess) {
      Navigator.pushNamed(
        context,
        RouteConstants.loginPage,
        arguments: LoginPageArguments(
          _customerIdTextEntry.text,
          state.authenticationCredentials,
        ),
      );
    }
  }
}

class _NextButton extends StatelessWidget {
  const _NextButton({
    required TextEditingController customerIdTextEntry,
  }) : _customerIdTextEntry = customerIdTextEntry;

  final TextEditingController _customerIdTextEntry;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(50),
          backgroundColor: Color(0xff2175D4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              UIConstants.defaultCornerRadius,
            ),
          ),
        ),
        child: Text(
          'NEXT',
          style: GoogleFonts.roboto(
              fontSize: 16,
              color: Color(0xffFFFFFF),
              fontWeight: FontWeight.w700),
        ),
        /* onPressed: () {
          Navigator.of(context)
              .pushReplacementNamed(RouteConstants.loginScreen);
        },*/

        /* onPressed: () => BlocProvider.of<CustomerIdBloc>(context).add(
          CustomerIdNext(_customerIdTextEntry.text),
        ),*/
        onPressed: () => Navigator.pushNamed(
          context,
          RouteConstants.loginPage,
          arguments: LoginPageArguments(
              "cc-eec-tw",
              AuthenticationCredentials(
                "",
                "",
                "",
                false,
                "",
                "",
              )
              //state.authenticationCredentials,
              ),
        ),
      ),
    );
  }
}

class _ForgotCustomerIdTextButton extends StatelessWidget {
  const _ForgotCustomerIdTextButton();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Align(
        alignment: Alignment.center,
        child: TextButton(
          onPressed: () => showDialog<String>(
            context: context,
            builder: (BuildContext context) => CCAlertDialog(
              title: 'How to find your customer id',
              description: FrontEndConstants.forgotCustomerIdDescription,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 100),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Color(0xff2175D4),
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(5.0), // Border radius
                        side: BorderSide(
                            color: Colors.blue,
                            width: 2), // Border color and width
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Ok'.upperCase,
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 210),
            child: Text(
              'Forgot Customer ID?',
              style: GoogleFonts.roboto(
                  fontSize: 14,
                  color: Color(0xff2175D4),
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ),
    );
  }
}

class CancelButton extends StatelessWidget {
  const CancelButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(50),
          backgroundColor: Color.fromARGB(255, 225, 226, 226),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              UIConstants.defaultCornerRadius,
            ),
          ),
        ),
        child: Text(
          'Cancel'.upperCase,
          style: GoogleFonts.roboto(
              fontSize: 16,
              color: Color.fromARGB(255, 0, 0, 0),
              fontWeight: FontWeight.w700),
        ),
        /* onPressed: () {
          Navigator.of(context)
              .pushReplacementNamed(RouteConstants.loginScreen);
        },*/

        /* onPressed: () => BlocProvider.of<CustomerIdBloc>(context).add(
          CustomerIdNext(_customerIdTextEntry.text),
        ),*/
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}
