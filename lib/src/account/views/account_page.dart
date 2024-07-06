// import 'dart:developer';

// import 'package:crises_control/src/account/cubit/account_cubit.dart';
// import 'package:crises_control/src/core/models/user_info.dart';
// import 'package:crises_control/src/core/presentation/widgets/buttons.dart';
// import 'package:crises_control/src/core/presentation/widgets/cc_activity_indicator.dart';
// import 'package:crises_control/src/core/presentation/widgets/custom_widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';
// import 'package:crises_control/src/CustomAppbar.dart';

// class AccountPage extends StatelessWidget {
//   AccountPage({super.key});
//   final CCLoadingOverlay _loadingOverlay = CCLoadingOverlay();

//   @override
//   Widget build(BuildContext context) {
//     var language = AppLocalizations.of(context);
//     return Scaffold(
//       body: Stack(
//         children: [
//           Positioned(
//             top: 0,
//             left: 0,
//             right: 0,
//             child: CustomHeader(
//               title: language!.title_my_account,
//             ),
//           ),
//           Positioned(
//             top: 150, // Adjust this value as necessary
//             left: 16,
//             right: 16,
//             bottom: 0,
//             child: BlocConsumer<AccountCubit, AccountState>(
//               listener: (context, state) {
//                 handleStateChanges(state, context);
//               },
//               builder: (context, state) {
//                 if (state.userInfo != null) {
//                   return AccountPageView(userInfo: state.userInfo!);
//                 }
//                 return Container();
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void handleStateChanges(AccountState state, BuildContext context) {
//     if (state.isLoading) {
//       _loadingOverlay.show(context);
//     } else {
//       _loadingOverlay.hide();
//     }
//     if (state.error != null) {
//       showDialog(
//         context: context,
//         builder: (context) => state.error!.displayErrorAlerts(context),
//       );
//     }
//   }
// }

// class AccountPageView extends StatelessWidget {
//   const AccountPageView({super.key, required this.userInfo});
//   static const double spacingHeight = 20;
//   final UserInfo userInfo;

//   @override
//   Widget build(BuildContext context) {
//     var language = AppLocalizations.of(context);
//     return Material(
//       elevation: 4.0,
//       borderRadius: BorderRadius.circular(16.0),
//       child: Padding(
//         padding: const EdgeInsets.all(5.0),
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: CCAvatar(
//                 senderName: userInfo.fullName,
//                 radius: 40,
//                 fontSize: 22,
//               ),
//             ),
//             _AccountFormField(
//               hintText: language!.myaccount_firstname_placeholder,
//               helperText: language.myaccount_firstname,
//               initialValue: userInfo.firstName,
//               icon: Icons.person,
//             ),
//             const SizedBox(height: spacingHeight),
//             _AccountFormField(
//               hintText: language.myaccount_lastname_placeholder,
//               helperText: language.myaccount_lastname,
//               initialValue: userInfo.lastName,
//               icon: Icons.person,
//             ),
//             const SizedBox(height: spacingHeight),
//             IntlPhoneField(
//               decoration: InputDecoration(
//                 icon: const Icon(Icons.smartphone, color: Colors.blue),
//                 helperText: language.myaccount_mobile,
//               ),
//               initialValue: userInfo.mobileNo,
//               initialCountryCode: userInfo.countryCode,
//               onChanged: (phone) {
//                 log(phone.completeNumber);
//               },
//             ),
//             const SizedBox(height: spacingHeight),
//             IntlPhoneField(
//               decoration: InputDecoration(
//                 icon: const Icon(Icons.phone, color: Colors.blue),
//                 helperText: language.myaccount_landline,
//               ),
//               initialCountryCode: userInfo.countryCode,
//               onChanged: (phone) {
//                 log(phone.completeNumber);
//               },
//             ),
//             const SizedBox(height: spacingHeight),
//             _AccountFormField(
//               initialValue: userInfo.primaryEmail,
//               //icon: Icons.email,
//               icon: Icons.email,
//               helperText: language.myaccount_email,
//               isEnabled: false,
//             ),
//             CCButton(language.btn_label_save, onPressed: () {}),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _AccountFormField extends StatelessWidget {
//   const _AccountFormField({
//     Key? key,
//     required this.helperText,
//     this.hintText = '',
//     this.initialValue = '',
//     required this.icon,
//     this.isEnabled = true,
//   }) : super(key: key);

//   final String helperText;
//   final String? hintText;
//   final IconData icon;
//   final bool isEnabled;
//   final String initialValue;

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       initialValue: initialValue,
//       enabled: isEnabled,
//       decoration: InputDecoration(
//         hintText: hintText,
//         icon: Icon(
//           icon,
//           // color: Color(0xff1E60AA),
//           color: Colors.blue,
//         ),
//         helperText: "$helperText *",
//       ),
//     );
//   }
// }

import 'dart:developer';

import 'package:crises_control/src/account/cubit/account_cubit.dart';
import 'package:crises_control/src/core/constants.dart';
import 'package:crises_control/src/core/models/user_info.dart';
import 'package:crises_control/src/core/presentation/widgets/buttons.dart';
import 'package:crises_control/src/core/presentation/widgets/cc_activity_indicator.dart';
import 'package:crises_control/src/core/presentation/widgets/custom_widgets.dart';
import 'package:crises_control/src/core/utils/validation/text_validation.dart';
import 'package:crises_control/src/login/view/widgets/customized_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:crises_control/src/CustomAppbar.dart';
import 'package:mason/mason.dart';

class AccountPage extends StatelessWidget {
  AccountPage({super.key});
  final CCLoadingOverlay _loadingOverlay = CCLoadingOverlay();

  @override
  Widget build(BuildContext context) {
    var language = AppLocalizations.of(context);
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CustomHeader(
              title: language!.title_my_account,
            ),
          ),
          Positioned(
            top: 150, // Adjust this value as necessary
            left: 16,
            right: 16,
            bottom: 0,
            child: BlocConsumer<AccountCubit, AccountState>(
              listener: (context, state) {
                handleStateChanges(state, context);
              },
              builder: (context, state) {
                if (state.userInfo != null) {
                  return AccountPageView(userInfo: state.userInfo!);
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }

  void handleStateChanges(AccountState state, BuildContext context) {
    if (state.isLoading) {
      _loadingOverlay.show(context);
    } else {
      _loadingOverlay.hide();
    }
    if (state.error != null) {
      showDialog(
        context: context,
        builder: (context) => state.error!.displayErrorAlerts(context),
      );
    }
  }
}

class AccountPageView extends StatelessWidget {
  AccountPageView({super.key, required this.userInfo});
  static const double spacingHeight = 20;
  final UserInfo userInfo;

  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var language = AppLocalizations.of(context);
    return SingleChildScrollView(
      child: Stack(
        alignment: Alignment.topCenter,
        clipBehavior: Clip.none,
        children: [
          Container(
            margin: EdgeInsets.only(
                top: 30,
                left: 15,
                right: 15), // Adjust this to position the box
            padding: EdgeInsets.all(16.0),
            width: 350,
            height: 95,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 25), // Space for the circle
                // Text(
                //   'Pandemic',
                //   textAlign: TextAlign.center,
                //   style: GoogleFonts.urbanist(fontSize: 22),
                // ),

                SizedBox(height: 20),
                // Container(
                //   height: 115,
                //   width: 400,
                //   decoration: BoxDecoration(
                //     color: const Color.fromARGB(255, 235, 234, 234),
                //     borderRadius: BorderRadius.circular(12.0),
                //     boxShadow: [
                //       BoxShadow(
                //         color: Colors.grey.withOpacity(0.5),
                //         spreadRadius: 2,
                //         blurRadius: 7,
                //         offset: Offset(0, 3), // changes position of shadow
                //       ),
                //     ],
                //   ),
                //   child: Column(
                //     children: [
                //       Padding(
                //         padding: const EdgeInsets.only(right: 200, top: 15),
                //         child: Container(
                //           child: Text(
                //             "Message",
                //             style: TextStyle(),
                //           ),
                //         ),
                //       ),
                //       Container(
                //         child: Opacity(
                //           opacity: 0.6,
                //           child: Container(
                //             width: 266,
                //             margin: EdgeInsets.only(right: 2, top: 10),
                //             child: Text(
                //               "In publishing and graphic design, Lorem \nipsum is a placeholder text commonly used \nto demonstrate the visual form…",
                //               maxLines: 3,
                //               overflow: TextOverflow.ellipsis,
                //               style: TextStyle(),
                //             ),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 156,
            child: Container(
              width: 70, // Adjust size
              height: 70, // Adjust size
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Color.fromARGB(255, 255, 255, 255), // Border color
                  width: 4.0, // Border width
                ),
              ),
              child: CircleAvatar(
                radius: 55, // Half the width/height minus the border width
                backgroundColor: Color.fromARGB(255, 255, 255, 255),
                child: CCAvatar(
                  senderName: userInfo.fullName,
                  radius: 40,
                  fontSize: 22,
                ),
              ),
            ),
          ),
          Positioned(
            child: Container(
              margin: EdgeInsets.only(
                  top: 145,
                  left: 15,
                  right: 15), // Adjust this to position the box
              padding: EdgeInsets.all(16.0),
              width: 350,
              height: 495,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              // child: Column(
              //   mainAxisSize: MainAxisSize.min,
              //   children: [
              //     // Padding(
              //     //   padding: const EdgeInsets.all(8.0),
              //     //   child: CCAvatar(
              //     //     senderName: userInfo.fullName,
              //     //     radius: 40,
              //     //     fontSize: 22,
              //     //   ),
              //     // ),
              //     CustomTextField(
              //       labelText: 'Required Field',
              //       controller: _controller,
              //       validator: (value) {
              //         if (value == null || value.isEmpty) {
              //           return 'This field is required';
              //         }
              //         return null;
              //       },
              //     ),
              //     const SizedBox(height: spacingHeight),
              //     CustomTextField(
              //       labelText: 'Required Field',
              //       controller: _controller,
              //       validator: (value) {
              //         if (value == null || value.isEmpty) {
              //           return 'This field is required';
              //         }
              //         return null;
              //       },
              //     ),
              //     const SizedBox(height: spacingHeight),
              //     CustomTextField(
              //       labelText: 'Required Field',
              //       controller: _controller,
              //       validator: (value) {
              //         if (value == null || value.isEmpty) {
              //           return 'This field is required';
              //         }
              //         return null;
              //       },
              //     ),
              //     // IntlPhoneField(
              //     //   decoration: InputDecoration(
              //     //     icon: const Icon(Icons.smartphone, color: Colors.blue),
              //     //     helperText: language.myaccount_mobile,
              //     //   ),
              //     //   initialValue: userInfo.mobileNo,
              //     //   initialCountryCode: userInfo.countryCode,
              //     //   onChanged: (phone) {
              //     //     log(phone.completeNumber);
              //     //   },
              //     // ),
              //     const SizedBox(height: spacingHeight),
              //     CustomTextField(
              //       labelText: 'Required Field',
              //       controller: _controller,
              //       validator: (value) {
              //         if (value == null || value.isEmpty) {
              //           return 'This field is required';
              //         }
              //         return null;
              //       },
              //     ),
              //     // IntlPhoneField(
              //     //   decoration: InputDecoration(
              //     //     icon: const Icon(Icons.phone, color: Colors.blue),
              //     //     helperText: language.myaccount_landline,
              //     //   ),
              //     //   initialCountryCode: userInfo.countryCode,
              //     //   onChanged: (phone) {
              //     //     log(phone.completeNumber);
              //     //   },
              //     // ),
              //     const SizedBox(height: spacingHeight),
              //     CustomTextField(
              //       labelText: 'Required Field',
              //       controller: _controller,
              //       validator: (value) {
              //         if (value == null || value.isEmpty) {
              //           return 'This field is required';
              //         }
              //         return null;
              //       },
              //     ),

              //     Container(
              //       child: Opacity(
              //         opacity: 0.6,
              //       ),
              //     ),
              //   ],
              // ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: spacingHeight),
                    _AccountFormField(
                      hintText: language!.myaccount_firstname_placeholder,
                      helperText: language.myaccount_firstname,
                      initialValue: userInfo.firstName,
                      icon: Icons.person,
                    ),
                    const SizedBox(height: spacingHeight),
                    _AccountFormField(
                      hintText: language.myaccount_lastname_placeholder,
                      helperText: language.myaccount_lastname,
                      initialValue: userInfo.lastName,
                      icon: Icons.person,
                    ),
                    const SizedBox(height: spacingHeight),
                    IntlPhoneField(
                      decoration: InputDecoration(
                        //icon: const Icon(Icons.smartphone, color: Colors.blue),
                        helperText: language.myaccount_mobile,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        prefix: Icon(Icons.smartphone, color: Colors.blue),
                      ),
                      initialValue: userInfo.mobileNo,
                      initialCountryCode: userInfo.countryCode,
                      onChanged: (phone) {
                        log(phone.completeNumber);
                      },
                      // onChanged: (phone) {
                      //   print(phone
                      //       .completeNumber); // Output complete phone number
                      // },
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return 'Please enter your phone number';
                      //   }
                      //   return null;
                      // },
                    ),
                    const SizedBox(height: spacingHeight),
                    IntlPhoneField(
                      decoration: InputDecoration(
                        //icon: const Icon(Icons.phone, color: Colors.blue),
                        helperText: language.myaccount_landline,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              10.0), // Customize border radius
                        ),
                        prefix: Icon(Icons.phone, color: Colors.blue),
                      ),
                      initialCountryCode: userInfo.countryCode,
                      onChanged: (phone) {
                        log(phone.completeNumber);
                      },
                      // onChanged: (phone) {
                      //   print(phone
                      //       .completeNumber); // Output complete phone number
                      // },
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return 'Please enter your phone number';
                      //   }
                      //   return null;
                      // },
                    ),
                    const SizedBox(height: spacingHeight),
                    _AccountFormField(
                      initialValue: userInfo.primaryEmail,
                      //icon: Icons.email,
                      icon: Icons.email,
                      helperText: language.myaccount_email,
                      isEnabled: false,
                    ),
                  ],
                ),
              ),
            ),

            // Padding(
            //   padding: const EdgeInsets.only(top: 645),
            //  // child: CCButton(language!.btn_label_save, onPressed: () {}),
            //  child: ElevatedButton(
            //     onPressed: () {
            //       if (_formKey.currentState!.validate()) {
            //         ScaffoldMessenger.of(context).showSnackBar(
            //           SnackBar(content: Text('Processing Data')),
            //         );
            //       }
            //     },
            //     child: Text('Submit'),
            //   ),
            // ),
          ),
          //SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(top: 625),
            child: CCButton(language.btn_label_save, onPressed: () {}),
          ),
        ],
      ),
    );
  }
}

class _AccountFormField extends StatelessWidget {
  // final String labelText;
  // final TextEditingController controller;
  // final String? Function(String?)? validator;
  // final IconData icon;

  const _AccountFormField({
    Key? key,
    required this.helperText,
    this.hintText = '',
    this.initialValue = '',
    required this.icon,
    this.isEnabled = true,
  }) : super(key: key);

  final String helperText;
  final String? hintText;
  final IconData icon;
  final bool isEnabled;
  final String initialValue;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.8,
      child: TextFormField(
        initialValue: initialValue,
        enabled: isEnabled,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(10.0), // Customize border radius
          ),
          prefixIcon: Icon(
            icon,
            // color: Color(0xff1E60AA),
            color: Colors.blue,
          ),
          contentPadding: EdgeInsets.all(16.0), // Padding inside the border
        ),
        // helperText: "$helperText *",
      ),
    );
  }
}
