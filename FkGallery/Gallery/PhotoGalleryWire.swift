//
//  PhotoGalleryWire.swift
//  FkGallery
//
//  Created by bogdan on 2018-05-22.
//  Copyright © 2018 BoulderTechs. All rights reserved.
//

import Foundation
import UIKit

class PhotoGalleryWireImpl: PhotoGalleryWire {
    
    static func createPhotoGalleryScene() -> PhotoGalleryView {
        let photoGalleryViewController = PhotoGalleryViewController(nibName: "PhotoGalleryViewController", bundle: nil)
        let photosService = PhotosServiceImpl(restService: RestServiceImpl())
        let photoGalleryPresenter = PhotoGalleryPresenterImpl(photosService: photosService)
        let photoGalleryWire = PhotoGalleryWireImpl()
        
        photoGalleryPresenter.photoGalleryWire = photoGalleryWire
        photoGalleryPresenter.photoGalleryView = photoGalleryViewController
        photoGalleryViewController.photoGalleryPresenter = photoGalleryPresenter
        photoGalleryViewController.photoCellPresenter = PhotoCellPresenterImpl()
        return photoGalleryViewController
    }
    
    func presentPhotoItemDetailScene(for view: PhotoGalleryView, item: PhotoItem) {
        if let view = view as? PhotoGalleryViewController {
            if let itemView = PhotoItemWireImpl.createPhotoItemScene(item: item) as? UIViewController {
                view.navigationController?.pushViewController(itemView, animated: true)
            }
        }
    }
    
    func dismissPhotoItemDetailScene(for view: PhotoGalleryView) {
        if let view = view as? PhotoGalleryViewController {
            view.navigationController?.popToRootViewController(animated: true)
        }
    }
}
