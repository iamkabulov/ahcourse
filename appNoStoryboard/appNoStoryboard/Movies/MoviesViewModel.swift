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

	func loadMovies(_ path: String) {
		switch path {
		case "Upcoming":
			networking.getUpcomingMovies { result in
				self.model = result
			}
		case "Popular":
			networking.getPopularMovies { result in
				self.model = result
			}
		case "Now Playing":
			networking.getNowPlaying { result in
				self.model = result
			}
		case "Top Rated":
			networking.getTopRated { result in
				self.model = result
			}
		default:
			print("Something went wrong.")
		}
	}
}
