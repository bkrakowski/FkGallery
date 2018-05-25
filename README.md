# FkGallery
This simple/sample Swift 4.1 app previews Public Flickr Photo Feed. The code demonstrates VIPER with KVO pattern. 

## Summary
This sample app uses Flickr public image feed API https://www.flickr.com/services/feeds/docs/photos_public and displays the results. This API returns 20 latest published feeds.

## Features:
1. Display (in a table view) images previews with some image's meta data.
2. Provide image detail view with ability to open the original image in flicker safari page, and save image to user's photo library.
3. Search images by images' Tags.
4. Refresh feeds by the refresh control.

## Notes:
1. Implementation inspired by the VIPER pattern (View, Interactor as PhotosServiceAPI, Presenter, and Router as the Wire) with a twist: the presenter is not updating the views directly, but exposes the data source as KVO observable. 
Alternatively instead of  the KVO, RxCocoa and RxSwift could have been used instead. 
2. Image caching is provided by taking advantage of AlamofireImage pod.
3. Provided Unit Tests for the functionality, and UI Unit Tests for testing the full app with the UI layer.

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

Then, reopen the FkGallery solution file. 

## License

FkGallery is released under the MIT license.
