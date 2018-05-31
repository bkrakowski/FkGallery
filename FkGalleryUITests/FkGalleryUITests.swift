//
//  FkGalleryUITests.swift
//  FkGalleryUITests
//
//  Created by bogdan on 2018-05-22.
//  Copyright © 2018 BoulderTechs. All rights reserved.
//

import XCTest

class FkGalleryUITests: XCTestCase {
    let app = XCUIApplication()
        
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    
    func testBasicScenario() {
        let cells = app.cells
        XCTAssertEqual(cells.count, 20, "found instead: \(cells.debugDescription)")
        
        let searchBars = app.searchFields
        XCTAssertEqual(searchBars.count, 1, "found instead: \(searchBars.debugDescription)")
        
        let firstCell = cells.element.firstMatch
        
        let textsCell = firstCell.staticTexts
        XCTAssertEqual(textsCell.count, 4, "found instead: \(textsCell.debugDescription)")
        
        for i in 0..<textsCell.count {
            let elem = textsCell.element(boundBy: i)
            XCTAssertTrue(elem.value != nil)
            let value = elem.value as! String
            XCTAssertTrue(value.count > 0)
        }
        
        let imagesCall = firstCell.images
        XCTAssertEqual(imagesCall.count, 1, "found instead: \(imagesCall.debugDescription)")
        
        firstCell.tap()
        
        let buttons = app.buttons
        XCTAssertEqual(buttons.count, 3, "found instead: \(buttons.debugDescription)")
        
        let images = app.images
        XCTAssertEqual(images.count, 1, "found instead: \(images.debugDescription)")
        
        let texts = app.staticTexts
        // iPhoneX gives 6 texts!
        XCTAssertTrue([5, 6].contains(texts.count), "found instead: \(texts.debugDescription)")
        
        for i in 0..<texts.count {
            let elem = texts.element(boundBy: i)
            XCTAssertTrue(elem.value != nil)
        }
        
        let back = buttons.firstMatch
        back.tap()
    }
    
    func testFollowing() {
        let cells = app.cells
        let firstCell = cells.element.firstMatch
        firstCell.tap()
        
        let buttons = app.buttons
        let follow = buttons["Follow Author"]
        
        follow.tap()
        
        let clear = buttons["Clear Author"]
        clear.tap()
    }
    
    func testOpenOriginal() {
        let cells = app.cells
        let firstCell = cells.element.firstMatch
        firstCell.tap()
        
        let buttons = app.buttons
        let open = buttons["Open Original"]
        
        open.tap()
        
        XCTAssertTrue(app.isSelected == false)
    }
    
    func testSaveImage() {
        let cells = app.cells
        let firstCell = cells.element.firstMatch
        firstCell.tap()
        
        let image = app.images.firstMatch
        image.tap()
        
        let sheets = app.sheets
        XCTAssertEqual(sheets.count, 1, "found instead: \(sheets.debugDescription)")
        
        let sheet = sheets.firstMatch
        let save = sheet.buttons.firstMatch
        
        save.tap()
        
        let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")
        if springboard.buttons.firstMatch.waitForExistence(timeout: 1) {
            let allowBtn = springboard.buttons["OK"]
            if allowBtn.exists {
                allowBtn.tap()
            }
        }
            
        XCTAssertTrue(app.alerts.firstMatch.waitForExistence(timeout: 1))
        app.alerts.buttons["OK"].tap()
    }
    
    func testSearchByTag() {
        let search = app.searchFields.firstMatch
        search.tap()
        search.typeText("Alamakota")

        sleep(1)
        
        let cells = app.cells
        // TODO: assume 4 for now...
        XCTAssertEqual(cells.count, 4, "found instead: \(cells.debugDescription)")
    }
}

