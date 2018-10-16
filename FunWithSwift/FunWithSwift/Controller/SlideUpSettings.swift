//
//  SlideUpSettings.swift
//  SlideInMenu
//
//  Created by Christophe Hoste on 15.10.18.
//  Copyright © 2018 hoste. All rights reserved.
//

import Foundation
import UIKit

class SlideUpSettings: UIViewController {

	let menuHeight: CGFloat = 300
	var bottomAnchor: NSLayoutConstraint!
	var menuHeightAnchor: NSLayoutConstraint!

	let menuView: UIView = {
		let view = UIView()
		view.backgroundColor = .blue
		view.layer.cornerRadius = 15
		return view
	}()

	let darkOverlayView: UIView = {
		let view = UIView()
		view.backgroundColor = UIColor(white: 0, alpha: 0.4)
		view.alpha = 0
		view.layer.masksToBounds = true
		return view
	}()

	override func viewDidLoad() {
		super.viewDidLoad()

		view.backgroundColor = .clear
		view.isOpaque = false

		setupViews()
		setupGestures()
	}
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		performAnimation(size: 0)
	}

	fileprivate func setupViews() {
		view.addSubview(darkOverlayView)
		view.addSubview(menuView)

		menuView.translatesAutoresizingMaskIntoConstraints = false
		darkOverlayView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			menuView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
			menuView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),

			darkOverlayView.topAnchor.constraint(equalTo: view.topAnchor),
			darkOverlayView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			darkOverlayView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			darkOverlayView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
			])

		menuHeightAnchor = menuView.heightAnchor.constraint(equalToConstant: menuHeight)
		menuHeightAnchor.isActive = true
		bottomAnchor = menuView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: menuHeight)
		bottomAnchor.isActive = true
	}

	fileprivate func setupGestures() {
		let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
		darkOverlayView.addGestureRecognizer(tapGesture)
		view.addGestureRecognizer(panGesture)
	}

	@objc fileprivate func handleTap(gesture: UITapGestureRecognizer) {
		performAnimation(size: menuHeight)
	}

	@objc fileprivate func handlePan(gesture: UIPanGestureRecognizer) {
		switch gesture.state {
		case .changed:
			handleChanged(gesture)
		case .ended:
			hanldeEnded(gesture)
		default:
			return
		}
	}

	fileprivate func handleChanged(_ gesture: UIPanGestureRecognizer) {
		let translationsY = gesture.translation(in: view).y
		var newHeight = menuHeight + (translationsY/2)*(-1)

		newHeight = min(700, newHeight)
		newHeight = max(menuHeight, newHeight)
		menuHeightAnchor.constant = newHeight

		if newHeight <= menuHeight {
			bottomAnchor.constant = 0 + translationsY
		} else {
			bottomAnchor.constant = 0
		}
	}

	fileprivate func hanldeEnded(_ gesture: UIPanGestureRecognizer) {
		let velocity = gesture.velocity(in: view).y
		if abs(bottomAnchor.constant) > menuHeight/2 || velocity > Constants.SlideMenu.velocityThreshold {
			performAnimation(size: 300)
		} else {
			performAnimation(size: 0)
		}
	}

	fileprivate func performAnimation(size: CGFloat) {
		bottomAnchor.constant = size
		menuHeightAnchor.constant = menuHeight
		UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.9, options: .curveEaseOut, animations: {
			self.darkOverlayView.alpha = size == self.menuHeight ? 0 : 1
			self.view.layoutIfNeeded()
		}) { (_) in
			if size == self.menuHeight {
				self.dismiss(animated: false, completion: nil)
			}
		}
	}
}
