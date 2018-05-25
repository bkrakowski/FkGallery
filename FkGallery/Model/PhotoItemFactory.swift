//
//  PhotoItemFactory.swift
//  FkGallery
//
//  Created by bogdan on 2018-05-22.
//  Copyright © 2018 BoulderTechs. All rights reserved.
//

import Foundation
import SwiftyJSON

class PhotoItemFactory {
    
    private static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    } ()
    
    class func create(json: JSON) -> PhotoItem {
        // e.g. "2018-04-21T12:51:54-08:00",
        var dateTaken = dateFormatter.date(from: json["date_taken"].cleanString)
        // This format needs DST fix?
        dateTaken?.addTimeInterval(-(TimeZone.current.daylightSavingTimeOffset()))
        // e.g. "2018-05-23T22:59:08Z"
        let datePublished = dateFormatter.date(from: json["published"].cleanString)
        
        let item = PhotoItemImpl(
            title: json["title"].cleanString,
            link: json["link"].cleanString,
            linkSmall: json["media"]["m"].cleanString,
            dateTaken: dateTaken,
            description: json["description"].cleanString,
            published: datePublished,
            author: json["author"].cleanString,
            authorId: json["author_id"].cleanString,
            tags: json["tags"].cleanString
        )
    
        return item
    }
}

