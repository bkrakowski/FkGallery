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
        
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(onFollowAuthor(notification:)), name: .followAuthor, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func queryPhotoItemsNow(searchText: String?) {
        guard let photosService = photosService else { return }
        
        let existingItems = self.photoItemsQueried.photoItems
        
        DispatchQueue.main.async {
            self.photoItemsQueried = PhotoItemsQueried(state: .querying, photoItems: existingItems, error: nil)
        }
        
        let tags = searchText?.components(separatedBy: " ")
        var authors: [String] = []
        if let author = followAuthor.authorId {
            authors.append(author)
        }
        
        photosService.queryPhotos(tags: tags, authorIds: authors) {
            response in
            
            switch response {
            case .success (let photoItems):
                self.photoItemsQueried = PhotoItemsQueried(state: .ready, photoItems: photoItems, error: nil)
            case .failure (let error):
                self.photoItemsQueried = PhotoItemsQueried(state: .ready, photoItems: existingItems, error: error)
            }
        }
    }
    
    @objc func onFollowAuthor(notification: NSNotification) {
        if let follow = notification.userInfo?[Notification.UserInfoKey.authorTupple] as? (authorId: String, name: String) {
            followAuthor = FollowAuthor(authorId: follow.authorId, name: follow.name)
        } else {
            followAuthor = FollowAuthor(authorId: nil, name: nil)
        }
    }
}

extension PhotoGalleryPresenterImpl: PhotoGalleryPresenter {
    var photoItemsSource: PhotoItemsSourceObservable {
        return self
    }
    
    func presentPhotoItemDetailScene(item: PhotoItem, followed: Bool) {
        guard let photoGalleryView = photoGalleryView else { return }
        
        photoGalleryWire?.presentPhotoItemDetailScene(for: photoGalleryView, item: item, followed: followed)
    }
    
    func dismissPhotoItemDetailScene(for view: PhotoGalleryView) {
        guard let photoGalleryView = photoGalleryView else { return }
        
        photoGalleryWire?.dismissPhotoItemDetailScene(for: photoGalleryView)
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
    
    func clearFollowedAuthor() {
        followAuthor = FollowAuthor(authorId: nil, name: nil)
    }
}
