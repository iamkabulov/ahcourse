//
//  FavouritesViewController.swift
//  appNoStoryboard
//
//  Created by Nursultan Kabulov on 27.05.2024.
//

import UIKit
protocol IFavouritesView: AnyObject
{
	var buttonTapped: (() -> Void)? { get set }
}

final class FavouritesViewController: UIViewController {
	private var favMovies: [FavouriteMovies] = []
	internal var buttonTapped: (() -> Void)?
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

	private lazy var noFavouriteImage: UIImageView = {
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.image = UIImage(named: "nofav")
		image.heightAnchor.constraint(equalToConstant: 151).isActive = true
		image.widthAnchor.constraint(equalToConstant: 149).isActive = true
		return image
	}()

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

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		MoviesCoreData.shared.loadNotes { [self] data in
			self.favMovies = data
			isEmptyViewSetup()
		}
		buttonTapped = {
			MoviesCoreData.shared.loadNotes { [self] data in
				self.favMovies = data
				isEmptyViewSetup()
			}
		}


	}

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground
		setupView()
	}
}

//MARK: - TableView
extension FavouritesViewController: IFavouritesView {

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
		if favMovies.isEmpty {
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

extension FavouritesViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		favMovies.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = self.tableView.dequeueReusableCell(withIdentifier: MovieViewCell.identifier, for: indexPath) as? MovieViewCell else { return UITableViewCell() }
		cell.setData(movie: List(adult: true,
								 backdropPath: nil,
								 genreIDS: [],
								 id: Int(favMovies[indexPath.row].id),
								 originalLanguage: "",
								 originalTitle: "",
								 overview: "",
								 popularity: 2.0, 
								 posterPath: favMovies[indexPath.row].posterPath,
								 releaseDate: "",
								 title: favMovies[indexPath.row].title,
								 video: false,
								 voteAverage: 2.9,
								 voteCount: 1))
		cell.isFav(true)
		cell.favView = self
		return cell
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//		let detailView = MovieDetailsViewController(id: movieData[indexPath.row].id)
//		self.navigationController?.pushViewController(detailView, animated: true)
	}
}
