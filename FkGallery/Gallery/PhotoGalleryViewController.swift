//
//  PhotoGalleryViewController.swift
//  FkGallery
//
//  Created by bogdan on 2018-05-22.
//  Copyright © 2018 BoulderTechs. All rights reserved.
//

import UIKit
import SVProgressHUD

class PhotoGalleryViewController: UIViewController, PhotoGalleryView {
    @IBOutlet weak var searchBar: UISearchBar?
    @IBOutlet weak var tableView: UITableView?
    private var messagePresenter: MessagePresenting?
    
    var photoGalleryPresenter: PhotoGalleryPresenter?
    var photoCellPresenter: PhotoCellPresenter?
    
    private var disposeBag: [NSKeyValueObservation] = []
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = NSLocalizedString("Flickr Public Feed", comment: "")
        
        configureView()
        observePresenter()
        
        photoGalleryPresenter?.queryPhotoItems(searchText: nil, asLazySearch: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        hideKeyboard()
    }
    
    private func observePresenter() {
        guard let target = photoGalleryPresenter?.photoItemsSource else { return }
        typealias targetType = PhotoItemsSourceObservable
        
        disposeBag.append(target.observe(\targetType.photoItemsQueried, options: [.initial, .new]) { (target, change) in
            if let newValue = change.newValue {
                self.updateView(photoItemsQueried: newValue)
            }
        })
    }
    
    private func configureView() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        if let tableView = tableView {
            tableView.register(UINib(nibName: "PhotoViewCell", bundle: nil), forCellReuseIdentifier: PhotoViewCell.identifier)
            tableView.tableFooterView = UIView(frame: .zero)
            tableView.refreshControl = refreshControl
        }
        
        refreshControl.isAccessibilityElement = true
        refreshControl.addTarget(self, action: #selector(refreshPhotoItems), for: .valueChanged)
        
        messagePresenter = MessageView.create(in: self.view)
        
        let tapHideKeyboard = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapHideKeyboard.cancelsTouchesInView = false
        view?.addGestureRecognizer(tapHideKeyboard)
    }
    
    @objc func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    @objc func refreshPhotoItems() {
        photoGalleryPresenter?.queryPhotoItems(searchText: searchBar?.text, asLazySearch: false)
    }
    
    private func updateView(photoItemsQueried: PhotoItemsQueried) {
        switch photoItemsQueried.state {
        case .querying:
            messagePresenter?.update(nil)
            
            if self.refreshControl.isRefreshing == false {
                SVProgressHUD.show()
            }
        case .ready:
            SVProgressHUD.dismiss()
            
            self.refreshControl.endRefreshing()
            self.tableView?.reloadData()
            
            if let error = photoItemsQueried.error {
                messagePresenter?.update(error.localizedDescription)
            } else {
                messagePresenter?.update(nil)
            }
        }
    }
}

// TODO: consider using RxSwift and RxCocoa for the reactive table handling
extension PhotoGalleryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let photoItems = photoGalleryPresenter?.photoItemsSource.photoItemsQueried.photoItems {
            return photoItems.count
        } else {
            return 0
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PhotoViewCell.identifier, for: indexPath)
        
        if let photoViewCell = cell as? PhotoViewCell, let photoItems = photoGalleryPresenter?.photoItemsSource.photoItemsQueried.photoItems {
            photoCellPresenter?.formatCell(cellView: photoViewCell, item: photoItems[indexPath.row])
            cell.accessibilityValue = photoViewCell.titleLabel?.attributedText?.string
        }
        
        return cell;
    }
}

// TODO: consider using RxSwift and RxCocoa for the reactive table handling
extension PhotoGalleryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let photoItems = photoGalleryPresenter?.photoItemsSource.photoItemsQueried.photoItems {
            photoGalleryPresenter?.showPhotoItemDetail(item: photoItems[indexPath.row])
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension PhotoGalleryViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.photoGalleryPresenter?.queryPhotoItems(searchText: searchText, asLazySearch: true)
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.photoGalleryPresenter?.queryPhotoItems(searchText: searchBar.text, asLazySearch: false)
    }
}

