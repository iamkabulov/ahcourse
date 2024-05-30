//
//  MovieDetailsViewController.swift
//  appNoStoryboard
//
//  Created by Nursultan Kabulov on 15.05.2024.
//

import UIKit
import SnapKit

class MovieDetailsViewController: UIViewController {
	
	private var id: Int
	private var movieData: MovieDetailEntity?
	private var castData: CastEntity?
	private var externalLinks: ExternalIdsEntity?
	private var youtubeId: YoutubeIdEntity?
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
		let stack = UIStackView(arrangedSubviews: [moviePoster, titleLabel, horizontalStackView, vStackOverview, castLabel, castCollectionView, linkLabel, hStackLink, hStackButton])
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .vertical
		stack.spacing = 40
		return stack
	}()

	private lazy var horizontalStackView: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [vStackDateAndGenre, vStackRateAndViews])
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .horizontal
		stack.distribution = .equalSpacing
		stack.alignment = .center
		stack.spacing = .zero
		return stack
	}()

	private lazy var vStackDateAndGenre: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [releaseDate, genreCollectionView])
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .vertical
		stack.spacing = 14
		stack.alignment = .center
		return stack
	}()

	private lazy var vStackRateAndViews: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [hStackRateImage, rateLabel, viewsLabel])
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .vertical
		stack.alignment = .center
		stack.spacing = 2
		return stack
	}()

	lazy var genreCollectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		let view = UICollectionView(
			frame: .zero,
			collectionViewLayout: layout
		)
		view.showsHorizontalScrollIndicator = false
		view.dataSource = self
		view.delegate = self
		view.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
		view.translatesAutoresizingMaskIntoConstraints = false
		view.heightAnchor.constraint(equalToConstant: 24).isActive = true
		view.widthAnchor.constraint(equalToConstant: 170).isActive = true
		return view
	}()

	private lazy var moviePoster: UIImageView = {
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.image = UIImage(named: "whiteBackground")
		image.contentMode = .scaleAspectFit
		image.heightAnchor.constraint(equalToConstant: 424).isActive = true
//		image.widthAnchor.constraint(equalToConstant: 309).isActive = true
		return image
	}()

	private lazy var hStackRateImage: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [rateImage, rateImage2, rateImage3, rateImage4, rateImage5])
		stack.translatesAutoresizingMaskIntoConstraints = false
//		stack.backgroundColor = .cyan
		stack.axis = .horizontal
		stack.distribution = .equalSpacing
		stack.alignment = .center
		stack.spacing = .zero
		stack.heightAnchor.constraint(equalToConstant: 18).isActive = true
		return stack
	}()

	private lazy var rateImage: UIImageView = {
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.image = UIImage(named: "ustar")
		image.widthAnchor.constraint(equalToConstant: 20).isActive = true
		image.contentMode = .scaleToFill
		return image
	}()

	private lazy var rateImage2: UIImageView = {
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.image = UIImage(named: "ustar")
		image.contentMode = .scaleToFill
		image.widthAnchor.constraint(equalToConstant: 20).isActive = true
		return image
	}()

	private lazy var rateImage3: UIImageView = {
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.image = UIImage(named: "ustar")
		image.contentMode = .scaleToFill
		image.widthAnchor.constraint(equalToConstant: 20).isActive = true
		return image
	}()

	private lazy var rateImage4: UIImageView = {
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.image = UIImage(named: "ustar")
		image.contentMode = .scaleToFill
		image.widthAnchor.constraint(equalToConstant: 20).isActive = true
		return image
	}()

	private lazy var rateImage5: UIImageView = {
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.image = UIImage(named: "ustar")
		image.contentMode = .scaleToFill
		image.widthAnchor.constraint(equalToConstant: 20).isActive = true
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
		let stack = UIStackView(arrangedSubviews: [
													UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 10)),
													overviewLabel,
													descriptionView,
													UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 5)),])
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.backgroundColor = .systemGray4
		stack.axis = .vertical
		stack.spacing = 30
		stack.distribution = .fill
		return stack
	}()

	private lazy var overviewLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textAlignment = .center
		label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
		label.text = "Overview"

		return label
	}()

	private lazy var castLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textAlignment = .center
