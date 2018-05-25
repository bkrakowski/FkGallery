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
    func updateTakenDateLabel(text: NSAttributedString?)
    func updateTagsLabel(text: NSAttributedString?)
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
                item.title.attributedAccentedText(accents: nil, fontSize: labelsFontSize + 3) :
                attributedPlaceholder(string: NSLocalizedString("No Title", comment: ""))
        )
        
        cellView.updateTakenDateLabel(
            text: attributedPara(title: NSLocalizedString("Taken on", comment: ""),
                                 text: item.dateTaken != nil ? PhotoCellPresenterImpl.dateFormatter.string(from: item.dateTaken!) : "NA")
        )
        
        cellView.updateTagsLabel(
            text: item.tags.count > 0 ?
                attributedPara(title: NSLocalizedString("Tags", comment: ""), text: item.tags) :
                attributedPlaceholder(string: NSLocalizedString("No Tags", comment: "")))
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
