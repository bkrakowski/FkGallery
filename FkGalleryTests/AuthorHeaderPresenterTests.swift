//
//  AuthorHeaderPresenterTests.swift
//  FkGalleryTests
//
//  Created by bogdan on 2018-05-24.
//  Copyright © 2018 BoulderTechs. All rights reserved.
//

import XCTest

class AuthorHeaderPresenterTests: XCTestCase {
    let authorHeaderPresenter = AuthorHeaderPresenterImpl()
    
    var followingTest: String?
    var authorTest: String?
    var clearEnabled: Bool?
    var onClearFollowingCalled: Bool?
    
    override func setUp() {
        super.setUp()
        
        authorHeaderPresenter.authorHeaderView = self
        authorHeaderPresenter.onClearFollowing = {
            self.onClearFollowingCalled = true
        }
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testAuthorHeaderPresenter() {
        XCTAssert(authorHeaderPresenter.getAuthorHeaderView() != nil)
        
        authorHeaderPresenter.setAuthor("test")
        XCTAssert(authorHeaderPresenter.isFollowing)
        XCTAssert(followingTest == "Filtered by")
        XCTAssert(authorTest == "test")
        XCTAssert(clearEnabled == true)
        XCTAssert(onClearFollowingCalled == nil)

        authorHeaderPresenter.clearFollowing()
        XCTAssert(authorHeaderPresenter.isFollowing == false)
        XCTAssert(followingTest == "Removing filter...")
        XCTAssert(authorTest == nil)
        XCTAssert(clearEnabled == false)
        XCTAssert(onClearFollowingCalled == true)
    }
}

extension AuthorHeaderPresenterTests: FollowingAuthorHeaderView {
    func updateFollowingLabel(text: String?) {
        followingTest = text
    }
    
    func updateAuthorLabel(text: String?) {
        authorTest = text
    }
    
    func enableClearButton(enable: Bool) {
        clearEnabled = enable
    }
}
