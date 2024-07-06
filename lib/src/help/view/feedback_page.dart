import 'package:crises_control/src/CustomAppbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FeedbackPage extends StatelessWidget {
  const FeedbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    final language = AppLocalizations.of(context);
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CustomHeader(title: language!.title_feedback),
          ),
          Positioned(
            top: 150, // Adjust to control the overlap
            left: 16,
            right: 16,
            bottom: 0,
            child: FeedbackBody(language: language),
          ),
        ],
      ),
    );
  }
}

class FeedbackBody extends StatelessWidget {
  FeedbackBody({super.key, required this.language});
  final AppLocalizations language;
  final TextEditingController _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4.0,
      borderRadius: BorderRadius.circular(16.0),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            Text(
              language.label_description_send_feedback,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              child: FeedbackTextField(controller: _controller),
            ),
            const Spacer(),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                  backgroundColor:
                      const Color(0xFF024D85), // button background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Handle form submission
                  }
                },
                child: Text(
                  language.btn_label_send_feedback,
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20), // space from bottom
          ],
        ),
      ),
    );
  }
}

class FeedbackTextField extends StatelessWidget {
  const FeedbackTextField({
    Key? key,
    required TextEditingController controller,
  })  : _controller = controller,
        super(key: key);

  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: true,
      controller: _controller,
      textAlign: TextAlign.start,
      textInputAction: TextInputAction.done,
      textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.text,
      maxLength: 200,
      maxLines: 8, // adjusted maxLines for a better fit
      validator: (value) => value?.isEmpty ?? true ? 'Cannot be empty' : null,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.blue),
        ),
        hintText: AppLocalizations.of(context)?.enter_message,
        contentPadding:
            const EdgeInsets.all(16.0), // Add padding inside the text field
      ),
    );
  }
}
