// ignore_for_file: use_super_parameters

import 'package:crises_control/src/core/errors/cc_error.dart';
import 'package:crises_control/src/core/models/authentication_credentials.dart';
import 'package:crises_control/src/core/presentation/widgets/cc_activity_indicator.dart';
//import 'package:crises_control/src/core/router/page_arguments/page_arguments.dart';
import 'package:crises_control/src/core/router/route_constants.dart';
import 'package:crises_control/src/login/bloc/login_bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBiometricPage extends StatefulWidget {
  const LoginBiometricPage({
    Key? key,
    required this.authenticationCredentialsList,
  }) : super(key: key);
  final List<AuthenticationCredentials> authenticationCredentialsList;

  @override
  State<LoginBiometricPage> createState() => _LoginBiometricPageState();
}

class _LoginBiometricPageState extends State<LoginBiometricPage> {
  final CCLoadingOverlay _loadingOverlay = CCLoadingOverlay();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accounts'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Center(
            child: BlocListener<LoginBloc, LoginState>(
              listener: (context, state) {
                _handleStateChanges(state, context);
              },
              child: Expanded(
                child: ListView.separated(
                  itemCount: widget.authenticationCredentialsList.length,
                  itemBuilder: (BuildContext context, int index) {
                    var authenticationCredentials =
                        widget.authenticationCredentialsList[index];
                    return ListTile(
                      leading: Image.network(
                        authenticationCredentials.companyLogo,
                        width: 70,
                        height: 70,
                        errorBuilder: (context, error, stackTrace) {
                          return const Image(
                            image: AssetImage('assets/images/cc_default.png'),
                            width: 70,
                            height: 70,
                          );
                        },
                        loadingBuilder: (context, error, stackTrace) {
                          return const Image(
                            image: AssetImage('assets/images/cc_default.png'),
                            width: 70,
                            height: 70,
                          );
                        },
                      ),
                      // leading: const Image(
                      //   image: AssetImage('assets/images/cc_default.png'),
                      //   width: 70,
                      //   height: 70,
                      // ),
                      title: Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              WidgetSpan(
                                child: Container(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: const Icon(Icons.house, size: 20),
                                ),
                              ),
                              TextSpan(
                                text: authenticationCredentials.customerId,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                      subtitle: RichText(
                        text: TextSpan(
                          children: [
                            WidgetSpan(
                              child: Container(
                                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                child: const Icon(Icons.mail, size: 20),
                              ),
                            ),
                            TextSpan(
                              text: authenticationCredentials.email,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        BlocProvider.of<LoginBloc>(context).add(
                          Login(
                            authenticationCredentials.email,
                            authenticationCredentials.password,
                            authenticationCredentials.rememberMe,
                            authenticationCredentials.customerId,
                          ),
                        );
                      },
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                ),
              ),
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
        builder: (context) => CCError.displayErrorAlert(state.error, context),
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
  }
}
