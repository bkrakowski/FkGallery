//
//  JSON.swift
//  FkGallery
//
//  Created by bogdan on 2018-05-22.
//  Copyright © 2018 BoulderTechs. All rights reserved.
//

import Foundation
import SwiftyJSON

extension JSON {
    var cleanString: String {
        return self.stringValue.trimmingCharacters(in: .whitespaces)
    }
}
