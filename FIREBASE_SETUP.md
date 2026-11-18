# Firebase Authentication setup

The authentication screens and Firebase Auth calls are implemented, but this project does not contain Firebase project credentials yet. The temporary `lib/firebase_options.dart` keeps the app buildable and is replaced by FlutterFire's generated configuration.

1. Open the Firebase Console and create or select the Firebase project for CreateHub.
2. In **Authentication → Sign-in method**, enable **Email/Password**.
3. In the project root, run `dart pub global activate flutterfire_cli` if the FlutterFire CLI is not installed.
4. Run `flutterfire configure` and select the platforms used by CreateHub. It generates `lib/firebase_options.dart` and registers the selected apps.
5. Run `flutter pub get`, then `flutter run`.

The app can still open before setup. If a user opens an auth screen before Firebase is linked, it displays a localized setup message instead of crashing. For production, keep Firebase security rules and account settings configured in the Firebase Console.

## Feature structure

```text
lib/features/auth/
  data/
    datasources/firebase_auth_data_source.dart
    repositories/auth_repository_impl.dart
  domain/
    entities/auth_user.dart
    failures/auth_failure.dart
    repositories/auth_repository.dart
    usecases/{sign_in,register_account,send_password_reset}.dart
  presentation/
    cubit/{auth_cubit,auth_state}.dart
    pages/{login_screen,register_screen,forgot_password_screen}.dart
    widgets/{auth_page_scaffold,auth_text_field}.dart
```

The presentation layer validates input and renders localized state. The domain layer contains the app user, repository contract, and use cases. The data layer translates Firebase results into the domain model. GetIt wires the layers in `lib/config/di/di.dart`; GoRouter exposes the pages, reachable from the Profile tab.
