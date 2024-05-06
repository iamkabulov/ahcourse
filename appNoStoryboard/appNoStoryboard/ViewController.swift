//
//  ViewController.swift
//  appNoStoryboard
//
//  Created by Nursultan Kabulov on 27.04.2024.
//

import UIKit

class ViewController: UIViewController {


	var dataSource = ["Hypc", "Zhanibek", "Kanat"]
	var dataSource2 = ["Mc", "Name", "Last"]
	lazy var tableView: UITableView = {
		let view = UITableView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.register(UITableViewCell.self, forCellReuseIdentifier: "Identifier")
		view.delegate = self
		view.dataSource = self
		return view
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = .systemBackground
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
			tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
		])
	}
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		dataSource.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = self.tableView.dequeueReusableCell(withIdentifier: "Identifier", for: indexPath)
		var content = cell.defaultContentConfiguration()

		content.text = dataSource[indexPath.row]
		content.secondaryText = dataSource2[indexPath.row]
		cell.contentConfiguration = content
		return cell

	}
	

}

