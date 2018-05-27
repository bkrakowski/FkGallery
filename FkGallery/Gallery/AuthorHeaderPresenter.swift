//
//  AuthorHeaderPresenter.swift
//  FkGallery
//
//  Created by bogdan on 2018-05-26.
//  Copyright © 2018 BoulderTechs. All rights reserved.
//

import Foundation

protocol FollowingAuthorHeaderView: class {
    func updateFollowingLabel(text: String?)
    func updateAuthorLabel(text: String?)
    func enableClearButton(enable: Bool)
}

protocol AuthorHeaderPresenter: class {
    var onClearFollowing: (() -> ())? { get set }
    var isFollowing: Bool { get }
    
    func getAuthorHeaderView() -> FollowingAuthorHeaderView?
    func setAuthor(_ author: String?)
    func clearFollowing()
}


class AuthorHeaderPresenterImpl: NSObject {
    var authorHeaderView: FollowingAuthorHeaderView?
    var onClearFollowing: (() -> ())?
    private var author: String?
}

extension AuthorHeaderPresenterImpl: AuthorHeaderPresenter {
    var isFollowing: Bool {
        return author != nil
    }
    
    func getAuthorHeaderView() -> FollowingAuthorHeaderView? {
        return authorHeaderView
    }
    
    func setAuthor(_ author: String?) {
        self.author = author
        
        authorHeaderView?.updateAuthorLabel(text: author)
        
        if isFollowing {
            authorHeaderView?.updateFollowingLabel(text: NSLocalizedString("Filtered by", comment: ""))
            authorHeaderView?.enableClearButton(enable: true)
        } else {
            authorHeaderView?.updateFollowingLabel(text: NSLocalizedString("No filter", comment: ""))
            authorHeaderView?.enableClearButton(enable: false)
        }
    }
    
    func clearFollowing() {
        setAuthor(nil)
        onClearFollowing?()
    }

}
