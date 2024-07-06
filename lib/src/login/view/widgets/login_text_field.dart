import 'package:crises_control/src/core/constants.dart';
import 'package:crises_control/src/core/utils/validation/text_validation.dart';
import 'package:flutter/material.dart';

class LoginTextField extends StatefulWidget {
  final String suggestionText;
  final String labelText;
  final TextEditingController textEditingController;
  final FocusNode textEntryFocusNode;
  final bool readOnly;
  final FormFieldValidator<String>? validator;

  const LoginTextField({
    //   super.key,
    //   required TextEditingController textEditingController,
    //   required FocusNode textEntryFocusNode,
    //   required this.labelText,
    //   this.suggestionText = 'Enter your unique ID',
    //   this.readOnly = false,
    //   FormFieldValidator<String>? validator,
    // })  : _customerIdTextEntry = textEditingController,
    //       _customerIdTextEntryFocusNode = textEntryFocusNode,
    //       _validator = validator;

    // final TextEditingController _customerIdTextEntry;
    // final FocusNode _customerIdTextEntryFocusNode;
    // final String labelText;
    // final bool readOnly;
    // final FormFieldValidator<String>? _validator;
    Key? key,
    required this.textEditingController,
    required this.textEntryFocusNode,
    required this.labelText,
    this.suggestionText = 'Enter your unique ID',
    this.readOnly = false,
    this.validator,
  }) : super(key: key);

  @override
  State<LoginTextField> createState() => _LoginTextFieldState();
}

// class _LoginTextFieldState extends State<LoginTextField> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20.0),
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           widget.labelText,
//           style: const TextStyle(
//             fontSize: 16.0,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 8.0),
//         TextFormField(
//           controller: widget.textEditingController,
//           focusNode: widget.textEntryFocusNode,
//           readOnly: widget.readOnly,
//           decoration: InputDecoration(
//             hintText: widget.suggestionText,
//             border: const OutlineInputBorder(),
//           ),
//           validator: widget.validator,
//         ),
//       ],
//     );
//     );
//   }
//   // return Container(
//   //   padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
//   //   child: TextFormField(
//   //     controller: widget._customerIdTextEntry,
//   //     decoration: InputDecoration(
//   //       border: OutlineInputBorder(
//   //         borderRadius: BorderRadius.circular(
//   //           UIConstants.defaultCornerRadius,
//   //         ),
//   //       ),
//   //       labelText: widget.labelText,
//   //     ),
//   //     focusNode: widget._customerIdTextEntryFocusNode,
//   //     autovalidateMode: AutovalidateMode.onUserInteraction,
//   //     validator:
//   //         widget._validator ?? (text) => TextValidator.canNotBeEmpty(text),
//   //     readOnly: widget.readOnly,
//   //     autocorrect: false,
//   //   ),
//   // );
// }

class _LoginTextFieldState extends State<LoginTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.labelText,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          TextFormField(
            controller: widget.textEditingController,
            focusNode: widget.textEntryFocusNode,
            readOnly: widget.readOnly,
            decoration: InputDecoration(
              hintText: widget.suggestionText,
              // border: const OutlineInputBorder(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  UIConstants.defaultCornerRadius,
                ),
              ),
            ),
            validator: widget.validator,
          ),
        ],
      ),
    );
  }
}
