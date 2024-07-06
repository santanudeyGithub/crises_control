// ignore_for_file: deprecated_member_use, unused_import, prefer_const_constructors

import 'dart:io';

import 'package:crises_control/src/core/constants.dart';
import 'package:crises_control/src/core/models/authentication_credentials.dart';
import 'package:crises_control/src/core/presentation/widgets/cc_activity_indicator.dart';
import 'package:crises_control/src/core/presentation/widgets/cc_alert_dialog.dart';
import 'package:crises_control/src/core/presentation/widgets/cc_text_field.dart';
import 'package:crises_control/src/core/router/page_arguments/page_arguments.dart';
import 'package:crises_control/src/core/router/route_constants.dart';
import 'package:crises_control/src/core/utils/validation/email_validation.dart';
import 'package:crises_control/src/core/utils/validation/text_validation.dart';
import 'package:crises_control/src/login/bloc/login_bloc/login_bloc.dart';
import 'package:crises_control/src/login/view/pages/forgot_password.dart';
import 'package:crises_control/src/login/view/pages/responsiveness_scale_screen.dart';
import 'package:crises_control/src/login/view/widgets/app_version_text.dart';
import 'package:crises_control/src/login/view/widgets/company_logo_widget.dart';
import 'package:crises_control/src/login/view/widgets/login_text_field.dart';
import 'package:crises_control/src/login/view/widgets/privecy_policy_text.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:mason/mason.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
    required this.customerId,
    required this.authenticationCredentials,
    this.file,
  });
  final String customerId;
  final AuthenticationCredentials authenticationCredentials;
  final File? file;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final CCLoadingOverlay _loadingOverlay = CCLoadingOverlay();
  final TextEditingController _emailTextField = TextEditingController();
  late FocusNode _emailTextFieldFocusNode;

  final TextEditingController _customerIdTextField = TextEditingController();
  //The focus nodes allow me to dismiss the text fields as the main focus
  late FocusNode _customerIdFocusNode;

  final TextEditingController _forgotPasswordCustomerIdTextField =
      TextEditingController();
  late FocusNode _forgotPasswordCustomerIdNode;

  final TextEditingController _forgotPasswordEmailTextField =
      TextEditingController();
  late FocusNode _forgotPasswordEmailNode;
  final TextEditingController _passwordTextField = TextEditingController();
  late FocusNode _passwordTextFieldFocusNode;

  //This variable is use to validate the users input
  final _loginFormKey = GlobalKey<FormState>();

  //This bool indicate whether the user has selected remeber me or not
  bool _rememberMeSelected = false;
  bool _showBiometric = false;

  _LoginPageState();

  @override
  void initState() {
    super.initState();
    _emailTextFieldFocusNode = FocusNode();
    _passwordTextFieldFocusNode = FocusNode();
    _customerIdFocusNode = FocusNode();
    _forgotPasswordCustomerIdNode = FocusNode();
    _forgotPasswordEmailNode = FocusNode();

    _customerIdTextField.text = widget.customerId;
    _emailTextField.text = widget.authenticationCredentials.email;
    _passwordTextField.text = widget.authenticationCredentials.password;
    _rememberMeSelected = widget.authenticationCredentials.rememberMe;

    if (kDebugMode) {
      _emailTextField.text = 'denish.rai@transputec.com';
    } //TODO hardcoded for convenience
    if (kDebugMode) {
      _passwordTextField.text = 'Welcome\$123';
    } //TODO hardcoded for convenience

    BlocProvider.of<LoginBloc>(context).add(CheckBiometricsVisibility());
  }

  @override
  void dispose() {
    //make sure to dispose of focus nodes as if not, it can create memory leaks
    _customerIdFocusNode.dispose();
    _emailTextFieldFocusNode.dispose();
    _passwordTextFieldFocusNode.dispose();
    _forgotPasswordCustomerIdNode.dispose();
    _forgotPasswordEmailNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: unfocusTextField,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: SingleChildScrollView(
            child: BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) {
                _handleStateChanges(state, context);
              },
              builder: (context, state) {
                return Column(
                  children: <Widget>[
                    // CompanyLogoView(
                    //   height: 150,
                    //   width: 150,
                    //   file: widget.file,
                    // ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),

                    Center(
                      //padding: EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Log In to continue',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff0B223C),
                            ),
                          ),
                          SizedBox(height: 10),
                          // Text(
                          //   'Remember everything important.',
                          //   style: TextStyle(
                          //     fontSize: 18,
                          //     color: Colors.black,
                          //   ),
                          // ),
                          Container(
                            height: 100,
                            width: 100,
                            child: Image.asset(
                                "assets/images/crises_control_logo_new.png"),
                          ),
                        ],
                      ),
                    ),
                    _CustomerIdEntry(
                      customerIdTextField: _customerIdTextField,
                      customerIdFocusNode: _customerIdFocusNode,
                    ),
                    const _ChangeCustomerId(),
                    Form(
                      key: _loginFormKey,
                      child: Column(
                        children: [
                          _EmailEntry(
                            emailTextField: _emailTextField,
                            emailTextFieldFocusNode: _emailTextFieldFocusNode,
                          ),
                          _PasswordEntry(
                            passwordTextField: _passwordTextField,
                            passwordTextFieldFocusNode:
                                _passwordTextFieldFocusNode,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 210),
                      child: _remeberMe(),
                    ),
                    _LoginButton(
                      emailTextField: _emailTextField,
                      passwordTextField: _passwordTextField,
                      formKey: _loginFormKey,
                      remeberMe: _rememberMeSelected,
                      customerId: 'cc-eec-tw',
                    ),
                    Row(
                      children: [
                        Visibility(
                          visible: _showBiometric,
                          child: const _UseBiometrics(),
                        ),
                        const Spacer(),
                        _ForgotPassword(
                          forgotPasswordCustomerIdTextField:
                              _forgotPasswordCustomerIdTextField,
                          customerIdTextField: _customerIdTextField,
                          forgotPasswordEmailTextField:
                              _forgotPasswordEmailTextField,
                          emailTextField: _emailTextField,
                          forgotPasswordCustomerIdNode:
                              _forgotPasswordCustomerIdNode,
                          forgotPasswordEmailNode: _forgotPasswordEmailNode,
                        ),
                        Column(
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: TextButton(
                                  onPressed: () => Navigator.pushNamed(
                                    context,
                                    RouteConstants.forgotPasswordPage,
                                    arguments: ForgotPasswordPageArguments(
                                      "cc-eec-tw",
                                      "denish.rai@transputec.com",
                                      AuthenticationCredentials(
                                        "",
                                        "",
                                        "",
                                        false,
                                        "",
                                        "",
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        child: Text(
                                          "Use Biometric?",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Color(0xff2175D4),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          "Forgot Password?",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Color(0xff2175D4),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    const PrivacyPolicyText(),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _handleStateChanges(LoginState state, BuildContext context) {
    //Login
    if (state is LoginFailure) {
      showDialog(
        context: context,
        builder: (context) => state.error.displayErrorAlerts(context),
      );
    }
    if (state is LoginLoading) {
      _loadingOverlay.show(context);
    } else {
      _loadingOverlay.hide();
    }
    if (state is LoginSuccess) {
      Navigator.pushNamed(
        context,
        RouteConstants.homePage,
      );
    }

    //Biometric
    if (state is CheckBiometricVisibilitySuccess) {
      _showBiometric = state.showBiometric;
    }
    if (state is LoginBiometricSuccess) {
      var authenticationCredentialsList = state.authenticationCredentialsList;
      if (authenticationCredentialsList.isNotEmpty) {
        if (authenticationCredentialsList.length == 1) {
          var authenticationCredentials = authenticationCredentialsList[0];
          BlocProvider.of<LoginBloc>(context).add(
            Login(
              authenticationCredentials.email,
              authenticationCredentials.password,
              authenticationCredentials.rememberMe,
              authenticationCredentials.customerId,
            ),
          );
        } else {
          Navigator.pushNamed(
            context,
            RouteConstants.loginBiometricPage,
            arguments: LoginBiometricPageArguments(
              authenticationCredentialsList: authenticationCredentialsList,
            ),
          );
        }
      }
    }
  }

  TextButton _remeberMe() {
    return TextButton(
      onPressed: () {
        setState(() {
          //Inverts the bool
          _rememberMeSelected = !_rememberMeSelected;
        });
      },
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(
          _rememberMeSelected ? Colors.blue : Colors.grey,
        ),
        overlayColor: MaterialStateProperty.all(Colors.white),
      ),
      child: _RememberMeButton(remeberMeSelected: _rememberMeSelected),
    );
  }
}

class _ForgotPassword extends StatelessWidget {
  const _ForgotPassword({
    Key? key,
    required TextEditingController forgotPasswordCustomerIdTextField,
    required TextEditingController customerIdTextField,
    required TextEditingController forgotPasswordEmailTextField,
    required TextEditingController emailTextField,
    required FocusNode forgotPasswordCustomerIdNode,
    required FocusNode forgotPasswordEmailNode,
  })  : _forgotPasswordCustomerIdTextField = forgotPasswordCustomerIdTextField,
        _customerIdTextField = customerIdTextField,
        _forgotPasswordEmailTextField = forgotPasswordEmailTextField,
        _emailTextField = emailTextField,
        _forgotPasswordCustomerIdNode = forgotPasswordCustomerIdNode,
        _forgotPasswordEmailNode = forgotPasswordEmailNode,
        super(key: key);

  final TextEditingController _forgotPasswordCustomerIdTextField;
  final TextEditingController _customerIdTextField;
  final TextEditingController _forgotPasswordEmailTextField;
  final TextEditingController _emailTextField;
  final FocusNode _forgotPasswordCustomerIdNode;
  final FocusNode _forgotPasswordEmailNode;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        _forgotPasswordCustomerIdTextField.text = _customerIdTextField.text;
        _forgotPasswordEmailTextField.text = _emailTextField.text;
        showDialog(
          context: context,
          builder: (context) => CCTextAlertDialog(
            title: AppLocalizations.of(context)!.dialog_title_forgot_password,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppLocalizations.of(context)!
                      .forgot_password_description_dialog,
                ),
                TextFormField(
                  controller: _forgotPasswordCustomerIdTextField,
                  focusNode: _forgotPasswordCustomerIdNode,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.customer_id,
                  ),
                ),
                TextFormField(
                  controller: _forgotPasswordEmailTextField,
                  focusNode: _forgotPasswordEmailNode,
                  decoration: InputDecoration(
                    //helperText: AppLocalizations.of(context)!.hint_email,
                    labelText: AppLocalizations.of(context)!.email,
                  ),
                ),
              ],
            ),
            actions: [
              const CancelAlertButton(),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Send'),
              )
            ],
          ),
        );
      },
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(Colors.white),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
        // child: Text(
        // AppLocalizations.of(context)!.btn_forgot_password,
        //style: Theme.of(context).textTheme.caption,
        // ),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({
    Key? key,
    required TextEditingController emailTextField,
    required TextEditingController passwordTextField,
    required this.formKey,
    required this.remeberMe,
    required this.customerId,
  })  : _emailTextField = emailTextField,
        _passwordTextField = passwordTextField,
        super(key: key);
  final GlobalKey<FormState> formKey;
  final TextEditingController _emailTextField;
  final TextEditingController _passwordTextField;
  final bool remeberMe;
  final String customerId;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(50),
          backgroundColor: const Color(0xff2175D4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              UIConstants.defaultCornerRadius,
            ),
          ),
        ),
        onPressed: () {
          if (formKey.currentState!.validate()) {
            BlocProvider.of<LoginBloc>(context).add(
              Login(
                _emailTextField.text,
                _passwordTextField.text,
                remeberMe,
                customerId,
              ),
            );
          }
        },
        /*onPressed: () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (BuildContext context) => ResponsivenessScale())),*/
        child: const Text(
          'SIGN IN',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}

