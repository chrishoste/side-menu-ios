//
//  MenuHeaderView.swift
//  SlideInMenu
//
//  Created by Christophe Hoste on 11.10.18.
//  Copyright © 2018 hoste. All rights reserved.
//

import Foundation
import UIKit

protocol MenuHeaderViewDelegate: class {
	func settingsButtonTriggered()
}

class MenuHeaderView: UIView {

	let nameLabel = UILabel()
	let usernameLabel = UILabel()
	let statsLabel = UILabel()

	weak var delegate: MenuHeaderViewDelegate?

	let profileImageView: ProfileImageView = {
		let imageView = ProfileImageView()
		imageView.image = UIImage(named: "profile")
		return imageView
	}()

	let settingsButtom: CustomSizeButton = {
		let button = CustomSizeButton(space: 48)
		button.setImage(#imageLiteral(resourceName: "settings"), for: .normal)
		button.contentHorizontalAlignment = .fill
		button.contentVerticalAlignment = .fill
		button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 0)
		button.addTarget(self, action: #selector(handleSetting), for: .touchDown)
		return button
	}()

	@objc func handleSetting() {
		delegate?.settingsButtonTriggered()
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
		backgroundColor = .white
		setupLabels()
		setupStackView()
	}

	fileprivate func setupStackView() {
		let stackView = UIStackView(arrangedSubviews: [
			UIStackView(arrangedSubviews: [profileImageView, UIView(), settingsButtom]),
			SpacerView(space: 10),
			nameLabel,
			usernameLabel,
			SpacerView(space: 16),
			statsLabel
			])
		stackView.axis = .vertical
		stackView.translatesAutoresizingMaskIntoConstraints = false
		addSubview(stackView)

		NSLayoutConstraint.activate([
			stackView.topAnchor.constraint(equalTo: topAnchor),
			stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
			stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
			stackView.leadingAnchor.constraint(equalTo: leadingAnchor)
			])

		stackView.isLayoutMarginsRelativeArrangement = true
		stackView.layoutMargins = .init(top: 16, left: 24, bottom: 16, right: 16)
	}

	fileprivate func setupLabels() {
		nameLabel.text = "Chris"
		nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
		usernameLabel.text = "@ChrisKiix"
		usernameLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
		usernameLabel.textColor = .lightBlue

		let attributedText = NSMutableAttributedString(string: "37 ",
													   attributes: [.font: UIFont.systemFont(ofSize: 14, weight: .medium)])
		attributedText.append(NSAttributedString(string: "Following   ", attributes: [
			.font: UIFont.systemFont(ofSize: 14, weight: .regular),
			.foregroundColor: UIColor.lightBlue
			]))
		attributedText.append(NSAttributedString(string: "2 ",
												 attributes: [.font: UIFont.systemFont(ofSize: 14, weight: .medium)]))
		attributedText.append(NSAttributedString(string: "Followers", attributes: [
			.font: UIFont.systemFont(ofSize: 14, weight: .regular),
			.foregroundColor: UIColor.lightBlue
			]))

		statsLabel.attributedText = attributedText
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
