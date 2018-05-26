//
//  PhotoItemPresenterTests.swift
//  FkGalleryTests
//
//  Created by bogdan on 2018-05-24.
//  Copyright © 2018 BoulderTechs. All rights reserved.
//

import XCTest

@testable import FkGallery


class PhotoItemPresenterTests: XCTestCase {
    var photoItemPresenter: PhotoItemPresenterImpl?
    
    var photoUrl: URL?
    var photoTitle: NSAttributedString?
    var photoAuthor: NSAttributedString?
    var photoTakenDate: NSAttributedString?
    var photoPublishedDate: NSAttributedString?
    var photoTags: NSAttributedString?

    var disposeBag: [NSKeyValueObservation] = []
    
    override func setUp() {
        super.setUp()
        
        photoItemPresenter = PhotoItemPresenterImpl()
    }
    
    override func tearDown() {
        photoItemPresenter = nil

        photoUrl = nil
        photoTitle = nil
        photoAuthor = nil
        photoTakenDate = nil
        photoPublishedDate = nil
        photoTags = nil
        
        super.tearDown()
    }
    
    private func observePresenter() -> [XCTestExpectation] {
        guard let target = photoItemPresenter?.photoItemSource else {
            XCTAssert(false)
            return []
        }
        
        var expects: [XCTestExpectation] = []
        typealias targetType = PhotoItemSourceObservable
        
        let expectUrl = XCTestExpectation(description: "Url")
        expects.append(expectUrl)
        
        disposeBag.append(target.observe(\targetType.photoUrl, options: [.new]) { [weak self] (target, change) in
            if let newValue = change.newValue {
                self?.photoUrl = newValue
                expectUrl.fulfill()
            }
        })
        
        let expectTitle = XCTestExpectation(description: "Title")
        expects.append(expectTitle)
        
        disposeBag.append(target.observe(\targetType.photoTitle, options: [.new]) { [weak self] (target, change) in
            if let newValue = change.newValue {
                self?.photoTitle = newValue
                expectTitle.fulfill()
            }
        })
        
        let expectAuthor = XCTestExpectation(description: "Author")
        expects.append(expectAuthor)
        
        disposeBag.append(target.observe(\targetType.photoAuthor, options: [.new]) { [weak self] (target, change) in
            if let newValue = change.newValue {
                self?.photoAuthor = newValue
                expectAuthor.fulfill()
            }
        })
        
        let expectTaken = XCTestExpectation(description: "Taken")
        expects.append(expectTaken)
        
        disposeBag.append(target.observe(\targetType.photoTakenDate, options: [.new]) { [weak self] (target, change) in
            if let newValue = change.newValue {
                self?.photoTakenDate = newValue
                expectTaken.fulfill()
            }
        })
        
        let expectPub = XCTestExpectation(description: "Pub")
        expects.append(expectPub)
        
        disposeBag.append(target.observe(\targetType.photoPublishedDate, options: [.new]) { [weak self] (target, change) in
            if let newValue = change.newValue {
                self?.photoPublishedDate = newValue
                expectPub.fulfill()
            }
        })
        
        let expectTags = XCTestExpectation(description: "Tags")
        expects.append(expectTags)
        
        disposeBag.append(target.observe(\targetType.photoTags, options: [.new]) { [weak self] (target, change) in
            if let newValue = change.newValue {
                self?.photoTags = newValue
                expectTags.fulfill()
            }
        })
        
        return expects
    }
    
    func testPhotoItemControls() {
        guard let presenter = photoItemPresenter else {
            XCTAssert(false)
            return
        }
        
        guard let item = MockRestData.createTestPhotoItem() else {
            XCTAssert(false)
            return
        }
        
        let expects = observePresenter()
        
        photoItemPresenter?.setPhotoItem(item: item, followed: false)

        wait(for: expects, timeout: 3.0)
        
        XCTAssert(photoUrl != nil)
        XCTAssert(photoTitle != nil)
        XCTAssert(photoAuthor != nil)
        XCTAssert(photoTakenDate != nil)
        XCTAssert(photoPublishedDate != nil)
        XCTAssert(photoTags != nil)
        
        XCTAssert(presenter.canOpenLink())
        
        XCTAssert((photoUrl?.absoluteString) == "https://farm1.staticflickr.com/944/27414413197_0bf8b74e67_m.jpg")
        XCTAssert(photoTitle?.string == "P5202148-Edit.jpg")
        XCTAssert(photoAuthor?.string == "Author\nmarius.vochin")
        XCTAssert(photoTags?.string == "Tags\nbike")
        XCTAssert(photoTakenDate?.string == "Taken on\nMay 20, 2018 at 11:42:51 AM")
        XCTAssert(photoPublishedDate?.string == "Published on\nMay 22, 2018 at 12:04:25 PM")
    }
    
}
