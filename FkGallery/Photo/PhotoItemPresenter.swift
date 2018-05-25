//
//  PhotoItemPresenter.swift
//  FkGallery
//
//  Created by bogdan on 2018-05-22.
//  Copyright © 2018 BoulderTechs. All rights reserved.
//

import Foundation
import UIKit

class PhotoItemPresenterImpl: PhotoItemSourceObservable {
    var photoItemWire: PhotoItemWire?
    private var item: PhotoItem?
    
    private let labelsFontSize: CGFloat = 14.0
    
    private static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .medium
        formatter.timeZone = TimeZone.current
        return formatter
    } ()
    
    func setPhotoItemModel(item: PhotoItem?) {
        self.item = item
        updateFromItem(item: item)
    }
    
    private func updateFromItem(item: PhotoItem?) {
        if let item = item {
            rawAuthor = matchAuthor(author: item.author)
            
            photoUrl = URL(string: item.linkSmall)
            
            photoTitle = item.title.count > 0 ?
                item.title.attributedAccentedText(accents: nil, fontSize: labelsFontSize + 4) :
                attributedPlaceholder(string: NSLocalizedString("No Title", comment: ""))
            
            photoAuthor = attributedPara(title: NSLocalizedString("Author", comment: ""), text: matchAuthor(author: item.author))
            
            photoTakenDate = attributedPara(title: NSLocalizedString("Taken on", comment: ""),
                                            text: item.dateTaken != nil ? PhotoItemPresenterImpl.dateFormatter.string(from: item.dateTaken!) : "NA")
            
            photoPublishedDate = attributedPara(title: NSLocalizedString("Published on", comment: ""),
                                                text: item.published != nil ? PhotoItemPresenterImpl.dateFormatter.string(from: item.published!) : "NA")
            
            photoTags = item.tags.count > 0 ?
                attributedPara(title: NSLocalizedString("Tags", comment: ""), text: item.tags) :
                attributedPlaceholder(string: NSLocalizedString("No Tags", comment: ""))
        } else {
            photoUrl = nil
            photoTitle = nil
            photoAuthor = nil
            photoTakenDate = nil
            photoPublishedDate = nil
            photoTags = nil
        }
    }
    
    private func matchAuthor(author: String) -> String {
        // e.g. "nobody@flickr.com (\"haddock16\")"
        if let start = author.range(of: "(\""), let stop = author.range(of: "\")") {
            let cleanAuthor = author[start.upperBound..<stop.lowerBound]
            return String(cleanAuthor)
        }
        return author
    }
    
    private func attributedPara(title: String, text: String) -> NSAttributedString {
        let full = title + "\n" + text
        return full.attributedAccentedText(accents: [title], fontSize: labelsFontSize)
    }
    
    private func attributedPlaceholder(string: String) -> NSAttributedString {
        let baseAttributes = [
            NSAttributedStringKey.foregroundColor: UIColor.lightGray,
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: labelsFontSize - 2)
        ]
        
        let attributedText = NSMutableAttributedString(string: string, attributes: baseAttributes)
        return attributedText
    }
}

extension PhotoItemPresenterImpl: PhotoItemPresenter {
    var photoItemSource: PhotoItemSourceObservable? {
        return self
    }
    
    func canOpenLink() -> Bool {
        guard let item = item else { return false }
        
        if let url = URL(string: item.link) {
            return UIApplication.shared.canOpenURL(url)
        }
        return false
    }
    
    func openLink() {
        guard let item = item else { return }
        
        if let url = URL(string: item.link) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
