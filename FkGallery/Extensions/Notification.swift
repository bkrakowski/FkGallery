//
//  Notification.swift
//  FkGallery
//
//  Created by bogdan on 2018-05-22.
//  Copyright © 2018 BoulderTechs. All rights reserved.
//

import Foundation

extension Notification {
    public struct UserInfoKey {
        static let authorTupple: String = "authorTupple"
    }
}

extension Notification.Name {
    static public var followAuthor: Notification.Name {
        let name = Notification.Name("NotificationFollowAuthor")
        return name
    }
}

