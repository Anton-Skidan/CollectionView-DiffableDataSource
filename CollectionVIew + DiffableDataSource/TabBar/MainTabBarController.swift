//
//  MainTabBarController.swift
//  CollectionVIew + DiffableDataSource
//
//  Created by Антон Скидан on 20.06.2020.
//  Copyright © 2020 Anton Skidan. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let listVC = ListViewController()
        let watchedVideosVC = WatchedVideosViewController()
        
        tabBar.tintColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        let watchedVideosImage = UIImage(systemName: "tv.fill")!
        let videosImage = UIImage(systemName: "tv")!
        
        viewControllers = [
            generateNavigationController(rootViewController: listVC, title: "All videos", image: videosImage),
            generateNavigationController(rootViewController: watchedVideosVC, title: "Watched videos", image: watchedVideosImage)
        ]
    }
    
    private func generateNavigationController(rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        
        let navigaionVC = UINavigationController(rootViewController: rootViewController)
        navigaionVC.tabBarItem.title = title
        navigaionVC.tabBarItem.image = image
        return navigaionVC
    }
}
