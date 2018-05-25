//
//  PhotoItemWire.swift
//  FkGallery
//
//  Created by bogdan on 2018-05-22.
//  Copyright © 2018 BoulderTechs. All rights reserved.
//

import Foundation

class PhotoItemWireImpl: PhotoItemWire {
    
    static func createPhotoItemScene(item: PhotoItem) -> PhotoItemView {
        let photoItemViewController = PhotoItemViewController(nibName: "PhotoItemViewController", bundle: nil)
        let photoItemPresenter = PhotoItemPresenterImpl()
        photoItemPresenter.setPhotoItemModel(item: item)
        photoItemPresenter.photoItemWire = PhotoItemWireImpl()
        photoItemViewController.photoItemPresenter = photoItemPresenter
        return photoItemViewController
    }
}

