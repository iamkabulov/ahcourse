//
//  FavouritesViewModel.swift
//  appNoStoryboard
//
//  Created by Nursultan Kabulov on 08.10.2024.
//

import Foundation
import Combine

class FavouritesViewModel {

	private let coreData = MoviesCoreData.shared
	@Published var favMovies: [FavouriteMovies] = []

	func getFavMovies() {
		coreData.loadNotes { data in
			self.favMovies = data
		}
	}
}
