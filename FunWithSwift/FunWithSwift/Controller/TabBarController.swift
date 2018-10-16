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
		let firstViewController =  UINavigationController(rootViewController: BasicController())
		firstViewController.viewControllers.first?.view.backgroundColor = .blue

		let secondiewController =  UINavigationController(rootViewController: BasicController())
		viewControllers = [firstViewController, secondiewController]
	}
}
