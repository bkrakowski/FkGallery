//
//  PhotoItem.swift
//  FkGallery
//
//  Created by bogdan on 2018-05-22.
//  Copyright © 2018 BoulderTechs. All rights reserved.
//

import Foundation

protocol PhotoItem {
    var title: String { get }
    var link: String { get }
    var linkSmall: String { get }
    var dateTaken: Date? { get }
    var description: String { get }
    var published: Date? { get }
    var author: String { get }
    var authorId: String { get }
    var tags: String { get }
}

struct PhotoItemImpl: PhotoItem {
    let title: String
    let link: String
    let linkSmall: String
    let dateTaken: Date?
    let description: String
    let published: Date?
    let author: String
    let authorId: String
    let tags: String
}

