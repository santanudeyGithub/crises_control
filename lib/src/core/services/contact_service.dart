// ignore_for_file: unused_local_variable

import 'package:crises_control/src/core/models/crises_control_contact.dart';
import 'package:crises_control/src/core/services/user_database_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:http/http.dart' as http;

class ContactService {
  ContactService(this._userDatabaseService);
  final UserDatabaseService _userDatabaseService;

  Future<void> addCrisesControlContact({
    required String displayName,
    required List<String> phoneNumbers,
    required String phoneContactLogoUrl,
  }) async {
    var contactInHive =
        await _userDatabaseService.retrieveCrisesControlContact();
    if (contactInHive != null) {
      var contact = Contact(id: contactInHive.id);

      if (displayName != contactInHive.displayName) {
        contact.displayName = displayName;
        contact.name = Name(first: displayName);
        await contact.update();
      }

      if (listEquals(contactInHive.phoneNumbers, phoneNumbers)) {
        contact.phones = phoneNumbers.map((e) => Phone(e)).toList();
        await contact.update();
      }

      if (contactInHive.phoneContactLogoUrl != phoneContactLogoUrl) {
        contact.photo = await _urlToPhoneContactLogo(
          phoneContactLogoUrl: phoneContactLogoUrl,
        );
        await contact.update();
      }

      _userDatabaseService.saveCrisesControlContact(
        contact: CrisesControlContact(
          id: contact.id,
          displayName: displayName,
          phoneNumbers: phoneNumbers,
          phoneContactLogoUrl: phoneContactLogoUrl,
        ),
      );
      return;
    }

    //Convert the phone numbers to a list of Phone
    List<Phone> phones = phoneNumbers.map((e) => Phone(e)).toList();
    Uint8List photo =
        await _urlToPhoneContactLogo(phoneContactLogoUrl: phoneContactLogoUrl);

    final contact = Contact(
      name: Name(first: displayName),
      displayName: displayName,
      phones: phones,
      // photo: photo,
      // thumbnail: photo,
    );
    var result = await contact.insert();
    _userDatabaseService.saveCrisesControlContact(
      contact: CrisesControlContact(
        id: result.id,
        displayName: displayName,
        phoneNumbers: phoneNumbers,
        phoneContactLogoUrl: phoneContactLogoUrl,
      ),
    );
  }

  Future<Uint8List> _urlToPhoneContactLogo({
    required String phoneContactLogoUrl,
  }) async {
    http.Response response = await http.get(
      Uri.parse(phoneContactLogoUrl),
    );
    return response.bodyBytes;
  }
}