class _ChangeCustomerId extends StatelessWidget {
  const _ChangeCustomerId({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Align(
        alignment: Alignment.bottomRight,
        // child: TextButton(
        //   //onPressed: () => Navigator.of(context).pop(),
        //   onPressed: () => showDialog<String>(
        //     context: context,
        //     builder: (BuildContext context) => CCAlertDialog(
        //       title: 'How to find your customer id',
        //       description: FrontEndConstants.forgotCustomerIdDescription,
        //       actions: [
        //         TextButton(
        //           onPressed: () => Navigator.pop(context),
        //           child: const Text('Ok'),
        //         )
        //       ],
        //     ),
        //   ),
        //   child: Text(
        //     'Forgot Customer ID',
        //     style: TextStyle(
        //         fontSize: 16, color: Color.fromARGB(255, 30, 96, 170)),
        //   ),
        // ),

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

class _UseBiometrics extends StatelessWidget {
  const _UseBiometrics({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        BlocProvider.of<LoginBloc>(context).add(
          UseBiometrics(),
        );
      },
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(Colors.white),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
        child: Row(
          children: [
            const Icon(
              Icons.fingerprint,
              size: 20,
            ),
            Text(
              AppLocalizations.of(context)!
                  .btn_aunthentication_using_finger_print,
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      ),
    );
  }
}

class _RememberMeButton extends StatelessWidget {
  const _RememberMeButton({
    Key? key,
    required bool remeberMeSelected,
  })  : _remeberMeSelected = remeberMeSelected,
        super(key: key);

  final bool _remeberMeSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            size: 24,
            _remeberMeSelected
                ? Icons.check_box_rounded
                : Icons.check_box_outline_blank_rounded,
          ),
          Text(
            'Remember me',
            style: Theme.of(context).textTheme.caption?.apply(
                  color: _remeberMeSelected ? Colors.blue : Color(0xff3A3A3A),
                  fontSizeDelta: 5,
                ),
          ),
        ],
      ),
    );
  }
}

