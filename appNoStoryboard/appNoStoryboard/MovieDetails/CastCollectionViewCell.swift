//
//  CastCollectionViewCell.swift
//  appNoStoryboard
//
//  Created by Nursultan Kabulov on 20.05.2024.
//

import UIKit
import SnapKit

class CastCollectionViewCell: UICollectionViewCell {
	//MARK: - Properties
	static var identifier: String {
		return String(describing: self)
	}
	
	private var path: String?

	//MARK: - StackViews
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
		stack.spacing = .zero
		return stack
	}()

	//MARK: - Labels
	private lazy var heroName: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.systemFont(ofSize: 14, weight: .light)
		label.textAlignment = .center
		label.textColor = .systemGray
		label.text = "Venom"
		return label
	}()

	private lazy var artistName: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
		label.textAlignment = .center
		label.text = "Tom Hardy"
		return label
	}()

	//MARK: - Image and Spinner
	private lazy var spinner: UIActivityIndicatorView = {
		let spinner = UIActivityIndicatorView(style: .medium)
		spinner.translatesAutoresizingMaskIntoConstraints = false
		return spinner
	}()

	private lazy var artistImage: UIImageView = {
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.image = UIImage(named: "whiteBackground")
		image.contentMode = .scaleAspectFill
		image.heightAnchor.constraint(equalToConstant: 60).isActive = true
		image.widthAnchor.constraint(equalToConstant: 60).isActive = true
		image.layer.cornerRadius = 30
		image.clipsToBounds = true
		return image
	}()

//MARK: - LifeCycle
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

	override func prepareForReuse() {
		super.prepareForReuse()
		contentView.layoutIfNeeded()
		artistImage.image = UIImage(named: "whiteBackground")
	}
}

//MARK: - Methods
extension CastCollectionViewCell {
	func setupView() {
		contentView.addSubview(hStackView)
		hStackView.snp.makeConstraints { make in
			make.edges.equalTo(contentView)
		}
		artistImage.snp.makeConstraints { make in
			make.top.equalTo(hStackView.snp.top)
			make.left.equalTo(hStackView.snp.left).offset(5)
		}
		artistName.snp.makeConstraints { make in
			make.top.equalTo(vStackView.snp.top).offset(15)
			make.left.equalTo(artistImage.snp.right).offset(5)
		}
		heroName.snp.makeConstraints { make in
			make.bottom.equalTo(artistName.snp.bottom).offset(15)
			make.left.equalTo(artistImage.snp.right).offset(5)
		}
	}

	func setData(_ data: Cast) {
		artistName.text = data.name
		heroName.text = data.character
		setImage(img: nil)
		loadImage(from: data.profilePath ?? "")
	}

	func loadImage(from url: String) {
		path = url
		NetworkManager.shared.loadImage(from: url) { image in
			DispatchQueue.main.async {
				if url == self.path {
					self.setImage(img: image)
				}
			}
		}
	}

	func setImage(img: UIImage?) {
		guard let img = img else {
			hStackView.addSubview(spinner)
			spinner.startAnimating()
			spinner.isHidden = false
			spinner.snp.makeConstraints { make in
				make.top.equalTo(hStackView.snp.top)
				make.left.equalTo(hStackView.snp.left).offset(24)
				make.height.equalTo(artistImage)
			}
			contentView.layoutIfNeeded()
			return
		}
		self.spinner.stopAnimating()
		self.spinner.isHidden = true
		self.artistImage.image = img
		self.contentView.layoutIfNeeded()
	}
}


