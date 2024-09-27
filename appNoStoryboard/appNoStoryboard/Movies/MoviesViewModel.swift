//
//  MoviesViewModel.swift
//  appNoStoryboard
//
//  Created by Nursultan Kabulov on 26.08.2024.
//

import Foundation
import Combine

enum ViewStates {
	case loading
	case failed
	case success
	case none
}
class MoviesViewModel {

	private let networking = NetworkManager.shared

	@Published var model: [MovieList] = []
	@Published var state: ViewStates = .none

	init() {
	}

	func loadMovies(_ path: String) {
		state = .loading
		switch path {
		case "Upcoming":
			networking.getUpcomingMovies { result in
				self.model = result
				self.state = .success
			}
		case "Popular":
			networking.getPopularMovies { result in
				self.model = result
				self.state = .success
			}
		case "Now Playing":
			networking.getNowPlaying { result in
				self.model = result
				self.state = .success
			}
		case "Top Rated":
			networking.getTopRated { result in
				self.model = result
				self.state = .success
			}
		default:
			print("Something went wrong.")
		}
	}
}
