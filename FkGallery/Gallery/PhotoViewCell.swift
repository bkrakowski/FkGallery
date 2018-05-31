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
    @IBOutlet weak var authorLabel: UILabel?
    @IBOutlet weak var tagsLabel: UILabel?
    @IBOutlet weak var timeLabel: UILabel?
    
    static let identifier = "PhotoViewCell"
    
    var publishedDate: Date?
    var timer: Timer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.timeLabel?.textColor = UIColor.appBlue
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: true) { timer in
            self.timeLabel?.text = self.publishedDate?.timeAgo(doSeconds: false)
        }
    }

    deinit {
        timer?.invalidate()
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
    
    func updateAuthorLabel(text: NSAttributedString?) {
        authorLabel?.attributedText = text
        authorLabel?.accessibilityValue = text?.string
    }
    
    func updateTagsLabel(text: NSAttributedString?) {
        tagsLabel?.attributedText = text
        tagsLabel?.accessibilityValue = text?.string
    }
    
    func updatePublishedDate(date: Date?) {
        publishedDate = date
        let timeAgo = self.publishedDate?.timeAgo(doSeconds: false)
        self.timeLabel?.text = timeAgo
        timeLabel?.accessibilityValue = timeAgo
    }
}
