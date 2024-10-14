//
//  TableViewCell.swift
//  appNoStoryboard
//
//  Created by Nursultan Kabulov on 06.05.2024.
//

import UIKit
import Combine


final class MovieViewCell: UITableViewCell {
	//MARK: - Properties
	static var identifier: String {
		return String(describing: self)
	}
	
	private let networking = NetworkManager.shared
	private var cancellables = Set<AnyCancellable>()
	private var viewModel: MoviesCellViewModel?
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
		label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
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

	func configure(with viewModel: MoviesCellViewModel) {
		self.viewModel = viewModel
		viewModel.$state
			.receive(on: DispatchQueue.main)
			.sink { [weak self] state in
				self?.spinnerEnabled(state: state)
			}
			.store(in: &cancellables)

		viewModel.$image
			.receive(on: DispatchQueue.main)
			.compactMap { $0 }
			.sink { [weak self] img in
				self?.movieImage.image = img
			}
			.store(in: &cancellables)

		viewModel.$title
			.receive(on: DispatchQueue.main)
			.compactMap { $0 }
			.assign(to: \.text, on: titleLabel)
			.store(in: &cancellables)

		viewModel.$isFav
			.receive(on: DispatchQueue.main)
			.sink { [weak self] isFav in
				guard let isFav = isFav else {
					self?.hideFavButton()
					return
				}
				self?.addToFavouriteButton.setImage(
					UIImage(named: isFav ? "fstar" : "ustar"),
					for: .normal
				)
			}
			.store(in: &cancellables)
	}

	func spinnerEnabled(state: ViewStates) {
		if state == .loading && !spinner.isAnimating {
			spinner.startAnimating()
		} else if state != .loading && spinner.isAnimating {
			spinner.stopAnimating()
		}
	}

	private func hideFavButton() {
		addToFavouriteButton.isHidden = true
	}

	deinit {
		cancellables.removeAll()
		print("DEINITED MOVIES CELL VIEW CONTROLLER")
	}
}

//MARK: - MovieViewCell
private extension MovieViewCell {
	func setupLayout() {
		contentView.addSubview(stackView)
		contentView.addSubview(spinner)
		NSLayoutConstraint.activate([
			stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Spacing.large),
			stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
			movieImage.heightAnchor.constraint(lessThanOrEqualToConstant: Spacing.Size.height),
			movieImage.widthAnchor.constraint(equalToConstant: Spacing.Size.width),
			addToFavouriteButton.topAnchor.constraint(equalTo: movieImage.topAnchor, constant: 10),
			addToFavouriteButton.trailingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: -10),

			spinner.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
			spinner.heightAnchor.constraint(equalToConstant: Spacing.Size.height),
			spinner.centerYAnchor.constraint(equalTo: stackView.centerYAnchor)
		])
	}

	@objc func addToFav(_ sender: UIButton) {
		guard let vm = self.viewModel else { return }
		vm.toggleFavorite()
	}
}
