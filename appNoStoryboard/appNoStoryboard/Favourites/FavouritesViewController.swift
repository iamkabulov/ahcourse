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
		MoviesCoreData.shared.loadNotes { data in
			self.favMovies = data
			self.tableView.reloadData()
		}
		buttonTapped = {
			MoviesCoreData.shared.loadNotes { data in
				self.favMovies = data
				self.tableView.reloadData()
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
		self.view.addSubview(self.tableView)
		NSLayoutConstraint.activate([
			titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
			tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
		])
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
