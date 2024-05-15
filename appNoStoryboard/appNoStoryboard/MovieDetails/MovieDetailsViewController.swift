//
//  MovieDetailsViewController.swift
//  appNoStoryboard
//
//  Created by Nursultan Kabulov on 15.05.2024.
//

import UIKit

class MovieDetailsViewController: UIViewController {
	
	private var id: Int
	private var movieData: MovieDetailEntity?
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

	private lazy var scrollView: UIScrollView = {
		let scroll = UIScrollView()
		scroll.translatesAutoresizingMaskIntoConstraints = false
		scroll.showsVerticalScrollIndicator = true
		scroll.showsHorizontalScrollIndicator = false
		return scroll
	}()
	
	private lazy var stackView: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [movieImage, titleLabel, releaseDate])
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.backgroundColor = .red
		stack.axis = .vertical
		stack.distribution = .fillProportionally
		stack.alignment = .center
		return stack
	}()

	private lazy var movieImage: UIImageView = {
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.image = UIImage(named: "movie")
		image.layer.masksToBounds = true
		return image
	}()

	private lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textAlignment = .center
		label.font = UIFont.systemFont(ofSize: 48, weight: .bold)
		label.text = "\(id)"
		return label
	}()

	private lazy var releaseDate: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textAlignment = .left
		label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
		label.text = "\(id)"
		return label
	}()

	init(id: Int) {
		self.id = id
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = .white
		self.title = "Movie"
//		self.view = self.scrollView
		setupView()
		getDetailInfo(id: id)
	}
}

extension MovieDetailsViewController {
	func setupView() {
		view.addSubview(scrollView)
		scrollView.addSubview(stackView)
		NSLayoutConstraint.activate([
			scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
			scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
			scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
			scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
//			stackView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
//			stackView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
//			stackView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
//			stackView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
			stackView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor, multiplier: 1),
			stackView.heightAnchor.constraint(equalTo: self.scrollView.heightAnchor, multiplier: 1),
			
			movieImage.topAnchor.constraint(equalTo: self.stackView.topAnchor),
//			movieImage.leadingAnchor.constraint(equalTo: self.stackView.leadingAnchor, constant: 20),
//			movieImage.trailingAnchor.constraint(equalTo: self.stackView.trailingAnchor, constant: -20),
			movieImage.heightAnchor.constraint(equalToConstant: 424),
			titleLabel.topAnchor.constraint(equalTo: movieImage.bottomAnchor),
			titleLabel.leadingAnchor.constraint(equalTo: self.stackView.leadingAnchor, constant: 10),
			titleLabel.trailingAnchor.constraint(equalTo: self.stackView.trailingAnchor, constant: -10),

			releaseDate.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor),
			releaseDate.leadingAnchor.constraint(equalTo: self.stackView.leadingAnchor, constant: 15)


		])
	}


	func getDetailInfo(id: Int) {
		self.urlComponent.path = "/3/movie/\(id)"

		guard let requestUrl = self.urlComponent.url else { return }

		session.dataTask(with: requestUrl) { data, response, error in
			DispatchQueue.main.async(flags: .barrier) { [self] in
				guard let data = data, error == nil else {
					return
				}
				do {
					let response = try JSONDecoder().decode(MovieDetailEntity.self, from: data)
					movieData = response
					return
				} catch {
					return print(error)
				}
			}
		}.resume()
	}
}
