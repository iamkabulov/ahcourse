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
		let stack = UIStackView(arrangedSubviews: [moviePoster, titleLabel, horizontalStackView, vStackOverview])
		stack.translatesAutoresizingMaskIntoConstraints = false
//		stack.backgroundColor = .red
		stack.axis = .vertical
//		stack.contentMode = .center
//		stack.distribution = .equalSpacing
//		stack.alignment = .center

		stack.spacing = 40
		return stack
	}()

	private lazy var horizontalStackView: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [vStackDateAndGenre, vStackRateAndViews])
		stack.translatesAutoresizingMaskIntoConstraints = false
//		stack.backgroundColor = .gray
		stack.axis = .horizontal
		stack.distribution = .equalSpacing
		stack.alignment = .center
		stack.spacing = .zero
		return stack
	}()

	private lazy var vStackDateAndGenre: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [releaseDate, genreCollectionView])
		stack.translatesAutoresizingMaskIntoConstraints = false
//		stack.backgroundColor = .cyan
		stack.axis = .vertical
		stack.spacing = 14
//		stack.alignment = .leading
//		stack.distribution = .equalSpacing
		return stack
	}()

	private lazy var vStackRateAndViews: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [rateImage, rateLabel, viewsLabel])
		stack.translatesAutoresizingMaskIntoConstraints = false
//		stack.backgroundColor = .cyan
		stack.axis = .vertical
		stack.alignment = .center
		stack.spacing = 2
//		stack.distribution = .fillProportionally
		return stack
	}()

	lazy var genreCollectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		let view = UICollectionView(
			frame: .zero,
			collectionViewLayout: layout
		)

		view.dataSource = self
		view.delegate = self
		view.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
//		view.contentMode = .scaleAspectFit
		view.translatesAutoresizingMaskIntoConstraints = false
//		view.backgroundColor = .green
		return view
	}()

	private lazy var moviePoster: UIImageView = {
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.image = UIImage(named: "movie")
		image.contentMode = .scaleAspectFit
		return image
	}()

	private lazy var rateImage: UIImageView = {
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.image = UIImage(named: "sampleRate")
		image.contentMode = .scaleAspectFit
		return image
	}()

	private lazy var rateLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textAlignment = .center
		label.font = UIFont.systemFont(ofSize: 16, weight: .regular)

		return label
	}()

	private lazy var vStackOverview: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [overviewLabel, descriptionView])
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.backgroundColor = .systemGray4
		stack.axis = .vertical
		stack.alignment = .center
		stack.spacing = .zero
		stack.heightAnchor.constraint(equalToConstant: 250).isActive = true
//		stack.distribution = .fillProportionally
		return stack
	}()

	private lazy var overviewLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textAlignment = .center
		label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
		label.text = "Overview"

		return label
	}()

	private lazy var descriptionView: UITextView = {
		let label = UITextView()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
		label.backgroundColor = .systemGray4
		label.text = ""
		label.heightAnchor.constraint(equalToConstant: 150).isActive = true
		return label
	}()

	private lazy var viewsLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textAlignment = .center
		label.font = UIFont.systemFont(ofSize: 14, weight: .light)
		label.textColor = .gray
		label.text = movieData?.imdbID
		return label
	}()

	private lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textAlignment = .center
		label.font = UIFont.systemFont(ofSize: 48, weight: .bold)
		label.numberOfLines = 0
		label.text = movieData?.originalTitle
		return label
	}()

	private lazy var releaseDate: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
//		label.textAlignment = .
		label.font = UIFont.systemFont(ofSize: 20, weight: .light)
		label.text = "movieData?.releaseDate"
		return label
	}()

	init(id: Int) {
		self.id = id
		print(id)
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
		genreCollectionView.reloadData()
	}
}

extension MovieDetailsViewController {
	func setupView() {
		view.addSubview(scrollView)
		scrollView.addSubview(stackView)
		NSLayoutConstraint.activate([
			//SCROLL
			scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
			scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
			scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
			scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
			//STACK
			stackView.topAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.topAnchor, constant: 0),
			stackView.leadingAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.leadingAnchor, constant: 10),
			stackView.trailingAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.trailingAnchor, constant: -10),
			stackView.bottomAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.bottomAnchor, constant: 0),
			stackView.widthAnchor.constraint(equalTo: self.scrollView.frameLayoutGuide.widthAnchor, constant: -20),
			//POSTER
//			moviePoster.topAnchor.constraint(equalTo: self.stackView.topAnchor),
//			moviePoster.leadingAnchor.constraint(equalTo: self.stackView.leadingAnchor),
//			moviePoster.trailingAnchor.constraint(equalTo: self.stackView.trailingAnchor),
			//OTHERS
//			horizontalStackView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor),
//			horizontalStackView.heightAnchor.constraint(equalToConstant: 100),
//			releaseDate.leadingAnchor.constraint(equalTo: vStackDateAndGenre.leadingAnchor, constant: 15),
//			genreCollectionView.leadingAnchor.constraint(equalTo: releaseDate.leadingAnchor),
//			rateImage.trailingAnchor.constraint(equalTo: vStackRateAndViews.trailingAnchor, constant: -15),

			genreCollectionView.widthAnchor.constraint(equalToConstant: 170),
			genreCollectionView.heightAnchor.constraint(equalToConstant: 24),

			descriptionView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
			descriptionView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
		])

		//CHCR
		descriptionView.setContentHuggingPriority(.defaultHigh, for: .vertical)
//		moviePoster.setContentHuggingPriority(.defaultHigh, for: .horizontal)
//		rateImage.setContentHuggingPriority(.defaultHigh, for: .vertical)
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

					self.movieData = response
					guard let detail = self.movieData else { return }
					DispatchQueue.main.async {
						self.setData(detail)
					}
					genreCollectionView.reloadData()
					return
				} catch {
					return print(error)
				}
			}
		}.resume()
	}

	func setData(_ movieDetail: MovieDetailEntity) {
		rateLabel.text = movieDetail.originalLanguage
		releaseDate.text = movieDetail.releaseDate
		titleLabel.text = movieDetail.originalTitle
		rateLabel.text = "\(movieDetail.voteAverage)/10"
		viewsLabel.text = "\(movieDetail.voteCount)"
		descriptionView.text = movieDetail.overview
	}
}


extension MovieDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		guard let data = movieData else { return 2 }
		return data.genres.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = self.genreCollectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }
		guard let data = movieData else {

			cell.nameOfButton.text = "Genre"
			return cell
		}
		cell.nameOfButton.textColor = .white
		cell.contentView.backgroundColor = .blue
		cell.nameOfButton.text = data.genres[indexPath.row].name
		return cell
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: 80, height: 24)
	}
}
