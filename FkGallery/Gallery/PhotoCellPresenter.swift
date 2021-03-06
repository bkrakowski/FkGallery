//
//  PhotoCellPresenter.swift
//  FkGallery
//
//  Created by bogdan on 2018-05-22.
//  Copyright © 2018 BoulderTechs. All rights reserved.
//

import Foundation
import UIKit


protocol PhotoCellView {
    func updateImage(url: String?)
    func updateTitleLabel(text: NSAttributedString?)
    func updateAuthorLabel(text: NSAttributedString?)
    func updateTagsLabel(text: NSAttributedString?)
    func updatePublishedDate(date: Date?)
}

protocol PhotoCellPresenter {
    func formatCell(cellView: PhotoCellView, item: PhotoItem);
}

class PhotoCellPresenterImpl: PhotoCellPresenter {
    private let labelsFontSize: CGFloat = 13.0
    
    private static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .medium
        formatter.timeZone = TimeZone.current
        return formatter
    } ()
    
    func formatCell(cellView: PhotoCellView, item: PhotoItem) {
        cellView.updateImage(url: item.linkSmall)
        
        cellView.updateTitleLabel(
            text: item.title.count > 0 ?
                item.title.attributedAccentedText(accents: nil, fontSize: labelsFontSize + 2) :
                attributedPlaceholder(string: NSLocalizedString("No Title", comment: ""))
        )
        
        cellView.updateAuthorLabel(
            text: attributedPara(title: NSLocalizedString("Author", comment: ""), text: item.author)
        )
        
        cellView.updateTagsLabel(
            text: item.tags.count > 0 ?
                attributedPara(title: NSLocalizedString("Tags", comment: ""), text: item.tags) :
                attributedPlaceholder(string: NSLocalizedString("No Tags", comment: ""))
        )
        
        cellView.updatePublishedDate(date: item.published)
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
