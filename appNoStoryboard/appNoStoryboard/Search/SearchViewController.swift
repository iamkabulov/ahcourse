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
	lazy var stackSearchView: UIStackView = {
		let stack = UIStackView()
		stack.addSubview(searchField)
		stack.addSubview(imageView)
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .horizontal
		stack.heightAnchor.constraint(equalToConstant: 40).isActive = true
		stack.layer.cornerRadius = 10
		stack.backgroundColor = .systemGray4
		return stack
	}()

	lazy var imageView: UIImageView = {
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.image = UIImage(systemName: "magnifyingglass")
		image.contentMode = .scaleAspectFill
		image.tintColor = .gray
		image.heightAnchor.constraint(equalToConstant: 28).isActive = true
		image.widthAnchor.constraint(equalToConstant: 28).isActive = true
		return image
	}()

	lazy var searchField: UITextField = {
		let input = UITextField()
		input.translatesAutoresizingMaskIntoConstraints = false
		input.layer.cornerRadius = 5
		input.tintColor = .black
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
		self.view.addSubview(self.stackSearchView)
		self.view.addSubview(self.notFoundImage)
		self.view.addSubview(self.infoLabel)
		NSLayoutConstraint.activate([
			titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			stackSearchView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
			stackSearchView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
			stackSearchView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
			tableView.topAnchor.constraint(equalTo: stackSearchView.bottomAnchor),
			tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

			imageView.leadingAnchor.constraint(equalTo: stackSearchView.leadingAnchor, constant: 10),
			imageView.centerYAnchor.constraint(equalTo: stackSearchView.centerYAnchor),
			searchField.centerYAnchor.constraint(equalTo: stackSearchView.centerYAnchor),
			searchField.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
			searchField.trailingAnchor.constraint(equalTo: stackSearchView.trailingAnchor, constant: -10),

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
		if isFavList.isEmpty {
			cell.isFav(false)
		} else {
			let _ = isFavList.filter { id in
				if movieData[indexPath.row].id == id {
					cell.isFav(true)
				}
				return false
			}
		}
		return cell
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let detailView = MovieDetailsViewController(id: movieData[indexPath.row].id)
		self.navigationController?.pushViewController(detailView, animated: true)
	}
}

//MARK: - API
extension SearchViewController {

	func loadMovies(_ path: String) {
		switch path {
		case "Upcoming":
			networking.getUpcomingMovies { result in
				self.movieData = result
				DispatchQueue.main.async {
					self.tableView.reloadData()
				}
			}
		case "Popular":
			networking.getPopularMovies { result in
				self.movieData = result
				DispatchQueue.main.async {
					self.tableView.reloadData()
				}
			}
		case "Now Playing":
			networking.getNowPlaying { result in
				self.movieData = result
				DispatchQueue.main.async {
					self.tableView.reloadData()
				}
			}
		case "Top Rated":
			networking.getTopRated { result in
				self.movieData = result
				DispatchQueue.main.async {
					self.tableView.reloadData()
				}
			}
		default:
			print("Something went wrong.")
		}
	}
}
