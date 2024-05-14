//
//  PopularMovieEntity.swift
//  appNoStoryboard
//
//  Created by Nursultan Kabulov on 14.05.2024.
//

import Foundation

// MARK: - Popular
struct PopularMovieEntity: Codable {
	let page: Int
	let results: [List]
	let totalPages, totalResults: Int

	enum CodingKeys: String, CodingKey {
		case page, results
		case totalPages = "total_pages"
		case totalResults = "total_results"
	}
}
