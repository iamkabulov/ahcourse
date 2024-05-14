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
	lazy var imgData = [IndexPath: Data?]()

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
		layout.scrollDirection = .vertical
		let view = UICollectionView(
			frame: .zero,
			collectionViewLayout: layout
		)
		view.dataSource = self
		view.delegate = self
		view.largeContentTitle = "Theme"
		view.register(CollectionViewHeader.self,
					  forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
					  withReuseIdentifier: CollectionViewHeader.identifier)

		view.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
//		view.backgroundColor = .cyan
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		let index = IndexPath(item: 0, section: 0)
		collectionView(self.themeCollectionView, didSelectItemAt: index)
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		let index = IndexPath(item: 0, section: 0)
		themeCollectionView.selectItem(at: index, animated: false, scrollPosition: [])
	}

	override func viewDidLoad() {
		super.viewDidLoad()
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
		self.view.addSubview(self.tableView)
		self.view.addSubview(self.themeCollectionView)
		NSLayoutConstraint.activate([
			themeCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			themeCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: CGFloat(5)),
			themeCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -CGFloat(5)),
			themeCollectionView.heightAnchor.constraint(equalToConstant: CGFloat(64)),
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
}

//MARK: - API
extension ViewController {

	func apiRequests(_ path: String) {
		switch path {
		case "Upcoming":
			getUpcomingMovies()
		case "Popular":
			getPopularMovies()
		default:
			print("Something went wrong.")
		}
	}

	func getUpcomingMovies() {
		let session = URLSession(configuration: .default)
		lazy var urlComponent: URLComponents = {
			var component = URLComponents()
			component.scheme = "https"
			component.host = "api.themoviedb.org"
			component.path = "/3/movie/upcoming"
			component.queryItems = [
				URLQueryItem(name: "api_key", value: "9863b0919782bd200569d84cf236247b")
			]
			return component
		}()

		guard let requestUrl = urlComponent.url else { return }

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
		let session = URLSession(configuration: .default)
		lazy var urlComponent: URLComponents = {
			var component = URLComponents()
			component.scheme = "https"
			component.host = "api.themoviedb.org"
			component.path = "/3/movie/popular"
			component.queryItems = [
				URLQueryItem(name: "api_key", value: "9863b0919782bd200569d84cf236247b")
			]
			return component
		}()

		guard let requestUrl = urlComponent.url else { return }

		session.dataTask(with: requestUrl) { data, response, error in
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

	func getImage2(path: String, completion: @escaping (Data?) -> Void) {
		if let url = URL(string: "https://image.tmdb.org/t/p/w500\(path)") {
			URLSession.shared.dataTask(with: url) { data, response, error in
				DispatchQueue.global(qos: .background).async {
					guard let _ = data, error == nil else { return }
					do {
						if let response = try? Data(contentsOf: url) {
							DispatchQueue.main.async {
								completion(response)
							}
						}
					}
				}
			}.resume()
		}
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
		return CGSize(width: 76, height: 24)
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

	func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
		if let items = collectionView.indexPathsForSelectedItems {
			if items.contains(indexPath) {
				collectionView.deselectItem(at: indexPath, animated: false)
				return false
			}
		}
		return true
	}

	func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionViewHeader.identifier, for: indexPath) as? CollectionViewHeader else { return UICollectionReusableView() }
		header.configure()
		return header
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
		CGSize(width: view.frame.size.width, height: CGFloat(30))
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
	}
}
