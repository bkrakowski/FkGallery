//
//  PhotoItemWire.swift
//  FkGallery
//
//  Created by bogdan on 2018-05-22.
//  Copyright © 2018 BoulderTechs. All rights reserved.
//

import Foundation

// Wires photo item components together and the Router for scenes.
protocol PhotoItemWire: class {
    static func createPhotoItemScene(item: PhotoItem) -> PhotoItemView
}

// Abstration of the photo items view
protocol PhotoItemView: class {
}

// Photo item Presenter
protocol PhotoItemPresenter: class {
    var photoItemSource: PhotoItemSourceObservable? { get }
    
    func canOpenLink() -> Bool
    func openLink()
}

// PhotoItemSourceObservable supports KVO
class PhotoItemSourceObservable: NSObject {
    @objc dynamic var rawAuthor: String?
    @objc dynamic var photoUrl: URL?
    @objc dynamic var photoTitle: NSAttributedString?
    @objc dynamic var photoAuthor: NSAttributedString?
    @objc dynamic var photoTakenDate: NSAttributedString?
    @objc dynamic var photoPublishedDate: NSAttributedString?
    @objc dynamic var photoTags: NSAttributedString?
}
