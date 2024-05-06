//
//  ViewController.swift
//  appNoStoryboard
//
//  Created by Nursultan Kabulov on 27.04.2024.
//

import UIKit

class ViewController: UIViewController {

	var dataSource: [MovieTitle] = Array(repeating: MovieTitle(titleLabel: "Uncharted", image: UIImage(named: "movie")), count: 10)
	
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

	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = .blue
		self.addView()
		self.setupView()
	}


}

extension ViewController {
	func addView() {
//		self.title = "TABLEVIEW"

	}

	func setupView() {
		self.view.addSubview(self.tableView)
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
		])
	}
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		dataSource.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = self.tableView.dequeueReusableCell(withIdentifier: MovieViewCell.identifier, for: indexPath) as? MovieViewCell else { return UITableViewCell() }

		cell.setData(movie: dataSource[indexPath.row])
		return cell

	}
	

}

