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
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setData(movie: Result) {
		titleLabel.text = movie.title
	}

	func setImage(img: UIImage?) {
		guard let img = img else {
			contentView.addSubview(spinner)
			spinner.startAnimating()
			spinner.centerXAnchor.constraint(equalTo: stackView.centerXAnchor).isActive = true
			spinner.heightAnchor.constraint(equalToConstant: Spacing.Size.height).isActive = true
			spinner.centerYAnchor.constraint(equalTo: stackView.centerYAnchor).isActive = true
			return
		}
		movieImage.image = img
		spinner.stopAnimating()
		spinner.centerXAnchor.constraint(equalTo: stackView.centerXAnchor).isActive = false
		spinner.heightAnchor.constraint(equalToConstant: Spacing.Size.height).isActive = false
		spinner.centerYAnchor.constraint(equalTo: stackView.centerYAnchor).isActive = false
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
