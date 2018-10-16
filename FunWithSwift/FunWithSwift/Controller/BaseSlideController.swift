//
//  BaseSlideController.swift
//  SlideInMenu
//
//  Created by Christophe Hoste on 10.10.18.
//  Copyright © 2018 hoste. All rights reserved.
//

import Foundation
import UIKit

class BaseSlideController: UIViewController {

	fileprivate var isOpenMenu = false
	fileprivate var trailingAnchor: NSLayoutConstraint!

	fileprivate let menuView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()

	fileprivate let contentView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()

	fileprivate let darkOverlay: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = UIColor(white: 0, alpha: 0.4)
		view.alpha = 0
		return view
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		setupViews()
		setupViewController()
		setupGestures()
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
	}

	fileprivate func setupViews() {
		view.addSubview(contentView)
		view.addSubview(menuView)

		NSLayoutConstraint.activate([
			contentView.topAnchor.constraint(equalTo: view.topAnchor),
			contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			contentView.widthAnchor.constraint(equalTo: view.widthAnchor),

			menuView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			menuView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			menuView.trailingAnchor.constraint(equalTo: contentView.leadingAnchor),
			menuView.widthAnchor.constraint(equalToConstant: Constants.SlideMenu.menuWidth)
			])

		trailingAnchor = contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
		trailingAnchor.isActive = true
	}

	fileprivate func setupViewController() {
		let tabBarController = TabBarController()
		contentView.addSubview(tabBarController.view)
		tabBarController.view.frame = contentView.frame

		let menuController = UINavigationController(rootViewController: MenuController())
		menuView.addSubview(menuController.view)
		menuController.view.frame = menuView.frame

		addChild(tabBarController)
		addChild(menuController)
	}

	fileprivate func setupGestures() {
		let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
		view.addGestureRecognizer(panGesture)
	}

	@objc fileprivate func handlePan(gesture: UIPanGestureRecognizer) {
		switch gesture.state {
		case .began:
			addOverlay()
		case .changed:
			handleChanged(gesture)
		case .ended:
			handleEnded(gesture)
		default:
			return
		}
	}

	fileprivate func handleChanged(_ gesture: UIPanGestureRecognizer) {
		var translationX = gesture.translation(in: view).x

		translationX = isOpenMenu ? translationX + Constants.SlideMenu.menuWidth : translationX
		translationX = min(Constants.SlideMenu.menuWidth, translationX)
		translationX = max(0, translationX)

		trailingAnchor.constant = translationX
		darkOverlay.alpha = translationX / Constants.SlideMenu.menuWidth
	}

	fileprivate func handleEnded(_ gesture: UIPanGestureRecognizer) {
		let translationX = gesture.translation(in: view).x
		let velocity = gesture.velocity(in: view).x

		if isOpenMenu {
			if abs(velocity) > Constants.SlideMenu.velocityThreshold {
				handleHide()
				return
			}

			if abs(translationX) < Constants.SlideMenu.menuWidth / 2 {
				handleOpen()
			} else {
				handleHide()
			}
		} else {
			if velocity > Constants.SlideMenu.velocityThreshold {
				handleOpen()
				return
			}

			if translationX < Constants.SlideMenu.menuWidth/2 {
				handleHide()
			} else {
				handleOpen()
			}
		}
	}

	fileprivate func handleHide() {
		isOpenMenu = false
		removeOverlay()
		performAnimation(0)
	}

	fileprivate func handleOpen() {
		isOpenMenu = true
		performAnimation(Constants.SlideMenu.menuWidth)
	}

	fileprivate func performAnimation(_ value: CGFloat) {
		trailingAnchor.constant = value

		UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
			self.view.layoutIfNeeded()
		}) { (_) in
			return
		}
	}

	fileprivate func addOverlay() {
		contentView.addSubview(darkOverlay)
		NSLayoutConstraint.activate([
			darkOverlay.topAnchor.constraint(equalTo: contentView.topAnchor),
			darkOverlay.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
			darkOverlay.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			darkOverlay.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
			])

		UIView.animate(withDuration: 0.25, animations: {
			self.darkOverlay.alpha = 1
		})
	}

	fileprivate func removeOverlay() {
		UIView.animate(withDuration: 0.25, animations: {
			self.darkOverlay.alpha = 0
		}) { (_) in
			self.darkOverlay.removeFromSuperview()
		}
	}
}
