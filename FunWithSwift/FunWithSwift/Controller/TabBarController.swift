//
//  TabBarController.swift
//  SlideInMenu
//
//  Created by Christophe Hoste on 10.10.18.
//  Copyright © 2018 hoste. All rights reserved.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        viewControllers = [
            createNavViewController(viewController: BasicController(), title: "Home", imageName: "house.fill"),
            createNavViewController(viewController: BasicController(), title: "Trending", imageName: "flame.fill"),
        ]
    }

    private func createNavViewController(viewController: UIViewController, title: String, imageName: String) -> UIViewController {

        viewController.navigationItem.title = title

        let navController = UINavigationController(rootViewController: viewController)
        navController.navigationBar.prefersLargeTitles = true
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(systemName: imageName)

        return navController
    }
}
