//
//  MessageView.swift
//  FkGallery
//
//  Created by bogdan on 2018-05-24.
//  Copyright © 2018 BoulderTechs. All rights reserved.
//

import UIKit

protocol TextMessageOverlay {
    func updateText(_ messageText: String?)
}

class MessageView: UIView {
    @IBOutlet weak var messageView: UIView?
    @IBOutlet weak var messageLabel: UILabel?
    @IBOutlet weak var messageViewWidth: NSLayoutConstraint?
    @IBOutlet weak var messageViewHeight: NSLayoutConstraint?

    static func create(in view: UIView) -> TextMessageOverlay? {
        if let messageView = Bundle.main.loadNibNamed("MessageView", owner: self, options: nil)?.first as? MessageView {
            view.addSubview(messageView)
            centerInSuperview(messageView: messageView)
            return messageView
        }
        
        return nil
    }
    
    private static func centerInSuperview(messageView: UIView) {
        messageView.translatesAutoresizingMaskIntoConstraints = false
        
        let cX: NSLayoutConstraint = NSLayoutConstraint(item: messageView, attribute: .centerX, relatedBy: .equal, toItem: messageView.superview, attribute: .centerX, multiplier: 1, constant: 0)
        messageView.superview?.addConstraint(cX)
        
        let cY: NSLayoutConstraint = NSLayoutConstraint(item: messageView, attribute: .centerY, relatedBy: .equal, toItem: messageView.superview, attribute: .centerY, multiplier: 1, constant: 0)
        messageView.superview?.addConstraint(cY)
    }
}

extension MessageView: TextMessageOverlay {
    func updateText(_ messageText: String?) {
        if let messageLabel = self.messageLabel, let messageView = self.messageView {
            messageLabel.text = messageText
            messageView.isHidden = messageText == nil || messageText!.count == 0
            
            if messageText != nil, let superview = self.superview {
                let constraintSize = CGSize.init(width: superview.frame.size.width - 60, height: superview.frame.size.height - 100)
                let fittingRect = messageText!.boundingRect(with: constraintSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: messageLabel.font], context: nil)
                
                messageViewWidth?.constant = 16 + fittingRect.size.width
                messageViewHeight?.constant = 12 + fittingRect.size.height
                messageView.updateConstraints()
            }
        }
    }
}
