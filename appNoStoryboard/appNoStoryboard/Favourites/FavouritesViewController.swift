//
//  FavouritesViewController.swift
//  appNoStoryboard
//
//  Created by Nursultan Kabulov on 27.05.2024.
//

import UIKit
import Combine

final class FavouritesViewController: UIViewController {
	//MARK: - ViewModel
	var viewModel = FavouritesViewModel()
	var anyCanccelables = Set<AnyCancellable>()

	//MARK: - Labels
	lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textAlignment = .center
		label.font = UIFont.systemFont(ofSize: 36, weight: .semibold)
		label.text = "Favourites"

		return label
	}()

	lazy var noFavLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textAlignment = .center
		label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
		label.text = "No Favourites"

		return label
	}()

	private lazy var infoLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textAlignment = .center
		label.font = UIFont.systemFont(ofSize: 14, weight: .light)
		label.textColor = .gray
		label.text = "You haven't liked any items yet."
		return label
	}()

	//MARK: - ImageView
	private lazy var noFavouriteImage: UIImageView = {
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.image = UIImage(named: "nofav")
		image.heightAnchor.constraint(equalToConstant: 151).isActive = true
		image.widthAnchor.constraint(equalToConstant: 149).isActive = true
		return image
	}()

	//MARK: - TableView
	lazy var tableView: UITableView = {
		let view = UITableView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.separatorStyle = .none
		view.register(MovieViewCell.self, forCellReuseIdentifier: MovieViewCell.identifier)
		view.delegate = self
		view.rowHeight = MovieViewCell.rowHeight
		view.dataSource = self
		return view
	}()

	//MARK: - LifeCycle
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.isNavigationBarHidden = true
		viewModel.getFavMovies()
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground
		setupView()
		bindViewModel()
	}

	func bindViewModel() {
		viewModel.$favMovies
			.receive(on: DispatchQueue.main)
			.sink { [weak self] data in
				self?.isEmptyViewSetup()
			}
			.store(in: &anyCanccelables)
	}
}

//MARK: - TableView
extension FavouritesViewController {
	//MARK: - View Setup
	func setupView() {
		self.view.addSubview(self.titleLabel)
		self.view.addSubview(self.noFavouriteImage)
		self.view.addSubview(self.noFavLabel)
		self.view.addSubview(self.infoLabel)
		self.view.addSubview(self.tableView)
		NSLayoutConstraint.activate([
			titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
			tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
			noFavouriteImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			noFavouriteImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			noFavLabel.topAnchor.constraint(equalTo: noFavouriteImage.bottomAnchor, constant: 10),
			noFavLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			infoLabel.topAnchor.constraint(equalTo: noFavLabel.bottomAnchor, constant: 10),
			infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
		])
	}

	func isEmptyViewSetup() {
		self.tableView.reloadData()
		if viewModel.favMovies.isEmpty {
			tableView.isHidden = true
			noFavouriteImage.isHidden = false
			noFavLabel.isHidden = false
			infoLabel.isHidden = false
		} else {
			noFavouriteImage.isHidden = true
			noFavLabel.isHidden = true
			infoLabel.isHidden = true
			tableView.isHidden = false

		}
	}
}
//MARK: - TableViewDelegate
extension FavouritesViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		viewModel.favMovies.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = self.tableView.dequeueReusableCell(withIdentifier: MovieViewCell.identifier, for: indexPath) as? MovieViewCell else { return UITableViewCell() }
		cell.configure(with: MoviesCellViewModel(favMovie: viewModel.favMovies[indexPath.row]))
		return cell
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let detailView = MovieDetailsViewController(id: viewModel.favMovies[indexPath.row].id)
		self.navigationController?.pushViewController(detailView, animated: true)
	}
}
