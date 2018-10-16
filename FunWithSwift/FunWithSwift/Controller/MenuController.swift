//
//  MenuController.swift
//  SlideInMenu
//
//  Created by Christophe Hoste on 10.10.18.
//  Copyright © 2018 hoste. All rights reserved.
//

import Foundation
import UIKit

struct MenuItem {
	let image: UIImage
	let title: String
}

struct NonIconMenuItem {
	let title: String
}

class MenuController: UITableViewController {

	fileprivate var offset: CGFloat?

	let menuItems = [
		MenuItem(image: #imageLiteral(resourceName: "profileIcon"), title: "Profile"),
		MenuItem(image: #imageLiteral(resourceName: "profileIcon"), title: "Lists"),
		MenuItem(image: #imageLiteral(resourceName: "profileIcon"), title: "Bookmarks"),
		MenuItem(image: #imageLiteral(resourceName: "profileIcon"), title: "Moments"),
	]

	let nonIconMenuItems = [
		NonIconMenuItem(title: "Settings and privacy"),
		NonIconMenuItem(title: "Help Center")
	]


	override func viewDidLoad() {
		super.viewDidLoad()

		setupNavigationController()

		tableView.layer.masksToBounds = true
		tableView.separatorStyle = .none
		tableView.showsHorizontalScrollIndicator = false
		tableView.showsVerticalScrollIndicator = false
		tableView.register(MenuItemCell.self, forCellReuseIdentifier: "menuItem")
		tableView.register(SeperatorCell.self, forCellReuseIdentifier: "seperator")
		tableView.register(NonIconMenuItemCell.self, forCellReuseIdentifier: "nonIconItem")
	}

	fileprivate func setupNavigationController() {
		navigationController?.isNavigationBarHidden = true
		navigationController?.isToolbarHidden = false
		navigationController?.toolbar.barTintColor = .white
//		navigationController?.toolbar.clipsToBounds = true

		let moonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "moon"), style: .plain, target: self, action: nil)
		let flexibleItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
		let qrItem = UIBarButtonItem(image: #imageLiteral(resourceName: "qrCode"), style: .plain, target: self, action: nil)

		navigationController?.toolbar.insetsLayoutMarginsFromSafeArea = true
		navigationController?.toolbar.layoutMargins = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
		self.toolbarItems = [moonItem, flexibleItem, qrItem]
	}

	fileprivate func addSlideUpSettings() {
		let controller = SlideUpSettings()
		controller.modalPresentationStyle = .overCurrentContext
		self.parent?.parent?.present(controller, animated: false, completion: nil)
	}
}

extension MenuController {

	override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let menuHeaderView = MenuHeaderView()
		menuHeaderView.delegate = self
		return menuHeaderView
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return menuItems.count + nonIconMenuItems.count + 1
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if indexPath.row < menuItems.count {
			let cell = tableView.dequeueReusableCell(withIdentifier: "menuItem", for: indexPath) as! MenuItemCell
			let menuItem = menuItems[indexPath.row]
			cell.setupCell(image: menuItem.image, title: menuItem.title)
			return cell
		}

		if indexPath.row == menuItems.count {
			let cell = tableView.dequeueReusableCell(withIdentifier: "seperator", for: indexPath) as! SeperatorCell
			return cell
		}

		let cell = tableView.dequeueReusableCell(withIdentifier: "nonIconItem", for: indexPath) as! NonIconMenuItemCell
		let menuItem = nonIconMenuItems[indexPath.row - (menuItems.count + 1)]
		cell.setupCell(title: menuItem.title)
		return cell
	}

	override func scrollViewDidScroll(_ scrollView: UIScrollView) {

		guard let offsetY = offset else { return offset = scrollView.contentOffset.y }

		if offsetY + 10 < scrollView.contentOffset.y {
			debugPrint("true")
		} else {
			debugPrint("false")
		}
	}

	override func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
		offset = nil
	}
}

extension MenuController: MenuHeaderViewDelegate {
	func settingsButtonTriggered() {
		addSlideUpSettings()
	}
}
