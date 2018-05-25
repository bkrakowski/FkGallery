//
//  UIApplication.swift
//  FkGallery
//
//  Created by bogdan on 2018-05-22.
//  Copyright © 2018 BoulderTechs. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD

extension UIApplication {
    func configureAppAppearance() {
        self.statusBarStyle = .lightContent
        
        let tintColor: UIColor = UIColor.appBlue
        
        for window in self.windows {
            window.tintColor = tintColor
        }
        
        UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = tintColor
        
        let navigationBar = UINavigationBar.appearance(whenContainedInInstancesOf: [UINavigationController.self])
        navigationBar.tintColor = tintColor
        navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black, NSAttributedStringKey.font: UIFont.appSemiboldFont(ofSize: 16)]
        
        let barButtonItem = UIBarButtonItem.appearance(whenContainedInInstancesOf: [UINavigationController.self])
        barButtonItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: tintColor, NSAttributedStringKey.font: UIFont.appRegularFont(ofSize: 15)], for: .normal)
        barButtonItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.lightGray, NSAttributedStringKey.font: UIFont.appRegularFont(ofSize: 15)], for: .disabled)
        
        let searchBarLabel = UILabel.appearance(whenContainedInInstancesOf: [UISearchBar.self])
        searchBarLabel.font = UIFont.appLightFont(ofSize: 15)

        SVProgressHUD.setForegroundColor(tintColor)
        UIRefreshControl.appearance().tintColor = tintColor.withAlphaComponent(0.5)
    }

}

