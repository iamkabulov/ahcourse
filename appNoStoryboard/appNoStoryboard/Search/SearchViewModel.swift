//
//  SearchViewModel.swift
//  appNoStoryboard
//
//  Created by Nursultan Kabulov on 17.10.2024.
//

import Foundation
import Combine

class SearchViewModel {

	private let network = NetworkManager.shared
	@Published var searchResult: [MovieList] = []

	func getRecommendationList() {
		self.network.recommendationList() { data in
			self.searchResult = data.results ?? []
		}
	}

	func searchBy(title: String) {
		self.network.searchByName(title) { result in
			self.searchResult = result.results ?? []
		}
	}
}
