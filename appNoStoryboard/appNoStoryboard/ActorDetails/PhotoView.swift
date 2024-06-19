//
//  PhotoView.swift
//  appNoStoryboard
//
//  Created by Nursultan Kabulov on 05.06.2024.
//

import UIKit
import SnapKit

class PhotoView: UIView {

	private var images: [UIImage] = []

	private lazy var stackView: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [imageView, imageView2, imageView3, imageView4])
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .horizontal
		stack.distribution = .fillEqually
		stack.alignment = .center
		stack.heightAnchor.constraint(equalToConstant: 107).isActive = true
		stack.spacing = 15
		return stack
	}()

	private lazy var imageView: UIImageView = {
		let view = UIImageView()
		view.image = UIImage(named: "movie")
		view.translatesAutoresizingMaskIntoConstraints = false
		view.contentMode = .scaleAspectFill
		view.heightAnchor.constraint(equalToConstant: 107).isActive = true
		view.widthAnchor.constraint(equalToConstant: 58).isActive = true
		return view
	}()

	private lazy var imageView2: UIImageView = {
		let view = UIImageView()
		view.image = UIImage(named: "movie")
		view.translatesAutoresizingMaskIntoConstraints = false
		view.contentMode = .scaleAspectFill
		view.heightAnchor.constraint(equalToConstant: 107).isActive = true
		view.widthAnchor.constraint(equalToConstant: 58).isActive = true
		return view
	}()

	private lazy var imageView3: UIImageView = {
		let view = UIImageView()
		view.image = UIImage(named: "movie")
		view.translatesAutoresizingMaskIntoConstraints = false
		view.contentMode = .scaleAspectFill
		view.heightAnchor.constraint(equalToConstant: 107).isActive = true
		view.widthAnchor.constraint(equalToConstant: 58).isActive = true
		return view
	}()

	private lazy var imageView4: UIImageView = {
		let view = UIImageView()
		view.image = UIImage(named: "movie")
		view.translatesAutoresizingMaskIntoConstraints = false
		view.contentMode = .scaleAspectFill
		view.alpha = 0.4
		view.heightAnchor.constraint(equalToConstant: 107).isActive = true
		view.widthAnchor.constraint(equalToConstant: 58).isActive = true
		return view
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
//		backgroundColor = .red
		setupView()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}


extension PhotoView {

	func setupView() {
		addSubview(stackView)
		stackView.snp.makeConstraints { make in
			make.top.bottom.equalToSuperview()
			make.leading.equalTo(20)
			make.trailing.equalTo(-20)
		}
	}

	func setImage(_ image: UIImage) {
		self.images.append(image)
		self.setImages()
	}

	func setImages() {
		if !images.isEmpty && images.count > 3 {
			imageView.image = images[0]
			imageView2.image = images[1]
			imageView3.image = images[2]
			imageView4.image = images[3]
		}
	}
}
