//
//  String.swift
//  FkGallery
//
//  Created by bogdan on 2018-05-22.
//  Copyright © 2018 BoulderTechs. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func attributedAccentedText(accents: [String?]? = [], fontSize: CGFloat = 13.0) -> NSAttributedString {
        let baseAttributes = [
            NSAttributedStringKey.foregroundColor: UIColor.darkGray,
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: fontSize)
        ]
        let accentAttributes = [
            NSAttributedStringKey.foregroundColor: UIColor.darkGray,
            NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: fontSize)
        ]
        let attributedText =  NSMutableAttributedString(string: self, attributes: baseAttributes)
        
        if let accents = accents {
            for accent in accents {
                if let accent = accent, let substringRange = self.range(of: accent) {
                    let nsRange = NSRange(substringRange, in: self)
                    attributedText.addAttributes(accentAttributes, range: nsRange)
                }
            }
        }
        
        return attributedText
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
