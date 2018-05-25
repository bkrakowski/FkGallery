//
//  PhotoGalleryProtocols.swift
//  FkGallery
//
//  Created by bogdan on 2018-05-22.
//  Copyright © 2018 BoulderTechs. All rights reserved.
//

import Foundation

// Wires galery components together and the Router for scenes.
protocol PhotoGalleryWire: class {
    static func createPhotoGalleryScene() -> PhotoGalleryView?
    func presentPhotoItemDetailScene(for view: PhotoGalleryView, item: PhotoItem);
}

// Abstration of the galery view
protocol PhotoGalleryView: class {
}

// Gallery Presenter
protocol PhotoGalleryPresenter {
    var photoItemsSource: PhotoItemsSourceObservable { get }
    
    func queryPhotoItems(searchText: String?, asLazySearch: Bool?)
    func showPhotoItemDetail(item: PhotoItem)
}

// PhotoItemsSourceObservable supports KVO
class PhotoItemsSourceObservable: NSObject {
    @objc dynamic var photoItemsQueried: PhotoItemsQueried = PhotoItemsQueried(state: .ready, photoItems: [], error: nil)
}

// Represents model fed to the view
class PhotoItemsQueried: NSObject {
    enum State {
        case querying
        case ready
    }
    
    let state: State
    let photoItems: [PhotoItem]
    let error: Error?
    
    init(state: State, photoItems: [PhotoItem], error: Error?) {
        self.state = state
        self.photoItems = photoItems
        self.error = error
    }
}