//
//  WatchListViewModel.swift
//  appNoStoryboard
//
//  Created by Nursultan Kabulov on 14.10.2024.
//

import Foundation
import Combine

class WatchListViewModel {

	private let userDefaults = WatchListUserDefaults.shared
	private let network = NetworkManager.shared
	@Published var watchList: [Int] = []

	func getFavMovies() {
		self.watchList = userDefaults.getMovies() ?? []
	}
}