//		label.backgroundColor = .brown
		label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
		label.text = "Cast"
		return label
	}()

	private lazy var castCollectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		let view = UICollectionView(
			frame: .zero,
			collectionViewLayout: layout
		)
		view.showsHorizontalScrollIndicator = false
		view.dataSource = self
		view.delegate = self
		view.register(CastCollectionViewCell.self, forCellWithReuseIdentifier: CastCollectionViewCell.identifier)
//		view.contentMode = .scaleAspectFit
		view.translatesAutoresizingMaskIntoConstraints = false
//		view.backgroundColor = .green
		view.heightAnchor.constraint(equalToConstant: 60).isActive = true
		return view
	}()

	private lazy var hStackLink: UIStackView = {
		let stack = UIStackView()
		stack.addSubview(imdb)
		stack.addSubview(youtube)
		stack.addSubview(facebook)
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .horizontal
		stack.heightAnchor.constraint(equalToConstant: 60).isActive = true
		return stack
	}()

	private lazy var linkLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textAlignment = .center
//		label.backgroundColor = .brown
		label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
		label.text = "Link"
		return label
	}()

	private lazy var imdb: UIButton = {
		let image = UIButton(type: .custom)
		image.setImage(UIImage(named: "imdb"), for: .normal)
		image.translatesAutoresizingMaskIntoConstraints = false
		image.widthAnchor.constraint(equalToConstant: 60).isActive = true
		image.heightAnchor.constraint(equalToConstant: 40).isActive = true
		image.contentMode = .scaleToFill
		image.addTarget(self, action: #selector(buttonHandler), for: .touchUpInside)
		return image
	}()

	private lazy var youtube: UIButton = {
		let image = UIButton(type: .custom)
		image.setImage(UIImage(named: "youtube"), for: .normal)
		image.translatesAutoresizingMaskIntoConstraints = false
		image.widthAnchor.constraint(equalToConstant: 60).isActive = true
		image.heightAnchor.constraint(equalToConstant: 40).isActive = true
		image.contentMode = .scaleToFill
		image.addTarget(self, action: #selector(buttonHandler), for: .touchUpInside)
		return image
	}()

	private lazy var facebook: UIButton = {
		let image = UIButton(type: .custom)
		image.setImage(UIImage(named: "meta"), for: .normal)
		image.translatesAutoresizingMaskIntoConstraints = false
		image.widthAnchor.constraint(equalToConstant: 60).isActive = true
		image.heightAnchor.constraint(equalToConstant: 40).isActive = true
		image.contentMode = .scaleToFill
		image.addTarget(self, action: #selector(buttonHandler), for: .touchUpInside)
		return image
	}()

	private lazy var descriptionView: UITextView = {
		let label = UITextView()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.isUserInteractionEnabled = false
		label.sizeToFit()
		label.isScrollEnabled = false
		label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
		label.backgroundColor = .systemGray4
		label.text = ""
//		label.heightAnchor.constraint(equalToConstant: 250).isActive = true
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
		return label
	}()

	private lazy var releaseDate: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.systemFont(ofSize: 20, weight: .light)
		label.text = "Release date"
		return label
	}()

	private lazy var hStackButton: UIStackView = {
		let stack = UIStackView()
		stack.addSubview(addWatchList)
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .horizontal
		stack.heightAnchor.constraint(equalToConstant: 60).isActive = true
		return stack
	}()

	private lazy var addWatchList: UIButton = {
		let button = UIButton(type: .custom)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.addTarget(self, action: #selector(addToWatchList), for: .touchUpInside)
		button.heightAnchor.constraint(equalToConstant: 40).isActive = true
		button.layer.cornerRadius = 15
		button.clipsToBounds = true
		return button
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
		self.navigationController?.navigationBar.topItem?.title = ""
		self.navigationController?.navigationBar.tintColor = .black
		setupView()
		getDetailInfo(id: id)
		genreCollectionView.reloadData()
		getCastInfo(id)
		castCollectionView.reloadData()
		loadExternalIds(id)
		loadYoutubeId(id)
		isAdded()
	}
}

extension MovieDetailsViewController {
	@objc func buttonHandler(_ sender: UIButton) {
		switch sender {
		case imdb:
			guard let id = externalLinks?.imdbID else { return }
			print(id)
			UIApplication.shared.open(URL(string: "https://www.imdb.com/title/\(id)")!)
		case facebook:
			guard let id = externalLinks?.facebookID else { return }
			print(id)
			UIApplication.shared.open(URL(string: "https://www.facebook.com/\(id)")!)
		case youtube:
			guard let id = youtubeId?.results[0].key else { return }
			print(id)
			UIApplication.shared.open(URL(string: "https://www.youtube.com/watch?v=\(id)")!)
		default:
			print("other")
		}
	}

	@objc func addToWatchList(_ sender: UIButton) {
		guard let name = sender.title(for: .normal) else { return }
		if name == "Add to Watch List" {
			WatchListUserDefaults.shared.saveMovie(with: id)
		} else if name == "Remove from Watch List" {
			WatchListUserDefaults.shared.deleteMovie(with: id)
		}
		isAdded()
	}

	func isAdded() {
		if WatchListUserDefaults.shared.findMovieBy(id: id) {
			addWatchList.setTitle("Remove from Watch List", for: .normal)
			addWatchList.backgroundColor = .red
			addWatchList.tintColor = .white
		} else {
			addWatchList.setTitle("Add to Watch List", for: .normal)
			addWatchList.backgroundColor = UIColor(red: 0.16, green: 0.38, blue: 0.94, alpha: 1.00)
			addWatchList.tintColor = .white
		}
	}

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
			stackView.leadingAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.leadingAnchor, constant: 0),
			stackView.trailingAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.trailingAnchor, constant: 0),
			stackView.bottomAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.bottomAnchor, constant: 0),
			stackView.widthAnchor.constraint(equalTo: self.scrollView.frameLayoutGuide.widthAnchor, constant: 0),

			descriptionView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
			descriptionView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),

			releaseDate.leadingAnchor.constraint(equalTo: vStackDateAndGenre.leadingAnchor, constant: 10),
			genreCollectionView.leadingAnchor.constraint(equalTo: vStackDateAndGenre.leadingAnchor, constant: 10),

			hStackRateImage.trailingAnchor.constraint(equalTo: vStackRateAndViews.trailingAnchor, constant: -10),
			rateLabel.trailingAnchor.constraint(equalTo: vStackRateAndViews.trailingAnchor, constant: -10),
			viewsLabel.trailingAnchor.constraint(equalTo: vStackRateAndViews.trailingAnchor, constant: -10),
			imdb.leadingAnchor.constraint(equalTo: hStackLink.leadingAnchor, constant: 96),
			facebook.leadingAnchor.constraint(equalTo: imdb.trailingAnchor, constant: 10),
			youtube.leadingAnchor.constraint(equalTo: facebook.trailingAnchor, constant: 10),
			addWatchList.leadingAnchor.constraint(equalTo: hStackButton.leadingAnchor, constant: 80),
			addWatchList.trailingAnchor.constraint(equalTo: hStackButton.trailingAnchor, constant: -80),
			addWatchList.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: -10)
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

					self.movieData = response
					guard let detail = self.movieData else { return }
					DispatchQueue.main.async {
						self.setData(detail)
					}
					self.loadImage(from: detail.posterPath ?? "")
					genreCollectionView.reloadData()
					return
				} catch {
					return print(error)
				}
			}
		}.resume()
	}

	func getCastInfo(_ id: Int) {
		self.urlComponent.path = "/3/movie/\(id)/credits"

		guard let requestUrl = self.urlComponent.url else { return }

		session.dataTask(with: requestUrl) { data, response, error in
			DispatchQueue.main.async(flags: .barrier) { [self] in
				guard let data = data, error == nil else {
					return
				}
				do {
					let response = try JSONDecoder().decode(CastEntity.self, from: data)
					self.castData = response
					guard self.castData != nil else { return }

					castCollectionView.reloadData()
					return
				} catch {
					return print(error)
				}
			}
		}.resume()
	}

	func loadImage(from url: String) {
		if let urlString = URL(string: "https://image.tmdb.org/t/p/w500\(url)") {
			DispatchQueue.global().async {
				guard let data = try? Data(contentsOf: urlString), let image = UIImage(data: data) else {
					return
				}
				DispatchQueue.main.async {
					self.moviePoster.image = image
				}
			}
		}
	}

	func loadExternalIds(_ id: Int) {
		self.urlComponent.path = "/3/movie/\(id)/external_ids"

		guard let requestUrl = self.urlComponent.url else { return }

		session.dataTask(with: requestUrl) { data, response, error in
			DispatchQueue.main.async(flags: .barrier) { [self] in
				guard let data = data, error == nil else {
					return
				}
				do {
					let response = try JSONDecoder().decode(ExternalIdsEntity.self, from: data)
					self.externalLinks = response
					return
				} catch {
					return print(error)
				}
			}
		}.resume()
	}

	func loadYoutubeId(_ id: Int) {
		self.urlComponent.path = "/3/movie/\(id)/videos"

		guard let requestUrl = self.urlComponent.url else { return }

		session.dataTask(with: requestUrl) { data, response, error in
			DispatchQueue.main.async(flags: .barrier) { [self] in
				guard let data = data, error == nil else {
					return
				}
				do {
					let response = try JSONDecoder().decode(YoutubeIdEntity.self, from: data)
					self.youtubeId = response
					return
				} catch {
					return print(error)
				}
			}
		}.resume()
	}

	func setData(_ movieDetail: MovieDetailEntity) {
		let rate = movieDetail.voteAverage ?? 0
		let views = movieDetail.voteCount ?? 0

		titleLabel.text = movieDetail.originalTitle
		rateLabel.text = movieDetail.originalLanguage
		releaseDate.text = movieDetail.releaseDate
		titleLabel.text = movieDetail.originalTitle
		rateLabel.text = "\(rate)/10"
		viewsLabel.text = "\(views)"
		descriptionView.text = movieDetail.overview
		rateImagesCalculate(movieDetail.voteAverage ?? 6.0)
	}

	func rateImagesCalculate(_ rate: Double) {
		let result = rate / 2
		let whole = Int(floor(result))
		let decimal = result.truncatingRemainder(dividingBy: 1)
		setRateImages(whole: whole, decimal: decimal)
	}

	func setRateImages(whole: Int, decimal: Double) {
		let imagesView = [rateImage, rateImage2, rateImage3, rateImage4, rateImage5]
		for i in 0..<whole {
			imagesView[i].image = UIImage(named: "fstar")
		}
		if whole > 0 {
			imagesView[whole].image = UIImage(named: "pstar")
		}
	}

	@objc func buttonTapped() {
		print("Button Tapped")
	}
}


