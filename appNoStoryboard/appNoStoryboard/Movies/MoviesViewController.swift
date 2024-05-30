//
//  ViewController.swift
//  appNoStoryboard
//
//  Created by Nursultan Kabulov on 27.04.2024.
//
//9863b0919782bd200569d84cf236247b
import UIKit

class MoviesViewController: UIViewController {
	//MARK: - Properties
	private var themes = ["Popular", "Now Playing", "Upcoming", "Top Rated"]
	var movieData: [List] = []
	private var isFavList: [Int] = []
	private let networking = NetworkManager.shared
	var index = IndexPath(item: 0, section: 0)
	private lazy var themeLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "Theme"
		label.font = UIFont.preferredFont(forTextStyle: .headline)
		return label
	}()

	lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textAlignment = .center
		label.font = UIFont.systemFont(ofSize: 36, weight: .semibold)
		label.text = "Movie DB"

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

	//MARK: - ViewLifeCycle
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		collectionView(self.themeCollectionView, didSelectItemAt: index)
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.isNavigationBarHidden = true
		themeCollectionView.selectItem(at: index, animated: false, scrollPosition: [])

		MoviesCoreData.shared.loadNotes { data in
			self.isFavList = data.map { item in
				item.id
			}
		}
		self.tableView.reloadData()
	}

	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		guard let selectedIndex = self.themeCollectionView.indexPathsForSelectedItems?.first else { return }
		self.index = selectedIndex
		return
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = .systemBackground
		self.addView()
		self.setupView()
		self.themeCollectionView.allowsMultipleSelection = false
	}


}

//MARK: - TableView
extension MoviesViewController {
	func addView() {
//		self.title = "TABLEVIEW"

	}

	func setupView() {
		self.view.addSubview(self.themeLabel)
		self.view.addSubview(self.titleLabel)
		self.view.addSubview(self.tableView)
		self.view.addSubview(self.themeCollectionView)
		NSLayoutConstraint.activate([
			titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			themeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
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

extension MoviesViewController: UITableViewDelegate, UITableViewDataSource {
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
extension MoviesViewController {

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


//MARK: - CollectionView
extension MoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
			cell.contentView.backgroundColor = .red
			cell.isSelected = true
			cell.nameOfButton.textColor = .white
			guard let path = cell.nameOfButton.text else { return }
			self.loadMovies(path)
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
