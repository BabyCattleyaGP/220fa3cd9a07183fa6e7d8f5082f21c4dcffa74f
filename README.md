# FLUTTER PROJECT

## Description

Flutter project for preliminary test.
- Features : 
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
- [font_awesome_flutter](https://pub.dev/packages/font_awesome_flutter) version 8.8.1, enable to use font awesome icon
- [grouped_list](https://pub.dev/packages/grouped_list) version 3.1.0, flutter ListView in which list items can be grouped to sections
- [intl](https://pub.dev/packages/intl) version 0.16.1 for formatting number
- [http](https://pub.dev/packages/http) version 0.12.1 for http method resource
- [query_params](https://pub.dev/packages/query_params) version 0.6.1 for URL Parameters
- [shared_preferences](https://pub.dev/packages/shared_preferences) version 0.5.7+3 providing a persistent store for local data
- [table_calendar](https://pub.dev/packages/table_calendar) version 2.2.3 for scrollable calendar widget 

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

## To Do

Product List Screen
- [ ] Date Picker
  - [X] Date Picker displays the current week until 8th week.
  - [X] Displayed week can be changed by sliding or clicking on the arrow button
  - [X] Saturdays and Sundays are disabled.
  - [X] Pinned when scrolled 
  - [ ] Refinement
- [ ] Product List
  - [ ] The list must be lazy loaded 
    - [X] Displayed but not lazy loaded 
  - [X] Add product to cart by clicking “Tambah ke keranjang”
  - [X] Quantity can be edited after product added to cart
  - [X] Changing quantity to 0 removes product from cart
  - [X] Cart button displayed if there is an item in cart
- [ ] Cart Button
  - [X] Total item & price displayed changes according to cart content
  - [X] Clicking the button will navigate to Cart Screen
  - [ ] Refinement

Cart Screen
- [ ] Cart Item List
  - [ ] List is order by item date, then by product id
  - [ ] Item quantity can be edited (minimum 1)
  - [ ] Changing quantity here also changes quantity in Product List screen
  - [ ] Clicking trash icon removes the item from cart
  - [ ] Clicking “Hapus Pesanan” will empty the cart and showing the empty screen
  - [ ] Use any image for empty screen
- [ ] Checkout Button
  - [ ] Total item & price displayed changes according to cart content
  - [ ] Clicking the button will navigate back to Product List Screen
