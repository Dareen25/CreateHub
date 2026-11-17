# CreateHub

CreateHub is a Flutter marketplace starter for art supplies, DIY and maker tools, and handmade gifts. The current app is an initial themed marketplace home screen; catalog, account, cart, checkout, and seller features have not been implemented yet.

## Run locally

1. Install Flutter 3.47 or later with Dart 3.13 or later.
2. From the project directory, run `flutter pub get`.
3. Run `flutter gen-l10n` to generate the localization Dart files.
4. Run `flutter run` for a connected device or emulator.

## Project layout

- `lib/main.dart` starts the app and configures its themes, routing, and localization.
- `lib/core/` contains shared theme, routing, constants, errors, and widgets.
- `lib/config/` contains reusable networking, storage, validation, and platform service helpers.
- `lib/features/` is where marketplace screens and feature modules will be added.
- `lib/l10n/` contains English and Arabic ARB resources for Flutter localization generation.

## Before connecting services

- Set `BaseUrls.apiBaseUrl` in `lib/core/constants/api_constants/base_urls.dart` to the marketplace API.
- Add Firebase platform configuration for each target before using Firebase packages.
- Replace or remove leftover platform/plugin setup for packages the project does not use.
- Implement and register feature routes as their screens are added.

The API endpoint and Firebase project values are intentionally not supplied in this starter.
