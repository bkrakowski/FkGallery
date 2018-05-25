//
//  UIImage.swift
//  FkGallery
//
//  Created by bogdan on 2018-05-22.
//  Copyright © 2018 BoulderTechs. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    func imageTintedWithColor(color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, UIScreen.main.scale)
        color.setFill()
    
        if let context: CGContext = UIGraphicsGetCurrentContext(), let cgImage = self.cgImage {
            context.translateBy(x: 0, y: self.size.height)
            context.scaleBy(x: 1.0, y: -1.0)
            context.setBlendMode(.destinationOver)
            
            let rect: CGRect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
            context.draw(cgImage, in: rect)
            context.setBlendMode(.sourceIn)
            context.addRect(rect)
            context.drawPath(using: .fill)

            if let image: UIImage = UIGraphicsGetImageFromCurrentImageContext() {
                UIGraphicsEndImageContext()
                return image
            }
        }
        
        return self
    }
}

