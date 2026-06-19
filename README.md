# GMEXT-MLKit
Repository for GameMaker's ML Kit Extension

This repository was created with the intent of presenting users with the latest version available of the extension (even previous to marketplace updates) and also provide a way for the community to contribute with bug fixes and feature implementation.

ML Kit brings Google's machine learning expertise to mobile developers in a powerful and easy-to-use package, with on-device APIs for text translation and language identification.

This extension will work on **Android** and **iOS**.

* Translation:
  * Android: `source/MLKit_gml/extensions/GMMLKit/AndroidSource/Java/`
  * iOS: `source/MLKit_gml/extensions/GMMLKit/source/src/ios/`
* Language Identification:
  * Android: `source/MLKit_gml/extensions/GMMLKitLanguageIdentification/AndroidSource/Java/`
  * iOS: `source/MLKit_gml/extensions/GMMLKitLanguageIdentification/source/src/ios/`

## Requirements

This extension only runs on Android and iOS; on other platforms the functions are no-ops.

Language models are downloaded on demand at runtime, so a network connection is required the first time a given translation model is used.

> [!IMPORTANT]
> To build for iOS you need CocoaPods installed on your system. If it is not present it is installed automatically when building from the IDE or command line. If you prefer to use your own installation of CocoaPods, make sure it is installed correctly in `sudoless` mode and available through the command line.

## Documentation

* Check [the documentation](../../wiki)

The online documentation is regularly updated to ensure it contains the most current information. For those who prefer a different format, we also offer a HTML version. This HTML is directly converted from the GitHub Wiki content, ensuring consistency, although it may follow slightly behind in updates.

We encourage users to refer primarily to the GitHub Wiki for the latest information and updates. The HTML version, included with the extension and within the demo project's data files, serves as a secondary, static reference.

Additionally, if you're contributing new features through PR (Pull Requests), we kindly ask that you also provide accompanying documentation for these features, to maintain the comprehensiveness and usefulness of our resources.
