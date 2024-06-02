//
//  TableViewCell.swift
//  appNoStoryboard
//
//  Created by Nursultan Kabulov on 06.05.2024.
//

import UIKit


final class MovieViewCell: UITableViewCell {
	//MARK: - Properties
	static var identifier: String {
		return String(describing: self)
	}
	weak var favView: IFavouritesView?
	private let networking = NetworkManager.shared
	static let rowHeight: CGFloat = 460
	private var id: Int?
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

	private lazy var addToFavouriteButton: UIButton = {
		let image = UIButton(type: .custom)
		image.setImage(UIImage(named: "ustar"), for: .normal)
		image.translatesAutoresizingMaskIntoConstraints = false
		image.widthAnchor.constraint(equalToConstant: 50).isActive = true
		image.heightAnchor.constraint(equalToConstant: 48).isActive = true
		image.contentMode = .scaleToFill
		image.addTarget(self, action: #selector(addToFav), for: .touchUpInside)
		return image
	}()

	private lazy var spinner: UIActivityIndicatorView = {
		let spinner = UIActivityIndicatorView(style: .medium)
		spinner.translatesAutoresizingMaskIntoConstraints = false
		return spinner
	}()

	private lazy var stackView: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [movieImage, titleLabel])
		stack.addSubview(addToFavouriteButton)
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .vertical
		stack.distribution = .fill
		stack.alignment = .center
		return stack
	}()

	//MARK: - ViewLifeCycle
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupLayout()
	}

	override func prepareForReuse() {
		super.prepareForReuse()
		contentView.layoutIfNeeded()
		movieImage.image = UIImage(named: "whiteBackground")
		addToFavouriteButton.setImage(UIImage(named: "ustar"), for: .normal)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	//MARK: - Methods
	func setData(movie: List) {
		titleLabel.text = movie.title
		id = movie.id
		path = movie.posterPath
		setImage(img: nil)
		networking.loadImage(from: movie.posterPath ?? "" ) { img in
			if self.path == movie.posterPath {
				DispatchQueue.main.async {
					self.setImage(img: img)
				}
			}
		}
	}

	func setData(title id: String) {
		titleLabel.text = id
	}

	func isFav(_ value: Bool) {
		if value {
			addToFavouriteButton.setImage(UIImage(named: "fstar"), for: .normal)
		} else {
			addToFavouriteButton.setImage(UIImage(named: "ustar"), for: .normal)
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
			contentView.layoutIfNeeded()
			return
		}
		self.spinner.stopAnimating()
		self.spinner.isHidden = true
		self.movieImage.image = img
		self.contentView.layoutIfNeeded()
	}

	func hideFavButton() {
		addToFavouriteButton.isHidden = true
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
			addToFavouriteButton.topAnchor.constraint(equalTo: movieImage.topAnchor, constant: 10),
			addToFavouriteButton.trailingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: -10)
		])
	}

	@objc func addToFav(_ sender: UIButton) {
		guard let title = titleLabel.text, let id = self.id, let path = self.path else { return }
		if sender.image(for: .normal) == UIImage(named: "fstar") {
			MoviesCoreData.shared.deleteNote(id: id)
			addToFavouriteButton.setImage(UIImage(named: "ustar"), for: .normal)
		} else if sender.image(for: .normal) == UIImage(named: "ustar") {
			let note = FavouriteMovies(id: id, title: title, posterPath: path)
			MoviesCoreData.shared.saveNote(note)
			addToFavouriteButton.setImage(UIImage(named: "fstar"), for: .normal)
		}
		guard let favView = favView else { return }
		favView.buttonTapped?()
	}
}
