//
//  UIFont.swift
//  FkGallery
//
//  Created by bogdan on 2018-05-22.
//  Copyright © 2018 BoulderTechs. All rights reserved.
//
import Foundation
import UIKit

extension UIFont {
    class func appBoldFont(ofSize: CGFloat) -> UIFont {
        return UIFont.boldSystemFont(ofSize: ofSize)
    }
    
    class func appRegularFont(ofSize: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: ofSize)
    }
    
    class func appRegularFontItalic(ofSize: CGFloat) -> UIFont {
        return UIFont.italicSystemFont(ofSize: ofSize)
    }
    
    class func appMediumFont(ofSize: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: ofSize, weight:.medium)
    }
    
    class func appSemiboldFont(ofSize: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: ofSize, weight:.semibold)
    }
    
    class func appSemiboldItalicFont(ofSize: CGFloat) -> UIFont {
        if let font = UIFont(name: "HelveticaNeue-BoldItalic", size: ofSize) {
            return font
        } else {
            return appRegularFont(ofSize: ofSize)
        }
    }
    
    class func appLightFont(ofSize: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: ofSize, weight:.light)
    }
    
    class func appLightItalicFont(ofSize: CGFloat) -> UIFont {
        if let font = UIFont(name: "HelveticaNeue-LightItalic", size: ofSize) {
            return font
        } else {
            return appRegularFont(ofSize: ofSize)
        }
    }

}

