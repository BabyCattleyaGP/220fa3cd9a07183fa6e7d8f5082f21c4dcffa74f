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
-

## Run

* If you have existing build `flutter clean`
* To get all packages `flutter pub get`
* On terminal run `flutter run`

## Build for Deployment

Based on [Reference] (https://flutter.dev/docs/deployment/android)

After creating a keystore and configure it :

* Run `flutter build appbundle` to create appbundle (Playstore)
* Run `flutter build apk` to create apk
* Run `flutter install` to install app on device
