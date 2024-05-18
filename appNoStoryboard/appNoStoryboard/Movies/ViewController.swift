//
//  ViewController.swift
//  appNoStoryboard
//
//  Created by Nursultan Kabulov on 27.04.2024.
//
//9863b0919782bd200569d84cf236247b
import UIKit

class ViewController: UIViewController {

	private var themes = ["Popular", "Now Playing", "Upcoming", "Top Rated"]
	var movieData: [List] = []

	var index = IndexPath(item: 0, section: 0)
	private lazy var themeLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "Theme"
		label.font = UIFont.preferredFont(forTextStyle: .headline)
		return label
	}()

	private let session = URLSession(configuration: .default)
	lazy private var urlComponent: URLComponents = {
		var component = URLComponents()
		component.scheme = "https"
		component.host = "api.themoviedb.org"
		component.queryItems = [
			URLQueryItem(name: "api_key", value: "9863b0919782bd200569d84cf236247b")
		]
		return component
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

	lazy var themeCollectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		let view = UICollectionView(
			frame: .zero,
			collectionViewLayout: layout
		)
		view.dataSource = self
		view.delegate = self

		view.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
//		view.backgroundColor = .cyan
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		collectionView(self.themeCollectionView, didSelectItemAt: index)
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		themeCollectionView.selectItem(at: index, animated: false, scrollPosition: [])
		//last time selected cell save and give it here
	}

	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		guard let selectedIndex = self.themeCollectionView.indexPathsForSelectedItems?.first else { return }
		self.index = selectedIndex
		return
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		self.title = "Movie DB"
		self.view.backgroundColor = .systemBackground
		self.addView()
		self.setupView()
		self.themeCollectionView.allowsMultipleSelection = false
//		self.getUpcomingMovies()
	}


}

//MARK: - TableView
extension ViewController {
	func addView() {
//		self.title = "TABLEVIEW"

	}

	func setupView() {
		self.view.addSubview(self.themeLabel)
		self.view.addSubview(self.tableView)
		self.view.addSubview(self.themeCollectionView)
		NSLayoutConstraint.activate([
			themeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			themeLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: CGFloat(15)),
			themeCollectionView.topAnchor.constraint(equalTo: themeLabel.bottomAnchor, constant: CGFloat(5)),
			themeCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: CGFloat(10)),
			themeCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -CGFloat(10)),
			themeCollectionView.heightAnchor.constraint(equalToConstant: CGFloat(30)),
			tableView.topAnchor.constraint(equalTo: themeCollectionView.bottomAnchor),
			tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
		])
	}
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		movieData.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = self.tableView.dequeueReusableCell(withIdentifier: MovieViewCell.identifier, for: indexPath) as? MovieViewCell else { return UITableViewCell() }
		cell.setData(movie: movieData[indexPath.row])
		return cell

	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let detailView = MovieDetailsViewController(id: movieData[indexPath.row].id)
		self.navigationController?.pushViewController(detailView, animated: true)
	}
}

//MARK: - API
extension ViewController {

	func apiRequests(_ path: String) {
		switch path {
		case "Upcoming":
			getUpcomingMovies()
		case "Popular":
			getPopularMovies()
		case "Now Playing":
			getNowPlaying()
		case "Top Rated":
			getTopRated()
		default:
			print("Something went wrong.")
		}
	}

	func getUpcomingMovies() {
		self.urlComponent.path = "/3/movie/upcoming"

		guard let requestUrl = self.urlComponent.url else { return }

		session.dataTask(with: requestUrl) { data, response, error in
			DispatchQueue.main.async(flags: .barrier) { [self] in
				guard let data = data, error == nil else {
					return
				}
				do {
					let response = try JSONDecoder().decode(MovieEntity.self, from: data)
					self.movieData = response.results
					self.tableView.reloadData()
					return
				} catch {
					return print(error)
				}
			}
		}.resume()
	}

	func getPopularMovies() {
		self.urlComponent.path = "/3/movie/popular"
		guard let requestUrl = urlComponent.url else { return }

		self.session.dataTask(with: requestUrl) { data, response, error in
			DispatchQueue.main.async(flags: .barrier) { [self] in
				guard let data = data, error == nil else {
					print(data ?? "")
					return
				}
				do {
					let response = try JSONDecoder().decode(PopularMovieEntity.self, from: data)
					self.movieData = response.results
					self.tableView.reloadData()
					return
				} catch {
					return print(error)
				}
			}
		}.resume()
	}

	func getNowPlaying() {
		self.urlComponent.path = "/3/movie/now_playing"

		guard let requestUrl = self.urlComponent.url else { return }

		session.dataTask(with: requestUrl) { data, response, error in
			DispatchQueue.main.async(flags: .barrier) { [self] in
				guard let data = data, error == nil else {
					return
				}
				do {
					let response = try JSONDecoder().decode(MovieEntity.self, from: data)
					self.movieData = response.results
					self.tableView.reloadData()
					return
				} catch {
					return print(error)
				}
			}
		}.resume()
	}

	func getTopRated() {
		self.urlComponent.path = "/3/movie/top_rated"

		guard let requestUrl = self.urlComponent.url else { return }

		session.dataTask(with: requestUrl) { data, response, error in
			DispatchQueue.main.async(flags: .barrier) { [self] in
				guard let data = data, error == nil else {
					return
				}
				do {
					let response = try JSONDecoder().decode(TopRated.self, from: data)
					self.movieData = response.results
					self.tableView.reloadData()
					return
				} catch {
					return print(error)
				}
			}
		}.resume()
	}
}


//MARK: - CollectionView
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		themes.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = self.themeCollectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }
		cell.nameOfButton.text = themes[indexPath.row]
		return cell
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: 80, height: 24)
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		if let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell {
			apiRequests(cell.nameOfButton.text ?? "")
			cell.contentView.backgroundColor = .red
			cell.isSelected = true
			cell.nameOfButton.textColor = .white
		}
	}

	func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
		if let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell {
			cell.contentView.backgroundColor = .systemGray5
			cell.isSelected = false
			cell.nameOfButton.textColor = .black
		}
	}
}
