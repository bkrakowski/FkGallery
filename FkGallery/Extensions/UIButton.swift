//
//  UIButton.swift
//  FkGallery
//
//  Created by bogdan on 2018-05-22.
//  Copyright © 2018 BoulderTechs. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    func applySimpleBorderStyle() {
        applyStyle(color: UIColor.appBlue, textColor: UIColor.appBlue, fill: false)
    }
    
    func applySimpleOtherBorderStyle() {
        applyStyle(color: UIColor.appGreen, textColor: UIColor.appGreen, fill: false)
    }
    
    func applySimpleBorderDestructiveStyle() {
        applyStyle(color: UIColor.appRed, textColor: UIColor.appRed, fill: false)
    }
    
    func applyRoundedButtonStyle() {
        applyStyle(color: UIColor.appBlue, textColor: UIColor.white, fill: true)
    }
    
    func applyRoundedOtherButtonStyle() {
        applyStyle(color: UIColor.appGreen, textColor: UIColor.white, fill: true)
    }
    
    func applyRoundedDestructiveButtonStyle() {
        applyStyle(color: UIColor.appRed, textColor: UIColor.white, fill: true)
    }
    
    func applyStyle(color: UIColor, textColor: UIColor, fill: Bool) {
        self.layer.cornerRadius = self.frame.size.height / 2;
        self.layer.masksToBounds = true;
        self.layer.borderWidth = 1.0;
        self.layer.borderColor = color.cgColor;
        self.tintColor = color;
        self.backgroundColor = fill ? color : UIColor.clear
        self.titleLabel?.font = UIFont.appSemiboldFont(ofSize: self.titleLabel?.font?.pointSize ?? 15)
        self.setTitleColor(textColor, for: .normal)
        self.setTitleColor(textColor.withAlphaComponent(0.5), for: .highlighted)
        self.setTitleColor(textColor.withAlphaComponent(0.5), for: .disabled)
    }

}

