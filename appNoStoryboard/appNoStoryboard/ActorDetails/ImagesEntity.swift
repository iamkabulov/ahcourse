//
//  ImagesEntity.swift
//  appNoStoryboard
//
//  Created by Nursultan Kabulov on 19.06.2024.
//

import Foundation

struct ImagesEntityRoot: Codable {
	let images: [ImagesEntity]?
}

struct ImagesEntity: Codable, Identifiable {
	let id: Int
	let profiles: [Profile]?
}

// MARK: - Profile
struct Profile: Codable {
	let aspectRatio: Double?
	let height: Int?
	let iso639_1: String?
	let filePath: String?
	let voteAverage: Double?
	let voteCount, width: Int?

	enum CodingKeys: String, CodingKey {
		case aspectRatio = "aspect_ratio"
		case height
		case iso639_1 = "iso_639_1"
		case filePath = "file_path"
		case voteAverage = "vote_average"
		case voteCount = "vote_count"
		case width
	}
}
