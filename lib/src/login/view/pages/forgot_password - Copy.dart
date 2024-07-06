// ignore_for_file: prefer_const_constructors, dead_code, use_super_parameters, unnecessary_this

import 'package:crises_control/src/core/constants.dart';
import 'package:crises_control/src/core/router/route_constants.dart';
import 'package:crises_control/src/login/bloc/login_bloc/login_bloc.dart';
import 'package:crises_control/src/login/view/widgets/customized_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crises_control/src/core/utils/validation/text_validation.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({
    Key? key,
    required this.customerId,
    required this.email,
    required authenticationCredentials,
  }) : super(key: key);

  final String customerId;
  final String email;

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  late TextEditingController _customerIdController;
  late TextEditingController _emailController;
  final _loginFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _customerIdController = TextEditingController(text: widget.customerId);
    _emailController = TextEditingController(text: widget.email);
  }

  @override
  void dispose() {
    _customerIdController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height * 0.6,
          width: double.infinity,
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          child: Stack(
            children: [
              Positioned(
                left: 100,
                top: 25,
                child: Text(
                  "Forgot password",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Positioned(
                child: Image(
                    image: AssetImage("assets/images/forgot_password.png")),
              ),
              Padding(
                padding: EdgeInsets.only(top: 350, left: 25),
                child: Positioned(
                  child: Text(
                    "Customer ID",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 385, left: 0),
                child: Positioned(
                  child: CustomizedTextfield(
                    myController: _customerIdController,
                    hintText: "Enter your unique Id",
                    isPassword: false,
                    validator: (text) => TextValidator.canNotBeEmpty(text),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 465, left: 25),
                child: Positioned(
                  child: Text(
                    "Email",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 495, left: 0),
                child: Positioned(
                  child: CustomizedTextfield(
                    myController: _emailController,
                    hintText: "Enter your unique email",
                    isPassword: false,
                    validator: (text) => TextValidator.canNotBeEmpty(text),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 565, left: 0),
                child: Positioned(
                  child: _ForgotPasswordButton(
                    emailTextField: _emailController,
                    formKey: _loginFormKey,
                    customerId: 'cc-eec-tw',
                  ),

                  /* Padding(
                padding: const EdgeInsets.only(top: 20),
                 child: Text("SEND"),
                ),
                ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(RouteConstants.customerIdPage);
                },
                child: Text("Cancel"),
              ),*/
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ForgotPasswordButton extends StatelessWidget {
  const _ForgotPasswordButton({
    Key? key,
    required TextEditingController emailTextField,
    required this.formKey,
    required this.customerId,
  })  : _emailTextField = emailTextField,
        super(key: key);
  final GlobalKey<FormState> formKey;
  final TextEditingController _emailTextField;
  final String customerId;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        Container(
          key: formKey,
          height: 100,
          padding: const EdgeInsets.all(20),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
              backgroundColor: const Color.fromARGB(255, 3, 79, 140),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  UIConstants.defaultCornerRadius,
                ),
              ),
            ),
            child: BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) {
                _handleStateChanges(state, context);
              },
              builder: (context, state) {
                return const Text(
                  'FORGOT PASSWORD',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                );
              },
            ),
            onPressed: () {
              if (!(customerId.isEmpty || _emailTextField.text.isEmpty)) {
                BlocProvider.of<LoginBloc>(context).add(
                  SendForgotPassword(
                    _emailTextField.text,
                    customerId,
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('<> is empty')),
                );
              }
            },
          ),
        ),
        SizedBox(height: 2),
        Padding(
          padding:
              const EdgeInsets.only(left: 22, right: 22, bottom: 0, top: 0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
              backgroundColor: Color.fromARGB(255, 237, 237, 238),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  UIConstants.defaultCornerRadius,
                ),
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Cancel'.toUpperCase(),
              style: GoogleFonts.urbanist(fontSize: 18, color: Colors.black),
            ),
          ),
        ),
      ],
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
      // _loadingOverlay.show(context);
    } else {
      // _loadingOverlay.hide();
    }
    if (state is LoginSuccess) {
      Navigator.pushNamed(
        context,
        RouteConstants.homePage,
      );
    }
  }
}
