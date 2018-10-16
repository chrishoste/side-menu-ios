//
//  SpacerView.swift
//  SlideInMenu
//
//  Created by Christophe Hoste on 11.10.18.
//  Copyright © 2018 hoste. All rights reserved.
//

import Foundation
import UIKit

class SpacerView: UIView {

	fileprivate var space: CGFloat = 0

	override var intrinsicContentSize: CGSize {
		return .init(width: space, height: space)
	}

	init(space: CGFloat) {
		super.init(frame: .zero)
		self.space = space
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
