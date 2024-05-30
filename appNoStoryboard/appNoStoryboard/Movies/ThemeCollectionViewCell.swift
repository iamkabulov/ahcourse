//
//  CollectionViewCell.swift
//  appNoStoryboard
//
//  Created by Nursultan Kabulov on 13.05.2024.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
	//MARK: - Properties
	static var identifier: String {
		return String(describing: self)
	}

	lazy var nameOfButton: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.preferredFont(forTextStyle: .footnote)
		label.textAlignment = .center
		return label
	}()
	
	//MARK: - LifeCycle
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
		contentView.backgroundColor = .systemGray5
		contentView.layer.cornerRadius = 10.0
		contentView.layer.masksToBounds = true
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
//MARK: - ViewSetup
extension CollectionViewCell {
	func setupView() {
		contentView.addSubview(nameOfButton)
		NSLayoutConstraint.activate([
			nameOfButton.topAnchor.constraint(equalTo: contentView.topAnchor),
			nameOfButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			nameOfButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			nameOfButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
		])
	}
}

