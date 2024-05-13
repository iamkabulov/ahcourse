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
	static let rowHeight: CGFloat = 480

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

	private lazy var stackView: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [movieImage, titleLabel])
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .vertical
		stack.distribution = .equalSpacing
		stack.alignment = .center
		return stack
	}()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupLayout()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setData(movie: Result) {
		titleLabel.text = movie.title
	}

	func setImage(img: UIImage?) {
		guard let img = img else { return movieImage.image = UIImage(systemName: "arrow.down.circle.dotted") }
		movieImage.image = img
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
			movieImage.widthAnchor.constraint(equalToConstant: Spacing.Size.width),
			movieImage.topAnchor.constraint(equalTo: stackView.topAnchor, constant: Spacing.small),
			movieImage.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: Spacing.large),
			movieImage.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -Spacing.large),
			titleLabel.topAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: Spacing.small),
			titleLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: Spacing.large),
			titleLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -Spacing.large),
			titleLabel.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: -Spacing.small)
		])
	}
}
