import 'package:crises_control/src/core/presentation/widgets/cc_alert_dialog.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CCError extends Equatable {
  const CCError({
    this.errorTitle = 'An error occured',
    this.errorId = 'e003',
    this.errorMessage = 'There was a problem processing your request.',
  });

  final String errorId;
  final String errorTitle;
  final String errorMessage;

  @override
  List<Object?> get props => [errorId, errorTitle, errorMessage];
  static const noConnectivityError = CCError(
    errorTitle: 'No Connectivity',
    errorMessage: 'E001',
  );
  static const unauthorisedError = CCError(
    errorId: 'E004',
    errorTitle: 'The system requires to re-confirm your identity',
    errorMessage: 'Please login again',
  );
  static const incorrectCredentials = CCError(
    errorId: 'e009',
    errorTitle: 'Incorrect Credentials',
    errorMessage: 'Your username or password is incorrect for this company.',
  );

  static CCAlertDialog displayErrorAlert(CCError error, BuildContext context) {
    var language = AppLocalizations.of(context);
    String? title = language!.e003;
    String? description = '';

    switch (error.errorTitle) {
      case 'The system requires to re-confirm your identity':
        title = null;
        description = language.e004;
        break;
      case 'Company not found':
        title = language.e220;
        description = language.e136;
        break;
      case 'No Connectivity':
        title = language.no_connectivity;
        description = language.e001;
        break;
      case 'Customer ID is required':
        title = language.customer_id_required;
        description = language.enter_customer_id;
        break;
      case 'Login Failure':
        title = language.login_failure;
        description = language.e009;
        break;
      case 'Message Required':
        title = language.message_can_not_be_empty;
        description = language.please_add_a_message_to_send_a_ping;
        break;
      default:
        title = language.error_occured;
        description = language.e003;
    }
    return CCAlertDialog(
      title: title,
      description: description,
      actions: const [
        OkAlertButton(),
      ],
    );
  }

  CCAlertDialog displayErrorAlerts(BuildContext context) {
    var language = AppLocalizations.of(context);
    String? title = language!.e003;
    String? description = '';

    switch (errorTitle) {
      case 'The system requires to re-confirm your identity':
        title = null;
        description = language.e004;
        break;
      case 'Company not found':
        title = language.e220;
        description = language.e136;
        break;
      case 'No Connectivity':
        title = language.no_connectivity;
        description = language.e001;
        break;
      case 'Customer ID is required':
        title = language.customer_id_required;
        description = language.enter_customer_id;
        break;
      case 'Login Failure':
        title = language.login_failure;
        description = language.e009;
        break;
      case 'Incorrect Credentials':
        title = language.inncorrect_credentials;
        description = language.e009;
        break;
      case 'Message Required':
        title = language.message_can_not_be_empty;
        description = language.please_add_a_message_to_send_a_ping;
        break;
      default:
        title = language.error_occured;
        description = language.e003;
    }
    return CCAlertDialog(
      title: title,
      description: description,
      actions: const [
        OkAlertButton(),
      ],
    );
  }
}