class _LoginToConnect extends StatelessWidget {
  const _LoginToConnect({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Text(
        AppLocalizations.of(context)!.login_to_connect,
        style: Theme.of(context).textTheme.titleSmall,
      ),
    );
  }
}

class _PasswordEntry extends StatefulWidget {
  const _PasswordEntry({
    Key? key,
    required TextEditingController passwordTextField,
    required FocusNode passwordTextFieldFocusNode,
  })  : _passwordTextField = passwordTextField,
        _passwordTextFieldFocusNode = passwordTextFieldFocusNode,
        super(key: key);

  final TextEditingController _passwordTextField;
  final FocusNode _passwordTextFieldFocusNode;

  @override
  State<_PasswordEntry> createState() => _PasswordEntryState();
}

class _PasswordEntryState extends State<_PasswordEntry> {
  bool _obscureText = true;
  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Password', // Displaying "Password" as the label
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              )),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            controller: widget._passwordTextField,
            obscureText: _obscureText,
            enableSuggestions: false,
            autocorrect: false,
            focusNode: widget._passwordTextFieldFocusNode,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  UIConstants.defaultCornerRadius,
                ),
              ),
              //labelText: 'Email', // Displaying "Email" as the label
              //labelText: AppLocalizations.of(context)!.email,
              hintText: 'Enter your unique Password', // Adding hint text
              //helperText: AppLocalizations.of(context)!.hint_password,
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: _togglePasswordVisibility,
              ),
            ),
            validator: (text) => TextValidator.canNotBeEmpty(text),
          ),
        ],
      ),
    );
    //     child: TextFormField(
    //       obscureText: true,
    //       enableSuggestions: false,
    //       autocorrect: false,
    //       controller: widget._passwordTextField,
    //       focusNode: widget._passwordTextFieldFocusNode,
    //       decoration: InputDecoration(
    //         border: OutlineInputBorder(
    //           borderRadius: BorderRadius.circular(
    //             UIConstants.defaultCornerRadius,
    //           ),
    //         ),
    //         labelText: AppLocalizations.of(context)!.hint_password,
    //       ),
    //       validator: (text) => TextValidator.canNotBeEmpty(text),
    //     ),
    //   );
  }
}

