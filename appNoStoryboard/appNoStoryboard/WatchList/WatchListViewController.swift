//
//  WatchListViewController.swift
//  appNoStoryboard
//
//  Created by Nursultan Kabulov on 30.05.2024.
//

import UIKit

final class WatchListViewController: UIViewController {
	private var watchList: [Int] = []

	lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textAlignment = .center
		label.font = UIFont.systemFont(ofSize: 36, weight: .semibold)
		label.text = "Watch List"

		return label
	}()

	lazy var noFavLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textAlignment = .center
		label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
		label.text = "No Watch List"

		return label
	}()

	private lazy var infoLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textAlignment = .center
		label.font = UIFont.systemFont(ofSize: 14, weight: .light)
		label.textColor = .gray
		label.text = "You haven't added in watch list any items yet."
		return label
	}()

	private lazy var noFavouriteImage: UIImageView = {
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.image = UIImage(named: "nowatch")
		image.heightAnchor.constraint(equalToConstant: 123).isActive = true
		image.widthAnchor.constraint(equalToConstant: 139).isActive = true
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
		guard let ids = WatchListUserDefaults.shared.getMovies() else { return }
		watchList = ids
		isEmptyViewSetup()
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground
		setupView()
	}
}

//MARK: - TableView
extension WatchListViewController {

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
		if watchList.isEmpty {
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

extension WatchListViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		watchList.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = self.tableView.dequeueReusableCell(withIdentifier: MovieViewCell.identifier, for: indexPath) as? MovieViewCell else { return UITableViewCell() }
		NetworkManager.shared.getDetailInfo(id: watchList[indexPath.row]) { data in
			DispatchQueue.main.async {
				cell.setData(title: data.title ?? "")
				cell.setImage(img: nil)
				NetworkManager.shared.loadImage(from: data.posterPath ?? "") { image in
					DispatchQueue.main.async {
						cell.setImage(img: image)
					}
				}
			}
		}

		cell.hideFavButton()
		return cell
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let detailView = MovieDetailsViewController(id: watchList[indexPath.row])
		self.navigationController?.pushViewController(detailView, animated: true)
	}
}

