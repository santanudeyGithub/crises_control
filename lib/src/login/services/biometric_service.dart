import 'package:local_auth/local_auth.dart';

///This class provides service for biometric authentication
class BiometricService {
  BiometricService();

  static final LocalAuthentication _auth = LocalAuthentication();

  ///Check if device is capable of checking biometrics
  Future<bool> checkBiometrics() async {
    try {
      return await _auth.canCheckBiometrics;
    } on Exception {
      return false;
    }
  }

  ///Authenticates the user with biometrics available on the device while also allowing the user to use device authentication - pin, pattern, passcode.
  Future<bool> authenticate() async {
    return await _auth.authenticate(
      localizedReason: 'Authenticate to login',
      options: const AuthenticationOptions(
        stickyAuth: true,
      ),
    );
  }

  ///Cancels any in-progress authentication, returning true if auth was cancelled successfully.
  Future<bool> cancelAuthentication() async {
    try {
      return await _auth.stopAuthentication();
    }
    on Exception {
      return false;
    }
  }

}
