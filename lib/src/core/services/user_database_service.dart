//This database is responsible for storing user data
import 'package:crises_control/src/core/models/crises_control_contact.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UserDatabaseService {
  late Box<CrisesControlContact> _crisesControlContactBox;
  static const _crisesControlContactBoxKey = 'crisesControlContactKey';
  //This box is responsible
  UserDatabaseService() {
    if (!Hive.isAdapterRegistered(5)) {
      Hive.registerAdapter(CrisesControlContactAdapter());
    }
  }

  Future<void> _openContactBox() async {
    _crisesControlContactBox =
        await Hive.openBox<CrisesControlContact>(_crisesControlContactBoxKey);
  }

  Future<void> saveCrisesControlContact({
    required CrisesControlContact contact,
  }) async {
    await _openContactBox();
    await _crisesControlContactBox.deleteAll(_crisesControlContactBox.values);
    await _crisesControlContactBox.add(contact);
  }

  //retrieve the crises control contact from the database.
  Future<CrisesControlContact?> retrieveCrisesControlContact() async {
    await _openContactBox();
    try {
      return _crisesControlContactBox.values.first;
    } on StateError {
      return null;
    }
  }
}
