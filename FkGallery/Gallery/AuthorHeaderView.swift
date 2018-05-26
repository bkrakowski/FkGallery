//
//  AuthorHeaderView.swift
//  FkGallery
//
//  Created by bogdan on 2018-05-26.
//  Copyright © 2018 BoulderTechs. All rights reserved.
//

import UIKit

protocol AuthorHeader {
    func setAuthor(_ author: String?)
    var following: Bool { get }
    var onClear: (() -> ())? { get set }
}


class AuthorHeaderView: UIView {
    @IBOutlet weak var authorLabel: UILabel?
    @IBOutlet weak var clearButton: UIButton?
    
    var onClear: (() -> ())?
    
    @IBAction func clearButtonPressed() {
        onClear?()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        authorLabel?.text = nil
    }
}

extension AuthorHeaderView: AuthorHeader {
    var following: Bool { return authorLabel?.text != nil }
    
    func setAuthor(_ author: String?) {
        authorLabel?.text = author
    }
}
