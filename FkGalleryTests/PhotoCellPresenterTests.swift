//
//  PhotoCellPresenterTests.swift
//  FkGalleryTests
//
//  Created by bogdan on 2018-05-24.
//  Copyright © 2018 BoulderTechs. All rights reserved.
//

import XCTest

class PhotoCellPresenterTests: XCTestCase {
    let photoCellPresenter = PhotoCellPresenterImpl()
    
    var photoUrl: String?
    var photoTitle: NSAttributedString?
    var photoAuthor: NSAttributedString?
    var photoTags: NSAttributedString?
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCellPresenter() {
        guard let item = MockRestData.createTestPhotoItem() else {
            XCTAssert(false)
            return
        }
        
        photoCellPresenter.formatCell(cellView: self, item: item)
        
        XCTAssert(photoUrl != nil)
        XCTAssert(photoTitle != nil)
        XCTAssert(photoAuthor != nil)
        XCTAssert(photoTags != nil)
        
        XCTAssert(photoUrl == "https://farm1.staticflickr.com/944/27414413197_0bf8b74e67_m.jpg")
        XCTAssert(photoTitle?.string == "P5202148-Edit.jpg")
        XCTAssert(photoTags?.string == "Tags\nbike")
        XCTAssert(photoAuthor?.string == "Author\nmarius.vochin")
    }
}

extension PhotoCellPresenterTests: PhotoCellView {
    func updateImage(url: String?) {
        photoUrl = url
    }
    
    func updateTitleLabel(text: NSAttributedString?) {
        photoTitle = text
    }
    
    func updateAuthorLabel(text: NSAttributedString?) {
        photoAuthor = text
    }
    
    func updateTagsLabel(text: NSAttributedString?) {
        photoTags = text
    }
    
    func updatePublishedDate(date: Date?) {
        
    }
}
