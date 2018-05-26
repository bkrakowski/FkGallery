//
//  PhotosServiceTests.swift
//  FkGalleryTests
//
//  Created by bogdan on 2018-05-22.
//  Copyright © 2018 BoulderTechs. All rights reserved.
//

import XCTest
import OHHTTPStubs
@testable import FkGallery


class PhotosServiceTests: XCTestCase {
    var photoItems: [PhotoItem]?
    var error: Error?
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        photoItems = nil
        error = nil
        
        super.tearDown()
    }
    
    func testQueryPhotosOK() {
        guard let testData = MockRestData.getTestData() else {
            XCTAssert(false)
            return
        }
        
        stub(condition: isHost(MockRestData.testHost)) { _ in
            return OHHTTPStubsResponse(data: testData, statusCode: 200, headers:nil)
        }
        
        let expectLoaded = XCTestExpectation(description: "items loaded")
        
        let photosService = PhotosServiceImpl(restService: RestServiceImpl())
        photosService.queryPhotos(tag: nil) {
            response in
            
            switch response {
            case .success (let photoItems):
                self.photoItems = photoItems
            case .failure (let error):
                self.error = error
            }
            
            expectLoaded.fulfill()
        }
        
        wait(for: [expectLoaded], timeout: 3.0)
        
        XCTAssert(error == nil)
        XCTAssert(photoItems!.count == 2)
        let item = photoItems?.first!
        
        XCTAssert(item?.title == "P5202148-Edit.jpg")
        XCTAssert(item?.link == "https://www.flickr.com/photos/mariusvochin/27414413197/")
        XCTAssert(item?.linkSmall == "https://farm1.staticflickr.com/944/27414413197_0bf8b74e67_m.jpg")
        XCTAssert(item?.author == "marius.vochin")
        XCTAssert(item?.authorId == "52837777@N02")
        XCTAssert(item?.description == "description")
        XCTAssert(item?.tags == "bike")
        XCTAssert(item?.dateTaken != nil)
        XCTAssert(item?.published != nil)
    }
    
    func testQueryPhotosNOK() {
        guard let testData = MockRestData.getTestData() else {
            XCTAssert(false)
            return
        }
        
        stub(condition: isHost(MockRestData.testHost)) { _ in
            return OHHTTPStubsResponse(data: testData, statusCode: 400, headers: nil)
        }
        
        let expectLoaded = XCTestExpectation(description: "items loaded")
        
        let photosService = PhotosServiceImpl(restService: RestServiceImpl())
        photosService.queryPhotos(tag: nil) {
            response in
            
            switch response {
            case .success (let photoItems):
                self.photoItems = photoItems
            case .failure (let error):
                self.error = error
            }
            
            expectLoaded.fulfill()
        }
        
        wait(for: [expectLoaded], timeout: 3.0)
        
        XCTAssert(error != nil)
        XCTAssert(photoItems == nil)
    }
    
}
