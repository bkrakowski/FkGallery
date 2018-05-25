//
//  RestServiceAPI.swift
//  FkGallery
//
//  Created by bogdan on 2018-05-22.
//  Copyright © 2018 BoulderTechs. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import os.log

enum RestError: Error {
    case restError(Int, String)
}

struct Endpoint {
    let urlPath: String
    let method: HTTPMethod
    let params: [String: Any]?
    let headers: HTTPHeaders?
}

enum RestResponse {
    case success (JSON)
    case failure (Error)
}

protocol RestServiceAPI: class {
    func hit(endpoint: Endpoint, closure: @escaping (_ response: RestResponse) -> Void);
}

class RestServiceImpl: RestServiceAPI {
    // https://api.flickr.com/services/feeds/photos_public.gne?format=json&lang=en-us&format=json&nojsoncallback=1
    private let serverBaseUrl = "https://api.flickr.com/services/feeds"
    private let queue = DispatchQueue(label: "com.bogdan.rest", qos: .background, attributes: .concurrent)
    
    func hit(endpoint: Endpoint, closure: @escaping (_ response: RestResponse) -> Void) {
        let url = serverBaseUrl + endpoint.urlPath
        
        os_log("Info: queryPhotos start... - %@", type: .info, url + ", params: " + (endpoint.params?.debugDescription ?? "NA"))
        
        Alamofire.request(url, method: endpoint.method, parameters: endpoint.params, headers: endpoint.headers).validate().responseData(queue: queue) { data in
            let httpStatusCode: Int = data.response?.statusCode ?? 400
            
            if data.result.isSuccess {
                os_log("Info: queryPhotos OK", type: .info)
                if let data = data.result.value {
                    let json = JSON(data)
                    closure(.success (json))
                } else {
                    closure(.failure(data.result.error ?? RestError.restError(httpStatusCode, "The request failed: not data")))
                }
            } else {
                let errorString = data.result.error?.localizedDescription ?? "Error with code: \(httpStatusCode)"
                os_log("Error: queryPhotos NOK - %@", type: .error, errorString)
                closure(.failure(data.result.error ?? RestError.restError(httpStatusCode, "The request failed")))
            }
        }
    }
}
