//
//  AccountItemCell.swift
//  FunWithSwift
//
//  Created by Christophe Hoste on 17.10.18.
//  Copyright © 2018 hoste. All rights reserved.
//

import Foundation
import UIKit

class AccountItemCell: UITableViewCell {

	let profileImageView: ProfileImageView = {
		let imageView = ProfileImageView(size: 32)
		imageView.image = #imageLiteral(resourceName: "profile")
		return imageView
	}()

	let nameLabel: UILabel = {
		let label = UILabel()
		label.text = "Chris"
		label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
		return label
	}()

	let userNameLabel: UILabel = {
		let label = UILabel()
		label.text = "@ChrisKiix"
		label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
		label.textColor = .lightBlue
		return label
	}()

	let checkamrkImageView: ProfileImageView = {
		let imageView = ProfileImageView(size: 20)
		imageView.image = #imageLiteral(resourceName: "checkmark")
		return imageView
	}()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		setupViews()
	}

	fileprivate func setupViews() {
		let labelStackView = UIStackView(arrangedSubviews: [nameLabel, userNameLabel])
		labelStackView.axis = .vertical

		let stackView = UIStackView(arrangedSubviews: [
			profileImageView,
			labelStackView,
			UIView(),
			checkamrkImageView
			])

		stackView.spacing = 8
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.isLayoutMarginsRelativeArrangement = true
		stackView.layoutMargins = .init(top: 12, left: 16, bottom: 12, right: 16)
		addSubview(stackView)

		NSLayoutConstraint.activate([
			stackView.topAnchor.constraint(equalTo: topAnchor),
			stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
			stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
			stackView.leadingAnchor.constraint(equalTo: leadingAnchor)
			])
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
