//
//  PhotoGalleryPresenterTests.swift
//  FkGalleryTests
//
//  Created by bogdan on 2018-05-24.
//  Copyright © 2018 BoulderTechs. All rights reserved.
//

import XCTest
import OHHTTPStubs
@testable import FkGallery


class PhotoGalleryPresenterTests: XCTestCase {
    var photoItemsQueried: PhotoItemsQueried?
    var photoGalleryPresenter: PhotoGalleryPresenter?
    var disposeBag: [NSKeyValueObservation] = []
    
    override func setUp() {
        super.setUp()
        
        let photosService = PhotosServiceImpl(restService: RestServiceImpl())
        photoGalleryPresenter = PhotoGalleryPresenterImpl(photosService: photosService)
    }
    
    override func tearDown() {
        photoGalleryPresenter = nil
        
        super.tearDown()
    }
    
    func mockPresenterForRest(statusCode: Int = 200) {
        guard let testData = MockRestData.getTestData() else {
            XCTAssert(false)
            return
        }
        
        stub(condition: isHost(MockRestData.testHost)) { _ in
            return OHHTTPStubsResponse(data: testData, statusCode: Int32(statusCode), headers: nil)
        }
    }
    
    func testPhotoItemsLoading() {
        mockPresenterForRest()
        
        guard let presenter = photoGalleryPresenter else {
            XCTAssert(false)
            return
        }
        
        let expectLoaded = XCTestExpectation(description: "items loaded")
        
        typealias targetType = PhotoItemsSourceObservable
        
        disposeBag.append(presenter.photoItemsSource.observe(\targetType.photoItemsQueried, options: [.new]) { [weak self] (target, change) in
            if let newValue = change.newValue {
                self.photoItemsQueried = newValue
                if newValue.state == .ready {
                    expectLoaded.fulfill()
                }
            }
        })
        
        presenter.queryPhotoItems(searchText: nil, asLazySearch: false)
        
        wait(for: [expectLoaded], timeout: 3.0)
        
        XCTAssert(photoItemsQueried != nil)
        XCTAssert(photoItemsQueried!.error == nil)
        XCTAssert(photoItemsQueried!.photoItems.count == 2)
        
        XCTAssert(presenter.photoItemsSource.photoItemsQueried.photoItems.count == 2)
        XCTAssert(presenter.photoItemsSource.photoItemsQueried.error == nil)
        XCTAssert(presenter.photoItemsSource.photoItemsQueried.state == .ready)
    }
    
    func testPhotoItemsSearching() {
        mockPresenterForRest()
        
        guard let presenter = photoGalleryPresenter else {
            XCTAssert(false)
            return
        }
        
        let expectLoaded = XCTestExpectation(description: "items loaded")
        
        typealias targetType = PhotoItemsSourceObservable
        
        disposeBag.append(presenter.photoItemsSource.observe(\targetType.photoItemsQueried, options: [.new]) { [weak self] (target, change) in
            if let newValue = change.newValue {
                self.photoItemsQueried = newValue
                if newValue.state == .ready {
                    expectLoaded.fulfill()
                }
            }
        })
        
        presenter.queryPhotoItems(searchText: "test", asLazySearch: true)
        presenter.queryPhotoItems(searchText: "test", asLazySearch: true)
        presenter.queryPhotoItems(searchText: "test", asLazySearch: true)
        
        wait(for: [expectLoaded], timeout: 3.0)
        
        XCTAssert(photoItemsQueried != nil)
        XCTAssert(photoItemsQueried!.error == nil)
        XCTAssert(photoItemsQueried!.photoItems.count == 2)
        
        XCTAssert(presenter.photoItemsSource.photoItemsQueried.photoItems.count == 2)
        XCTAssert(presenter.photoItemsSource.photoItemsQueried.error == nil)
        XCTAssert(presenter.photoItemsSource.photoItemsQueried.state == .ready)
    }
    
    func testPhotoItemsLoadingFailed() {
        mockPresenterForRest(statusCode: 404)
        
        guard let presenter = photoGalleryPresenter else {
            XCTAssert(false)
            return
        }
        
        let expectLoaded = XCTestExpectation(description: "items loaded")
        
        typealias targetType = PhotoItemsSourceObservable
        
        disposeBag.append(presenter.photoItemsSource.observe(\targetType.photoItemsQueried, options: [.new]) { [weak self] (target, change) in
            if let newValue = change.newValue {
                self.photoItemsQueried = newValue
                if newValue.state == .ready {
                    expectLoaded.fulfill()
                }
            }
        })
        
        presenter.queryPhotoItems(searchText: nil, asLazySearch: false)
        
        wait(for: [expectLoaded], timeout: 3.0)
        
        XCTAssert(photoItemsQueried != nil)
        XCTAssert(photoItemsQueried!.error != nil)
        XCTAssert(photoItemsQueried!.photoItems.count == 0)
        
        XCTAssert(presenter.photoItemsSource.photoItemsQueried.photoItems.count == 0)
        XCTAssert(presenter.photoItemsSource.photoItemsQueried.error != nil)
        XCTAssert(presenter.photoItemsSource.photoItemsQueried.state == .ready)
    }
}
