# expense_tracker

A simple expense tracker app that I did as a part of Udemy course on Flutter. It tracks all inserted expenses, displays them in a list (from the oldest to the newest) and shows a graph of total expenses by categories. The app support dark and light themes, responsive to the device orientation.


## About the project
* Written in *Dart*
* *ImagePicker* package is used to make photos with the camera
* *GoogleMaps* is used to work with maps
* Data is stored locally with the help of *Sqflite*

## Functionality
* Add and remove favorite places from the list
* Each place has a name, an image (taken via phone camera) and a geolocation (set manually or automatically)

## Installation
* Prerequesites (crazy amount): Android Studio, Android SDK, Android SDK Tools, NDK, Android SDK Command Line Tools, CMake, Adroid Emulator, JDK, git, VS Code Dart and Flutter plugins
* With `flutter doctor -v` you can check wether all requirements are met
* Clone the repo. Bette to kep the original name (otherwise you need to edit imports)
* Run `flutter pub get` to install all dependencies
* Create *.env* and add your `GOOGLE_API_KEY` to enable Google Maps module
* Execute `flutter run` to launch the app

## Demo
<img src="https://github.com/baltsaros/expense_tracker/blob/main/expense_tracker_demo.gif" height="600" alt="Shopping list demo">

## Links
* [Udemy coures](https://campus19.udemy.com/course/learn-flutter-dart-to-build-ios-android-apps/)
