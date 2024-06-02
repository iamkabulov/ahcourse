//
//  SearchViewController.swift
//  appNoStoryboard
//
//  Created by Nursultan Kabulov on 01.06.2024.
//

import UIKit

class SearchViewController: UIViewController {
	//MARK: - Properties
	var movieData: [List] = []
	private var isFavList: [Int] = []
	private var favMovies: [FavouriteMovies] = []
	private let networking = NetworkManager.shared

	lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textAlignment = .center
		label.font = UIFont.systemFont(ofSize: 36, weight: .semibold)
		label.text = "Search"

		return label
	}()


	//MARK: - SearchView
	lazy var searchField: UISearchTextField = {
		let input = UISearchTextField()
		input.translatesAutoresizingMaskIntoConstraints = false
		input.autocorrectionType = .no
		input.tintColor = .black
		input.delegate = self
		input.placeholder = "Search"
		return input
	}()

	//MARK: - EmptyScreenImage
	private lazy var notFoundImage: UIImageView = {
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.image = UIImage(named: "nofav")
		image.heightAnchor.constraint(equalToConstant: 151).isActive = true
		image.widthAnchor.constraint(equalToConstant: 149).isActive = true
		return image
	}()

	private lazy var infoLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textAlignment = .center
		label.font = UIFont.systemFont(ofSize: 14, weight: .light)
		label.textColor = .gray
		label.text = "Not found"
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

	//MARK: - ViewLifeCycle
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.isNavigationBarHidden = true
		navigationItem.hidesSearchBarWhenScrolling = true
		MoviesCoreData.shared.loadNotes { [self] data in
			self.favMovies = data
		}
		self.tableView.reloadData()
	}

	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = .systemBackground
		self.addView()
		self.setupView()
	}


}

//MARK: - TableView
extension SearchViewController {
	func addView() {
//		self.title = "TABLEVIEW"

	}

	func setupView() {
		self.view.addSubview(self.titleLabel)
		self.view.addSubview(self.tableView)
		self.view.addSubview(self.searchField)
		self.view.addSubview(self.notFoundImage)
		self.view.addSubview(self.infoLabel)
		NSLayoutConstraint.activate([
			titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			searchField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
			searchField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
			searchField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
			tableView.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 10),
			tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

			notFoundImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			notFoundImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			infoLabel.topAnchor.constraint(equalTo: notFoundImage.bottomAnchor, constant: 10),
			infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

		])
	}
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		movieData.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = self.tableView.dequeueReusableCell(withIdentifier: MovieViewCell.identifier, for: indexPath) as? MovieViewCell else { return UITableViewCell() }
		cell.setData(movie: movieData[indexPath.row])
		guard let favId = movieData[indexPath.row].id else { return cell }
		if favMovies.isEmpty {
			cell.isFav(false)
		} else {
			let _ = favMovies.filter { movie in
				if favId == movie.id {
					cell.isFav(true)
				}
				return false
			}
		}
		return cell
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let detailView = MovieDetailsViewController(id: movieData[indexPath.row].id ?? 0)
		self.navigationController?.pushViewController(detailView, animated: true)
	}
}

//MARK: - API
extension SearchViewController: UITextFieldDelegate {

	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		guard let title = textField.text else { return true }
		networking.searchByName(title) { result in
			self.movieData = result.results ?? []
			print(self.movieData)
			DispatchQueue.main.async { [self] in
				self.notFound(!movieData.isEmpty)
				self.tableView.reloadData()

			}
		}
		textField.resignFirstResponder()
		return true
	}

	func notFound(_ value: Bool) {
		notFoundImage.isHidden = value
		infoLabel.isHidden = value
	}
}
