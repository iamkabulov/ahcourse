//
//  ActorDetailsViewController.swift
//  appNoStoryboard
//
//  Created by Nursultan Kabulov on 04.06.2024.
//

import UIKit
import SnapKit

class ActorDetailsViewController: UIViewController {
	//MARK: - Properties
	private var id: Int
	private var actorData: ActorEntity?
	private var externalLinks: ExternalIdsEntity?
	private var youtubeId: YoutubeIdEntity?

	//MARK: - ScrollViewComponent
	private lazy var scrollView: UIScrollView = {
		let scroll = UIScrollView()
		scroll.translatesAutoresizingMaskIntoConstraints = false
		scroll.showsVerticalScrollIndicator = true
		scroll.showsHorizontalScrollIndicator = false
		return scroll
	}()

	//MARK: - StackViewComponent
	private lazy var stackView: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [actorPoster, titleStackView, vStackOverview, castLabel, photos, castCollectionView, linkLabel, hStackLink, hStackButton])
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .vertical
		stack.spacing = 30
		return stack
	}()

	//MARK: - PosterViewComponent
	private lazy var actorPoster: UIImageView = {
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.image = UIImage(named: "whiteBackground")
		image.contentMode = .scaleAspectFit
		image.heightAnchor.constraint(equalToConstant: 424).isActive = true
		return image
	}()

	//MARK: - TitleView
	private lazy var titleStackView: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [titleLabel,
												   birthday,
												   placeOfBirth,
												   death
												  ])
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .vertical
		stack.spacing = 0
		stack.distribution = .fill
		return stack
	}()

	private lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textAlignment = .center
		label.font = UIFont.systemFont(ofSize: 48, weight: .bold)
		label.numberOfLines = 0
		return label
	}()

	private lazy var birthday: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textAlignment = .center
		label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
		return label
	}()

	private lazy var placeOfBirth: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textAlignment = .center
		label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
		return label
	}()

	private lazy var death: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textAlignment = .center
		label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
		return label
	}()

	//MARK: - OverViewComponent
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
		label.text = "Bio"

		return label
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

	//MARK: - Photos
	private lazy var photos = PhotoView()

	//MARK: - CastViewComponent
	private lazy var castLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textAlignment = .center
//		label.backgroundColor = .brown
		label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
		label.text = "Photo"
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

	//MARK: - LinkViewComponent
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
		label.text = "Movie"
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
	//MARK: - ButtonComponent
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
		button.heightAnchor.constraint(equalToConstant: 40).isActive = true
		button.layer.cornerRadius = 15
		button.clipsToBounds = true
		return button
	}()

	//MARK: - ViewLifeCycle
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
		self.navigationController?.navigationBar.topItem?.title = ""
		self.navigationController?.navigationBar.tintColor = .black
		self.navigationController?.isNavigationBarHidden = false
		setupView()
		getDetailInfo(id: id)
		castCollectionView.reloadData()
		loadExternalIds(id)
		loadYoutubeId(id)
		loadImages(id)
	}
}

extension ActorDetailsViewController {
	//MARK: - AttributedText
	func setAttributedText(prefix: String, value: String) -> NSMutableAttributedString {
		let arr = NSMutableAttributedString(string: "\(prefix) ", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20, weight: .bold)])
		arr.append(NSMutableAttributedString(string: value))
		return arr
	}

	//MARK: - Methods
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
			guard let id = youtubeId?.results, !id.isEmpty else { return }
			print(id)
			UIApplication.shared.open(URL(string: "https://www.youtube.com/watch?v=\(id[0].key)")!)
		default:
			print("other")
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

			imdb.leadingAnchor.constraint(equalTo: hStackLink.leadingAnchor, constant: 96),
			facebook.leadingAnchor.constraint(equalTo: imdb.trailingAnchor, constant: 10),
			youtube.leadingAnchor.constraint(equalTo: facebook.trailingAnchor, constant: 10),
			addWatchList.leadingAnchor.constraint(equalTo: hStackButton.leadingAnchor, constant: 80),
			addWatchList.trailingAnchor.constraint(equalTo: hStackButton.trailingAnchor, constant: -80),
			addWatchList.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: -10)
		])
	}

	func setData(_ data: ActorEntity) {
		titleLabel.text = data.name
		descriptionView.text = data.biography
		birthday.attributedText = setAttributedText(prefix: "Born", value: data.birthday ?? "")
		placeOfBirth.text = data.placeOfBirth
		death.attributedText = setAttributedText(prefix: "Death", value: data.deathday ?? "")
	}

	//MARK: - API
	func getDetailInfo(id: Int) {
		NetworkManager.shared.getActorDetailInfo(id: id) { response in
			self.actorData = response
			guard let detail = self.actorData else { return }
			DispatchQueue.main.async { [self] in
				self.setData(detail)
			}
			NetworkManager.shared.loadImage(from: detail.profilePath ?? "" ) { img in
				DispatchQueue.main.async {
					self.actorPoster.image = img
				}
			}
		}
	}

	func loadExternalIds(_ id: Int) {
		NetworkManager.shared.loadExternalIds(id) { response in
			self.externalLinks = response
		}
	}

	func loadYoutubeId(_ id: Int) {
		NetworkManager.shared.loadYoutubeId(id) { response in
			self.youtubeId = response
		}
	}

	func loadImages(_ personId: Int) {
		NetworkManager.shared.loadImages(personId) { response in
			self.loadImagesForView(response.profiles ?? [])
		}
	}

	func loadImagesForView(_ data: [Profile]) {
//		for profile in data {
//			NetworkManager.shared.loadImage(from: profile.filePath ?? "") { img in
//				self.photos.setImage(img)
//			}
//		}
	}
}

//MARK: - CollectionViewDelegate
extension ActorDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 4
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = self.castCollectionView.dequeueReusableCell(withReuseIdentifier: CastCollectionViewCell.identifier, for: indexPath) as? CastCollectionViewCell else { return UICollectionViewCell() }

		return cell
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		if collectionView == castCollectionView {
			return CGSize(width: 200, height: 60)
		}
		return CGSize(width: 100, height: 100)
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
	}
}

