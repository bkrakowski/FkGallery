//
//  PhotoGalleryPresenter.swift
//  FkGallery
//
//  Created by bogdan on 2018-05-22.
//  Copyright © 2018 BoulderTechs. All rights reserved.
//

import Foundation


class PhotoGalleryPresenterImpl: PhotoItemsSourceObservable {
    var photoGalleryWire: PhotoGalleryWire?
    weak var photoGalleryView: PhotoGalleryView?
    
    private var photosService: PhotosServiceAPI? // a VIPER interactor
    private var searchDispatchWorkItem: DispatchWorkItem?
    
    init(photosService: PhotosServiceAPI) {
        self.photosService = photosService
    }
    
    private func queryPhotoItemsNow(searchText: String?) {
        guard let photosService = photosService else { return }
        
        let existingItems = self.photoItemsQueried.photoItems
        
        DispatchQueue.main.async {
            self.photoItemsQueried = PhotoItemsQueried(state: .querying, photoItems: existingItems, error: nil)
        }
        
        photosService.queryPhotos(tag: searchText) {
            response in
            
            switch response {
            case .success (let photoItems):
                self.photoItemsQueried = PhotoItemsQueried(state: .ready, photoItems: photoItems, error: nil)
            case .failure (let error):
                self.photoItemsQueried = PhotoItemsQueried(state: .ready, photoItems: existingItems, error: error)
            }
        }
    }
}

extension PhotoGalleryPresenterImpl: PhotoGalleryPresenter {
    var photoItemsSource: PhotoItemsSourceObservable {
        return self
    }
    
    func showPhotoItemDetail(item: PhotoItem) {
        guard let photoGalleryView = photoGalleryView else { return }
        
        photoGalleryWire?.presentPhotoItemDetailScene(for: photoGalleryView, item: item)
    }
    
    func queryPhotoItems(searchText: String?, asLazySearch: Bool?) {
        searchDispatchWorkItem?.cancel()
        
        if asLazySearch == true {
            searchDispatchWorkItem = DispatchWorkItem {
                self.queryPhotoItemsNow(searchText: searchText)
            }
            
            if let searchDispatchWorkItem = searchDispatchWorkItem {
                DispatchQueue.global().asyncAfter(deadline: .now() + 0.5, execute: searchDispatchWorkItem)
            }
        } else {
            DispatchQueue.global().async {
                self.queryPhotoItemsNow(searchText: searchText)
            }
        }
    }
}
