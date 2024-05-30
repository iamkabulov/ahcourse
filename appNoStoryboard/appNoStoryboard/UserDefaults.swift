//
//  UserDefaults.swift
//  appNoStoryboard
//
//  Created by Nursultan Kabulov on 30.05.2024.
//

import Foundation



final class WatchListUserDefaults {
	static let shared = WatchListUserDefaults()
	private let standart = UserDefaults.standard
	private let key = "WatchList"

	func saveMovie(with: Int) {
		var ids = [Int]()
		guard var movies = self.getMovies() else {
			ids.append(with)
			standart.set(ids, forKey: key)
			print("Something wrong in UserDefaults")
			return
		}
		let isExist = movies.first { id in
			if id == with {
				return true
			}
			return false
		}

		if isExist == nil {
			movies.append(with)
			standart.set(movies, forKey: key)
		}
	}

	func getMovies() -> [Int]? {
		standart.array(forKey: key) as? [Int]
	}

	func findMovieBy(id: Int) -> Bool {
		guard let movies = standart.array(forKey: key) as? [Int] else { return false }
		let id = movies.filter { $0 == id }
		if !id.isEmpty {
			return true
		}
		return false
	}

	func deleteMovie(with id: Int) {
		if findMovieBy(id: id) {
			guard let movies = self.getMovies() else { return }
			let edited = movies.filter { $0 != id }
			standart.removeObject(forKey: key)
			standart.set(edited, forKey: key)
		}
	}
}
