//
//  NonIconMenuItemCell.swift
//  SlideInMenu
//
//  Created by Christophe Hoste on 12.10.18.
//  Copyright © 2018 hoste. All rights reserved.
//

import Foundation
import UIKit

class NonIconMenuItemCell: UITableViewCell {

	let itemLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
		return label
	}()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		setupStackView()
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	fileprivate func setupStackView() {
		let stackView = UIStackView(arrangedSubviews: [
			itemLabel,
			UIView()
			])
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.spacing = 16
		addSubview(stackView)

		NSLayoutConstraint.activate([
			stackView.topAnchor.constraint(equalTo: topAnchor),
			stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
			stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
			stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
			])

		stackView.isLayoutMarginsRelativeArrangement = true
		stackView.layoutMargins = UIEdgeInsets(top: 14, left: 24, bottom: 14, right: 24)
	}

	func setupCell(title: String) {
		itemLabel.text = title
	}
}
