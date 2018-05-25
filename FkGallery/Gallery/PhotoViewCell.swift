//
//  PhotoViewCell.swift
//  FkGallery
//
//  Created by bogdan on 2018-05-22.
//  Copyright © 2018 BoulderTechs. All rights reserved.
//

import UIKit

class PhotoViewCell: UITableViewCell {
    @IBOutlet weak var photoView: UIImageView?
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var takenDateLabel: UILabel?
    @IBOutlet weak var tagsLabel: UILabel?
    
    static let identifier = "PhotoViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}


extension PhotoViewCell: PhotoCellView {

    func updateImage(url: String?) {
        let placeholderImage = UIImage(named: "placeholder")
        if let url = url, let urlReal = URL(string: url) {
            // af_setImage has image caching already implemented
            photoView?.af_setImage(withURL: urlReal, placeholderImage: placeholderImage)
        } else {
            photoView?.image = placeholderImage
        }
    }
    
    func updateTitleLabel(text: NSAttributedString?) {
        titleLabel?.attributedText = text
        titleLabel?.accessibilityValue = text?.string
    }
    
    func updateTakenDateLabel(text: NSAttributedString?) {
        takenDateLabel?.attributedText = text
        takenDateLabel?.accessibilityValue = text?.string
    }
    
    func updateTagsLabel(text: NSAttributedString?) {
        tagsLabel?.attributedText = text
        tagsLabel?.accessibilityValue = text?.string
    }
}
