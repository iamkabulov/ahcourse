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
	static let rowHeight: CGFloat = 470

	private enum Spacing {
		static let small: CGFloat = 4
		static let medium: CGFloat = 8
		static let large: CGFloat = 16
	}

	private lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.preferredFont(forTextStyle: .title1)
		return label
	}()

	private lazy var movieImage: UIImageView = {
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		return image
	}()

	private lazy var stackView: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [movieImage, titleLabel])
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .vertical
		stack.distribution = .fillProportionally
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
	
	func setData(movie: MovieTitle) {
		titleLabel.text = movie.titleLabel
		movieImage.image = movie.image
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
		])
	}
}
