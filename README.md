# FLUTTER PROJECT

## Description

Flutter project for preliminary test.
Feature : 
- Load product list from server.
- Add product to cart (save the cart locally, no need for backend)
- Edit & Delete the cart content
- Cart must still exist even if the app closed and reopened

## Dev Environment

* Flutter 1.17.3 [channel stable](https://github.com/flutter/flutter.git) - 2020-06-04 09:26:11
* Dart 2.8.4

## Included Packages

- [flutter_native_splash](https://pub.dev/packages/flutter_native_splash) version 0.1.9 for splashscreen
- [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons) version 0.7.3 for custom app icon
- [flutter_launcher_name](https://pub.dev/packages/flutter_launcher_name) version 0.0.1 for custom app name
- [flutter_rating_bar](https://pub.dev/packages/flutter_rating_bar) version 3.0.1+1 for rating in product's card
- [intl](https://pub.dev/packages/intl) version 0.16.1 for formatting number
- [http](https://pub.dev/packages/http) version 0.12.1 for http method resource
- [query_params](https://pub.dev/packages/query_params) version 0.6.1 for URL Parameters

## Run

* If you have existing build `flutter clean`
* To get all packages `flutter pub get`
* On terminal run `flutter run`

## Build for Deployment

Based on [Reference](https://flutter.dev/docs/deployment/android)

After creating a keystore and configure it :

* Run `flutter build appbundle` to create appbundle (Playstore)
* Run `flutter build apk` to create apk
* Run `flutter install` to install app on device