class _EmailEntry extends StatefulWidget {
  const _EmailEntry({
    Key? key,
    required TextEditingController emailTextField,
    required FocusNode emailTextFieldFocusNode,
  })  : _emailTextField = emailTextField,
        _emailTextFieldFocusNode = emailTextFieldFocusNode,
        super(key: key);

  final TextEditingController _emailTextField;
  final FocusNode _emailTextFieldFocusNode;

  @override
  State<_EmailEntry> createState() => _EmailEntryState();
}

// class _EmailEntryState extends State<_EmailEntry> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
//       child: TextFormField(
//         controller: widget._emailTextField,
//         focusNode: widget._emailTextFieldFocusNode,
//         keyboardType: TextInputType.emailAddress,
//         decoration: InputDecoration(
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(
//               UIConstants.defaultCornerRadius,
//             ),
//           ),
//           helperText: AppLocalizations.of(context)!.hint_email,
//           labelText: AppLocalizations.of(context)!.email,
//         ),
//         validator: (email) => EmailValidator.isValidEmail(email),
//       ),
//     );
//   }
// }

class _EmailEntryState extends State<_EmailEntry> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Email', // Displaying "Email" as the label
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
              height:
                  8), // Adding some spacing between the label and the TextFormField
          TextFormField(
            controller: widget._emailTextField,
            focusNode: widget._emailTextFieldFocusNode,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  UIConstants.defaultCornerRadius,
                ),
              ),
              //labelText: 'Email', // Displaying "Email" as the label
              //labelText: AppLocalizations.of(context)!.email,
              hintText: 'Enter your unique @email', // Adding hint text
              //helperText: AppLocalizations.of(context)!.hint_email,
            ),
            validator: (email) => EmailValidator.isValidEmail(email),
          ),
        ],
      ),
    );
  }
}

class _CustomerIdEntry extends StatelessWidget {
  const _CustomerIdEntry({
    Key? key,
    required TextEditingController customerIdTextField,
    required FocusNode customerIdFocusNode,
  })  : _customerIdTextField = customerIdTextField,
        _customerIdFocusNode = customerIdFocusNode,
        super(key: key);

  final TextEditingController _customerIdTextField;
  final FocusNode _customerIdFocusNode;

  @override
  Widget build(BuildContext context) {
    return LoginTextField(
      textEditingController: _customerIdTextField,
      textEntryFocusNode: _customerIdFocusNode,
      labelText: 'Customer ID',
      readOnly: true,
    );
  }
}
