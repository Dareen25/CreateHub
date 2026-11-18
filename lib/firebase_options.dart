// This temporary scaffold keeps the app buildable before Firebase is linked.
// Run `flutterfire configure` from the project root to replace this file with
// the options generated for your Firebase project.
import 'package:firebase_core/firebase_core.dart';

abstract final class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform => throw UnsupportedError(
    'Run `flutterfire configure` to generate Firebase platform options.',
  );
}
