//
//  CastCollectionViewCell.swift
//  appNoStoryboard
//
//  Created by Nursultan Kabulov on 20.05.2024.
//

import UIKit
import SnapKit

class CastCollectionViewCell: UICollectionViewCell {
	static var identifier: String {
		return String(describing: self)
	}

	private lazy var vStackView: UIStackView = {
		let stack = UIStackView()
		stack.addSubview(artistName)
		stack.addSubview(heroName)
		stack.translatesAutoresizingMaskIntoConstraints = false
//		stack.backgroundColor = .red
		stack.axis = .vertical
		stack.contentMode = .center
		stack.distribution = .fillEqually
		stack.alignment = .center
//		stack.heightAnchor.constraint(equalToConstant: 10).isActive = true
		stack.spacing = .zero
		return stack
	}()

	private lazy var hStackView: UIStackView = {
		let stack = UIStackView()
		stack.addSubview(artistImage)
		stack.addSubview(vStackView)
		stack.translatesAutoresizingMaskIntoConstraints = false
//		stack.backgroundColor = .blue
		stack.axis = .horizontal
//		stack.contentMode = .center
//		stack.distribution = .equalSpacing
//		stack.alignment = .center

		stack.spacing = 10
		return stack
	}()

	private lazy var heroName: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.systemFont(ofSize: 16, weight: .light)
		label.textAlignment = .center
		label.textColor = .systemGray3
		label.text = "Venom"
		return label
	}()

	private lazy var artistName: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
		label.textAlignment = .center
		label.text = "Tom Hardy"
		return label
	}()

	private lazy var artistImage: UIImageView = {
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.image = UIImage(named: "movie")
		image.contentMode = .scaleAspectFill
		image.heightAnchor.constraint(equalToConstant: 60).isActive = true
		image.widthAnchor.constraint(equalToConstant: 60).isActive = true
		image.layer.cornerRadius = 30
		image.clipsToBounds = true
		return image
	}()


	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
//		contentView.backgroundColor = .systemGray5
//		contentView.layer.cornerRadius = 25.0
		contentView.layer.masksToBounds = true
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension CastCollectionViewCell {
	func setupView() {
		contentView.addSubview(hStackView)
		hStackView.snp.makeConstraints { make in
			make.edges.equalTo(contentView)
		}
		artistImage.snp.makeConstraints { make in
			make.top.equalTo(hStackView.snp.top)
			make.left.equalTo(hStackView.snp.left).offset(10)
		}
		artistName.snp.makeConstraints { make in
			make.top.equalTo(vStackView.snp.top).offset(15)
			make.left.equalTo(artistImage.snp.right).offset(10)
		}
		heroName.snp.makeConstraints { make in
			make.bottom.equalTo(artistName.snp.bottom).offset(15)
			make.left.equalTo(artistImage.snp.right).offset(10)
		}
	}
}


