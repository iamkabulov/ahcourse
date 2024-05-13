//
//  ViewController.swift
//  appNoStoryboard
//
//  Created by Nursultan Kabulov on 27.04.2024.
//
//9863b0919782bd200569d84cf236247b
import UIKit

class ViewController: UIViewController {

	var dataSource: [MovieTitle] = Array(repeating: MovieTitle(titleLabel: "Uncharted", image: UIImage(named: "movie")), count: 10)
	var movieData: [Result] = []
	
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
		self.apiRequest()
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
		movieData.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		guard let cell = self.tableView.dequeueReusableCell(withIdentifier: MovieViewCell.identifier, for: indexPath) as? MovieViewCell else { return UITableViewCell() }
		cell.setImage(img: nil)
		cell.setData(movie: movieData[indexPath.row])
		getImage(path: movieData[indexPath.row].posterPath, cell: cell)
		return cell

	}
}

extension ViewController {

	func apiRequest() {
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
					print(data ?? "")
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

	func getImage(path: String, cell: MovieViewCell) {
		print(path)
		if let urlString = URL(string: "https://image.tmdb.org/t/p/w500\(path)") {
			DispatchQueue.global(qos: .background).async {
				if let data = try? Data(contentsOf: urlString) {
					DispatchQueue.main.async {
						cell.setImage(img: UIImage(data: data))
					}
				}
			}
		}
	}
}
