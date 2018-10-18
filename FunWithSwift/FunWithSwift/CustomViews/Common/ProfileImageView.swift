//
//  ProfileImageView.swift
//  SlideInMenu
//
//  Created by Christophe Hoste on 11.10.18.
//  Copyright © 2018 hoste. All rights reserved.
//

import Foundation
import UIKit

class ProfileImageView: UIImageView {

	var imageSize: CGFloat!

	override var intrinsicContentSize: CGSize {
		return .init(width: imageSize, height: imageSize)
	}

	init(size: CGFloat = 48) {
		super.init(frame: .zero)
		imageSize = size
		contentMode = .scaleAspectFit
		layer.cornerRadius = imageSize / 2
		clipsToBounds = true
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
