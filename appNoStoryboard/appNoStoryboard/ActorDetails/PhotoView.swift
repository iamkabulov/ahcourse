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
	private lazy var views = [imageView, imageView2, imageView3, imageView4]

	private lazy var stackView: UIStackView = {
		let stack = UIStackView()
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
		view.layer.cornerRadius = 4
		view.clipsToBounds = true
		view.heightAnchor.constraint(equalToConstant: 107).isActive = true
		view.widthAnchor.constraint(equalToConstant: 58).isActive = true
		return view
	}()

	private lazy var imageView2: UIImageView = {
		let view = UIImageView()
		view.image = UIImage(named: "movie")
		view.translatesAutoresizingMaskIntoConstraints = false
		view.contentMode = .scaleAspectFill
		view.layer.cornerRadius = 4
		view.clipsToBounds = true
		view.heightAnchor.constraint(equalToConstant: 107).isActive = true
		view.widthAnchor.constraint(equalToConstant: 58).isActive = true
		return view
	}()

	private lazy var imageView3: UIImageView = {
		let view = UIImageView()
		view.image = UIImage(named: "movie")
		view.translatesAutoresizingMaskIntoConstraints = false
		view.contentMode = .scaleAspectFill
		view.layer.cornerRadius = 4
		view.clipsToBounds = true
		view.heightAnchor.constraint(equalToConstant: 107).isActive = true
		view.widthAnchor.constraint(equalToConstant: 58).isActive = true
		return view
	}()

	private lazy var imageView4: UIImageView = {
		let view = UIImageView()
		view.image = UIImage(named: "movie")
		view.translatesAutoresizingMaskIntoConstraints = false
		view.contentMode = .scaleAspectFill
		view.layer.cornerRadius = 4
		view.clipsToBounds = true
		view.alpha = 0.4
		view.heightAnchor.constraint(equalToConstant: 107).isActive = true
		view.widthAnchor.constraint(equalToConstant: 58).isActive = true
		return view
	}()

	private lazy var imagesCountLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "+1"
		return label
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
		self.addViewsInStack()
		addSubview(stackView)
		addSubview(imagesCountLabel)
		stackView.snp.makeConstraints { make in
			make.top.bottom.equalToSuperview()
			make.leading.equalTo(20)
			make.trailing.equalTo(-20)
		}

		imagesCountLabel.snp.makeConstraints { make in
			make.centerX.centerY.equalTo(imageView4)
		}
	}

	func setImage(_ image: UIImage) {
		self.images.append(image)
		self.setImages()
	}

	func setImages() {
		if !images.isEmpty {
			for i in 0..<images.count {
				if i <= 3 {
					self.views[i].image = images[i]
				}
			}
		}
		imagesCountLabel.text = "+\(images.count-4)"
	}

	func addViewsInStack() {
		for item in views {
			stackView.addArrangedSubview(item)
		}
	}
}
