//
//  TableViewCell.swift
//  appNoStoryboard
//
//  Created by Nursultan Kabulov on 06.05.2024.
//

import UIKit


final class MovieViewCell: UITableViewCell {

	//	static let identifier = "Id"
	static var identifier: String {
		return String(describing: self)
	}
	static let rowHeight: CGFloat = 460
	private var path: String?

	private enum Spacing {
		enum Size {
			static let height: CGFloat = 424
			static let width: CGFloat = 309
		}
		static let small: CGFloat = 1
		static let medium: CGFloat = 8
		static let large: CGFloat = 16
	}

	private lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.preferredFont(forTextStyle: .headline)
		label.textAlignment = .center
		return label
	}()

	private lazy var movieImage: UIImageView = {
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.layer.masksToBounds = true
		image.layer.cornerRadius = 30
		return image
	}()

	private lazy var spinner: UIActivityIndicatorView = {
		let spinner = UIActivityIndicatorView(style: .medium)
		spinner.translatesAutoresizingMaskIntoConstraints = false
		return spinner
	}()

	private lazy var stackView: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [movieImage, titleLabel])
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .vertical
		stack.distribution = .fill
		stack.alignment = .center
		return stack
	}()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupLayout()
	}

	override func prepareForReuse() {
		super.prepareForReuse()
		contentView.layoutIfNeeded()
		movieImage.image = UIImage(named: "whiteBackground")
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setData(movie: List) {
		titleLabel.text = movie.title
		setImage(img: nil)
		loadImage(from: movie.posterPath)
	}

	func loadImage(from url: String) {
		path = url
		if let urlString = URL(string: "https://image.tmdb.org/t/p/w500\(url)") {
			DispatchQueue.global().async {
				guard let data = try? Data(contentsOf: urlString), let image = UIImage(data: data) else {
					return
				}
				DispatchQueue.main.async {
					if url == self.path {
						self.setImage(img: image)
					}
				}
			}
		}
	}

	func setImage(img: UIImage?) {
		guard let img = img else {
			contentView.addSubview(spinner)
			spinner.startAnimating()
			spinner.isHidden = false
			spinner.centerXAnchor.constraint(equalTo: stackView.centerXAnchor).isActive = true
			spinner.heightAnchor.constraint(equalToConstant: Spacing.Size.height).isActive = true
			spinner.centerYAnchor.constraint(equalTo: stackView.centerYAnchor).isActive = true
//			movieImage.heightAnchor.constraint(lessThanOrEqualToConstant: Spacing.Size.height).isActive = false
//			movieImage.widthAnchor.constraint(equalToConstant: Spacing.Size.width).isActive = false
			contentView.layoutIfNeeded()
			return
		}
			self.spinner.stopAnimating()
			self.spinner.isHidden = true
			self.movieImage.image = img
			self.contentView.layoutIfNeeded()
	}
}

//MARK: - MovieViewCell
private extension MovieViewCell {
	func setupLayout() {
		contentView.addSubview(stackView)
		NSLayoutConstraint.activate([
			stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Spacing.large),
			stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
			movieImage.heightAnchor.constraint(lessThanOrEqualToConstant: Spacing.Size.height),
			movieImage.widthAnchor.constraint(equalToConstant: Spacing.Size.width)
		])
	}
}
