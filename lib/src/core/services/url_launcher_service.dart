import 'package:crises_control/src/core/errors/exceptions.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class UrlLauncherService {
  sendEmail({
    required String email,
    required String subject,
    required String body,
  }) async {
    final Uri url = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        'subject': subject,
        'body': body,
      },
    );
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw UrlLauncherException();
    }
  }

  initiateCall({required String phoneNumber}) async {
    var url = 'tel://$phoneNumber';
    if (await canLaunchUrlString(url)) {
      launchUrlString(url);
    } else {
      UrlLauncherException();
    }
  }
}
