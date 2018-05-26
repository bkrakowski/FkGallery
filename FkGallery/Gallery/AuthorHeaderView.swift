//
//  AuthorHeaderView.swift
//  FkGallery
//
//  Created by bogdan on 2018-05-26.
//  Copyright © 2018 BoulderTechs. All rights reserved.
//

import UIKit

class AuthorHeaderView: UIView {
    @IBOutlet weak var folowingLabel: UILabel?
    @IBOutlet weak var authorLabel: UILabel?
    @IBOutlet weak var clearButton: UIButton?
    
    weak var authorHeaderPresenter: AuthorHeaderPresenter?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = UIColor.appRed
        authorLabel?.text = nil
    }
    
    @IBAction func clearButtonPressed() {
        authorHeaderPresenter?.clearFollowing()
    }
}

extension AuthorHeaderView: FollowingAuthorHeaderView {
    func updateFollowingLabel(text: String?) {
        folowingLabel?.text = text
    }
    
    func updateAuthorLabel(text: String?) {
        authorLabel?.text = text
    }
    func enableClearButton(enable: Bool) {
        clearButton?.isEnabled = enable
    }
}
