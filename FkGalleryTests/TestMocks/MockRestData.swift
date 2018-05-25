//
//  MockRestData.swift
//  FkGalleryTests
//
//  Created by bogdan on 2018-05-23.
//  Copyright © 2018 BoulderTechs. All rights reserved.
//

import Foundation
import XCTest
import SwiftyJSON

class MockRestData {
    static let testHost = "api.flickr.com"
    
    static func getTestData() -> Data? {
        let bundle = Bundle.allBundles.filter() { $0.bundlePath.hasSuffix(".xctest") }.first
        guard let testBundle = bundle else { return nil }
        
        if let url = testBundle.url(forResource: "MockResponseData", withExtension: "json") {
            if let data = try? Data.init(contentsOf: url) {
                return data
            }
        }
        
        return nil
    }
    
    static func createTestPhotoItem() -> PhotoItem? {
        guard let testData = MockRestData.getTestData() else {
            return nil
        }
        
        let json: JSON = JSON(testData)
        
        if let array = json["items"].array {
            for itemJson in array {
                let item = PhotoItemFactory.create(json: itemJson)
                return item
            }
        }
        
        return nil
    }
}