extension MovieDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		if collectionView == genreCollectionView {
			guard let data = movieData else { return 2 }
			guard let genres = data.genres else { return 2 }
			return genres.count
		}
		else if collectionView == castCollectionView {
			return self.castData?.cast.count ?? 1
		}
		return 10
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		if collectionView == genreCollectionView {
			guard let cell = self.genreCollectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }
			guard let data = movieData else {

				cell.nameOfButton.text = "Genre"
				return cell
			}
			cell.nameOfButton.textColor = .white
			cell.contentView.backgroundColor = .blue
			cell.nameOfButton.text = data.genres?[indexPath.row].name
			return cell
		} 
		else if collectionView == castCollectionView {
			guard let cell = self.castCollectionView.dequeueReusableCell(withReuseIdentifier: CastCollectionViewCell.identifier, for: indexPath) as? CastCollectionViewCell else { return UICollectionViewCell() }
			guard let data = self.castData else {
				cell.setData( Cast(adult: true,
									 gender: 1,
									 id: 1,
									 knownForDepartment: "A",
									 name: "Tom",
									 originalName: "Hardy",
									 popularity: 2.0,
									 profilePath: nil,
									 castID: nil,
									 character: "Venom",
									 creditID: "id",
									 order: nil,
									 department: "AS",
									 job: "NOP"))
				return cell
			}
			cell.setData(data.cast[indexPath.row])
			return cell
		}
		return UICollectionViewCell()
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		if collectionView == genreCollectionView {
			return CGSize(width: 80, height: 24)
		}
		else if collectionView == castCollectionView {
			return CGSize(width: 200, height: 60)
		}
		return CGSize(width: 100, height: 100)
	}
}
