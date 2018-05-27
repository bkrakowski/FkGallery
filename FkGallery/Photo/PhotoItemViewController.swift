//
//  PhotoItemViewController.swift
//  FkGallery
//
//  Created by bogdan on 2018-05-22.
//  Copyright © 2018 BoulderTechs. All rights reserved.
//

import UIKit
import AlamofireImage
import SVProgressHUD

class PhotoItemViewController: UIViewController, PhotoItemView {
    @IBOutlet weak var imageView: UIImageView?
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var authorLabel: UILabel?
    @IBOutlet weak var takenDateLabel: UILabel?
    @IBOutlet weak var publishedDateLabel: UILabel?
    @IBOutlet weak var tagsLabel: UILabel?
    @IBOutlet weak var followAuthorButton: UIButton?
    @IBOutlet weak var openLinkButton: UIButton?
    
    var photoItemPresenter: PhotoItemPresenter?
    
    private var disposeBag: [NSKeyValueObservation] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = NSLocalizedString("Photo Detail", comment: "")
        
        configureView()
        observePresenter()
    }
    
    private func observePresenter() {
        guard let target = photoItemPresenter?.photoItemSource else { return }
        typealias targetType = PhotoItemSourceObservable
        
        disposeBag.append(target.observe(\targetType.photoUrl, options: [.initial, .new]) { [weak self] (target, change) in
            if let newValue = change.newValue {
                self?.updateImage(url: newValue)
            }
        })
        
        disposeBag.append(target.observe(\targetType.photoTitle, options: [.initial, .new]) { [weak self] (target, change) in
            if let newValue = change.newValue {
                self?.titleLabel?.attributedText = newValue
                self?.titleLabel?.accessibilityValue = newValue?.string
            }
        })
        
        disposeBag.append(target.observe(\targetType.photoAuthor, options: [.initial, .new]) { [weak self] (target, change) in
            if let newValue = change.newValue {
                self?.authorLabel?.attributedText = newValue
                self?.authorLabel?.accessibilityValue = newValue?.string
            }
        })
        
        disposeBag.append(target.observe(\targetType.photoTakenDate, options: [.initial, .new]) { [weak self] (target, change) in
            if let newValue = change.newValue {
                self?.takenDateLabel?.attributedText = newValue
                self?.takenDateLabel?.accessibilityValue = newValue?.string
            }
        })
        
        disposeBag.append(target.observe(\targetType.photoPublishedDate, options: [.initial, .new]) { [weak self] (target, change) in
            if let newValue = change.newValue {
                self?.publishedDateLabel?.attributedText = newValue
                self?.publishedDateLabel?.accessibilityValue = newValue?.string
            }
        })

        disposeBag.append(target.observe(\targetType.photoTags, options: [.initial, .new]) { [weak self] (target, change) in
            if let newValue = change.newValue {
                self?.tagsLabel?.attributedText = newValue
                self?.tagsLabel?.accessibilityValue = newValue?.string
            }
        })
    }
    
    private func configureView() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        followAuthorButton?.applyRoundedButtonStyle()
        
        if let followed = photoItemPresenter?.isAuthorFollowed(), followed {
            followAuthorButton?.setTitle(NSLocalizedString("Clear Author Filter", comment: ""), for: .normal)
        } else {
            followAuthorButton?.setTitle(NSLocalizedString("Filter by Author", comment: ""), for: .normal)
        }
        
        openLinkButton?.applySimpleBorderStyle()
        openLinkButton?.isEnabled = photoItemPresenter?.canOpenLink() ?? false
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(imagePressed))
        imageView?.addGestureRecognizer(tap)
    }
    
    private func updateImage(url: URL?) {
        let placeholderImage = UIImage(named: "placeholder")
        if let url = url {
            // af_setImage has image caching already implemented
            self.imageView?.af_setImage(withURL: url, placeholderImage: placeholderImage)
        } else {
            self.imageView?.image = placeholderImage
        }
    }
    
    @IBAction func followAuthorPressed() {
        if let followed = photoItemPresenter?.isAuthorFollowed(), followed {
            photoItemPresenter?.clearFollowing()
        } else {
            photoItemPresenter?.followAuthor()
        }
    }
    
    @IBAction func openLinkPressed() {
        photoItemPresenter?.openLink()
    }
    
    // TODO: Saving images is a seperate feature. Move it out of the view.
    
    @objc func imagePressed() {
        let alertController = UIAlertController(title: NSLocalizedString("Please select photo action", comment: ""), message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: NSLocalizedString("Save to Photo Library", comment: ""), style: .default, handler: { (action) in
            if let image = self.imageView?.image {
                SVProgressHUD.show()
                UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)
            }
        }))
        alertController.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel))
        present(alertController, animated: true)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        SVProgressHUD.dismiss()
        
        if let error = error {
            let alertController = UIAlertController(title: NSLocalizedString("Saving Failed", comment: ""), message: error.localizedDescription, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default))
            present(alertController, animated: true)
        } else {
            let alertController = UIAlertController(title: NSLocalizedString("Photo Saved", comment: ""), message: NSLocalizedString("The photo has been saved to your photos library.", comment: ""), preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default))
            present(alertController, animated: true)
        }
    }
}


