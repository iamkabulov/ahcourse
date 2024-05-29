//
//  ExternalIdsEntity.swift
//  appNoStoryboard
//
//  Created by Nursultan Kabulov on 29.05.2024.
//

import Foundation

// MARK: - ExternalIdsEntity
struct ExternalIdsEntity: Codable {
	let id: Int
	let imdbID, wikidataID, facebookID, instagramID: String
	let twitterID: String

	enum CodingKeys: String, CodingKey {
		case id
		case imdbID = "imdb_id"
		case wikidataID = "wikidata_id"
		case facebookID = "facebook_id"
		case instagramID = "instagram_id"
		case twitterID = "twitter_id"
	}
}

struct YoutubeIdEntity: Codable {
	let id: Int
	let results: [Videos]
}

// MARK: - Result
struct Videos: Codable {
	let iso639_1: ISO639_1
	let iso3166_1: ISO3166_1
	let name, key: String
	let site: Site
	let size: Int
	let type: String
	let official: Bool
	let publishedAt, id: String

	enum CodingKeys: String, CodingKey {
		case iso639_1 = "iso_639_1"
		case iso3166_1 = "iso_3166_1"
		case name, key, site, size, type, official
		case publishedAt = "published_at"
		case id
	}
}

enum ISO3166_1: String, Codable {
	case us = "US"
}

enum ISO639_1: String, Codable {
	case en = "en"
}

enum Site: String, Codable {
	case youTube = "YouTube"
}
