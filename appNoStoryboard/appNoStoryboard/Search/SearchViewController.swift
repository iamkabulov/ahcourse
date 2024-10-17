//
//  SearchViewController.swift
//  appNoStoryboard
//
//  Created by Nursultan Kabulov on 01.06.2024.
//

import UIKit
import Combine
import Lottie

class SearchViewController: UIViewController {
	//MARK: - Properties
	private var viewModel = SearchViewModel()
	private var anyCancellables = Set<AnyCancellable>()
	private var isSearched: Bool = false
	private let networking = NetworkManager.shared

	//MARK: - title
	lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textAlignment = .center
		label.font = UIFont.systemFont(ofSize: 36, weight: .semibold)
		label.text = "Search"

		return label
	}()

	lazy var recommendedLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textAlignment = .center
		label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
		label.text = "Recommended For You"

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
	private lazy var notFoundImage: LottieAnimationView = {
		let image = LottieAnimationView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.heightAnchor.constraint(equalToConstant: 151).isActive = true
		image.widthAnchor.constraint(equalToConstant: 149).isActive = true
		image.animation = LottieAnimation.named("NotFound")
		image.loopMode = .loop
		image.play()
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
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.isNavigationBarHidden = true
		if !isSearched {
			self.viewModel.getRecommendationList()
		}
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
	}

	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		isSearched = true

	}

	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = .systemBackground
		self.setupView()
		self.bind()
	}

	func bind() {
		viewModel.$searchResult
			.receive(on: DispatchQueue.main)
			.sink { [weak self] data in
				if data.isEmpty {
					self?.hideNotFoundView(false)
					self?.hideRecommendedList(true)
				} else {
					self?.hideNotFoundView(true)
					self?.hideRecommendedList(false)
				}
				self?.tableView.reloadData()
			}
			.store(in: &anyCancellables)
	}

}

//MARK: - TableView
extension SearchViewController {

	func setupView() {
		self.view.addSubview(self.titleLabel)
		self.view.addSubview(self.recommendedLabel)
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
			tableView.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 35),
			tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

			recommendedLabel.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 10),
			recommendedLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),

			notFoundImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			notFoundImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			infoLabel.topAnchor.constraint(equalTo: notFoundImage.bottomAnchor, constant: 10),
			infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

		])
	}
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		viewModel.searchResult.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = self.tableView.dequeueReusableCell(withIdentifier: MovieViewCell.identifier, for: indexPath) as? MovieViewCell else { return UITableViewCell() }
		cell.configure(with: MoviesCellViewModel(movie: viewModel.searchResult[indexPath.row]))
		return cell
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let detailView = MovieDetailsViewController(id: viewModel.searchResult[indexPath.row].id)
		self.navigationController?.pushViewController(detailView, animated: true)
		tableView.deselectRow(at: indexPath, animated: true)
	}
}

//MARK: - API
extension SearchViewController: UITextFieldDelegate {

	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		guard let title = textField.text else { return true }
		self.viewModel.searchBy(title: title)
		textField.resignFirstResponder()
		return true
	}

	func hideNotFoundView(_ value: Bool) {
		notFoundImage.isHidden = value
		infoLabel.isHidden = value
	}

	func hideRecommendedList(_ value: Bool) {
		recommendedLabel.isHidden = value
	}
}
