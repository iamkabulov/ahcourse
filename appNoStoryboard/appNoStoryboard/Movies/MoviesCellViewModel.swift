//
//  MoviesCellViewModel.swift
//  appNoStoryboard
//
//  Created by Nursultan Kabulov on 07.10.2024.
//

import Foundation
import Combine
import UIKit

final class MoviesCellViewModel {

	private let networking = NetworkManager.shared
	private let coreData = MoviesCoreData.shared
	private var cancellables = Set<AnyCancellable>()

	@Published var title: String?
	@Published var isFav: Bool?
	@Published var image: UIImage?
	@Published var state: ViewStates = .none
	var id: Int?
	var path: String?

	init(movie: MovieList) {
		self.title = movie.title ?? ""
		self.id = movie.id
		self.path = movie.posterPath
		self.isFav = coreData.isFav(by: movie.id)
		self.getImage(path: movie.posterPath ?? "")
	}

	init(favMovie: FavouriteMovies) {
		self.title = favMovie.title
		self.id = favMovie.id
		self.path = favMovie.posterPath
		self.isFav = coreData.isFav(by: favMovie.id)
		self.getImage(path: favMovie.posterPath)
	}

	init(id: Int) {
		self.id = id
		self.loadMovieInfo(id: id)
	}

	func getImage(path: String) {
		state = .loading
		networking.loadImage(from: path) { img in
			self.image = img
			self.state = .success
		}
	}

	func toggleFavorite() {
		guard let id = self.id, let path = self.path else { return }
		if coreData.isFav(by: id) {
			coreData.deleteNote(id: id)
		} else {
			let note = FavouriteMovies(id: id,
									   title: title ?? "",
									   posterPath: path)
			coreData.saveNote(note)
		}
		self.isFav = coreData.isFav(by: id)
	}


	func loadMovieInfo(id: Int) {
		networking.getDetailInfo(id: id) { data in
			self.title = data.title
			self.getImage(path: data.posterPath ?? "")
		}
	}
}
