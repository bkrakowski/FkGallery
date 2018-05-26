# FkGallery
This simple sample Swift 4.1 app previews Public Flickr Photo Feed. The code demonstrates VIPER with KVO pattern. 

## Summary
This sample app uses Flickr public image feed API https://www.flickr.com/services/feeds/docs/photos_public and displays the 20 latest published feeds.

## Features
1. Displays (in table view) image previews with selected image meta data.
2. Provides image detail view with the ability to open the original image link in flickr safari page, and saves image to user's photo library.
3. Searches images by image Tags.
4. Filter images by author.
5. Refreshes feeds via the refresh control.

## Notes
1. Implementation inspired by the VIPER pattern (View, Interactor as PhotosServiceAPI, Presenter, Entity, and Router as the Wire) with a twist: the presenter is not updating the views directly, but exposes the data source as KVO observable. 
Alternatively instead of  the KVO, RxCocoa and RxSwift could have been used. 
2. Image caching provided by taking advantage of AlamofireImage pod.
3. Unit Tests implemented for the functionality tests, and UI Tests implemented for testing the full app with the view layer.

## Requirements

- iOS 11.3+ 
- Xcode 9.3+
- Swift 4.1+

## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

> CocoaPods 1.1+ is required to build FkGallery+.

Then, run the following command in the project root directory:

```bash
$ pod install
```

Then, reopen the FkGallery workspace file. 

## Usage
1. Open ./FkGallery.xcworkspace in xcode. Build and run on a device or simulator, and/or
2. Visit ./fastlane/README.md to run all the tests via the command line

## License

FkGallery is released under the MIT license.
