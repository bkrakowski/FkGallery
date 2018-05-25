//
//  PhotosServiceAPI.swift
//  FkGallery
//
//  Created by bogdan on 2018-05-22.
//  Copyright © 2018 BoulderTechs. All rights reserved.
//

import Foundation
import SwiftyJSON

enum PhotosResponse {
    case success ([PhotoItem])
    case failure (Error)
}

protocol PhotosServiceAPI {
    func queryPhotos(tag: String?, closure: @escaping (PhotosResponse) -> Void)
}


class PhotosServiceImpl: PhotosServiceAPI {
    private var restService: RestServiceAPI
    
    init(restService: RestServiceAPI) {
        self.restService = restService
    }
    
    func queryPhotos(tag: String?, closure: @escaping (PhotosResponse) -> Void) {
        var params: [String: Any] = [
            "format": "json",
            "nojsoncallback": 1
        ]
    
        let prefferedLang = Locale.preferredLanguages.first
        if let prefferedLang = prefferedLang {
           params["lang"] = prefferedLang.lowercased()
        }
        
        if let tag = tag {
            params["tags"] = tag
        }
        
        let endpoint: Endpoint = Endpoint(
            urlPath: "/photos_public.gne",
            method: .get,
            params: params,
            headers: nil
        )
        
        var items: [PhotoItem] = []
    
        restService.hit(endpoint: endpoint) {
            response in
            switch response {
            case .success(let json):
                if let array = json["items"].array {
                    for itemJson in array {
                        let item = PhotoItemFactory.create(json: itemJson)
                        items.append(item)
                    }
                }
                
                DispatchQueue.main.async {
                    closure(.success(items))
                }

            case .failure(let error):
                DispatchQueue.main.async {
                    closure(.failure(error))
                }
            }
        }
    }
}
