//
//  SeperatorCell.swift
//  SlideInMenu
//
//  Created by Christophe Hoste on 12.10.18.
//  Copyright © 2018 hoste. All rights reserved.
//

import Foundation
import UIKit

class SeperatorView: UIView {
	override var intrinsicContentSize: CGSize {
		return .init(width: 1, height: 0.5)
	}

	init() {
		super.init(frame: .zero)
		backgroundColor = UIColor.lightBlue.withAlphaComponent(0.2)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

class SeperatorCell: UITableViewCell {

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		selectionStyle = .none
		setupStackView()
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	fileprivate func setupStackView() {
		let stackView = UIStackView(arrangedSubviews: [
			SeperatorView()
			])
		stackView.translatesAutoresizingMaskIntoConstraints = false
		addSubview(stackView)

		NSLayoutConstraint.activate([
			stackView.topAnchor.constraint(equalTo: topAnchor),
			stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
			stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
			stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
			])

		stackView.isLayoutMarginsRelativeArrangement = true
		stackView.layoutMargins = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
	}
}
