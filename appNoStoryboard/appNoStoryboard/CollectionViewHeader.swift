//
//  CollectionViewHeader.swift
//  appNoStoryboard
//
//  Created by Nursultan Kabulov on 14.05.2024.
//

import UIKit

class CollectionViewHeader: UICollectionReusableView {
	static var identifier: String {
		return String(describing: self)
	}

	private lazy var name: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "Theme"
		return label
	}()

	func configure() {
		addSubview(name)
		setupView()
	}
	
//	override func layoutSubviews() {
//		super.layoutSubviews()
//		name.frame = bounds
//	}

	func setupView() {
		NSLayoutConstraint.activate([
			name.centerYAnchor.constraint(equalTo: centerYAnchor),
			name.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat(10))
		])
	}
}
