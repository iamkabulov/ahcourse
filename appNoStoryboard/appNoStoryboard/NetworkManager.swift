//
//  NetworkManager.swift
//  appNoStoryboard
//
//  Created by Nursultan Kabulov on 22.05.2024.
//

import Foundation
import UIKit


class NetworkManager {
	
	static let shared = NetworkManager()
	private let session = URLSession(configuration: .default)
	private let apiKey = "9863b0919782bd200569d84cf236247b"
	lazy private var urlComponent: URLComponents = {
		var component = URLComponents()
		component.scheme = "https"
		component.host = "api.themoviedb.org"
		
		component.queryItems = [
			URLQueryItem(name: "api_key", value: apiKey)
		]
		return component
	}()



	func getUpcomingMovies(completionHandler: @escaping ([List]) -> Void) {
		self.urlComponent.path = "/3/movie/upcoming"

		guard let requestUrl = self.urlComponent.url else { return }

		session.dataTask(with: requestUrl) { data, response, error in
			guard let data = data, error == nil else {
				return
			}
			do {
				let response = try JSONDecoder().decode(MovieEntity.self, from: data)
				completionHandler(response.results)
				return
			} catch {
				return print(error)
			}
		}.resume()
	}

	func getPopularMovies(completionHandler: @escaping ([List]) -> Void) {
		self.urlComponent.path = "/3/movie/popular"
		guard let requestUrl = urlComponent.url else { return }

		self.session.dataTask(with: requestUrl) { data, response, error in
			guard let data = data, error == nil else {
				print(data ?? "")
				return
			}
			do {
				let response = try JSONDecoder().decode(MovieEntity.self, from: data)
				completionHandler(response.results)
				return
			} catch {
				return print(error)
			}
		}.resume()
	}

	func getNowPlaying(completionHandler: @escaping ([List]) -> Void) {
		self.urlComponent.path = "/3/movie/now_playing"

		guard let requestUrl = self.urlComponent.url else { return }

		session.dataTask(with: requestUrl) { data, response, error in
			guard let data = data, error == nil else {
				return
			}
			do {
				let response = try JSONDecoder().decode(MovieEntity.self, from: data)
				completionHandler(response.results)
				return
			} catch {
				return print(error)
			}
		}.resume()
	}

	func getTopRated(completionHandler: @escaping ([List]) -> Void) {
		self.urlComponent.path = "/3/movie/top_rated"

		guard let requestUrl = self.urlComponent.url else { return }

		session.dataTask(with: requestUrl) { data, response, error in
			guard let data = data, error == nil else {
				return
			}
			do {
				let response = try JSONDecoder().decode(MovieEntity.self, from: data)
				completionHandler(response.results)
				return
			} catch {
				return print(error)
			}
		}.resume()
	}

	func loadImage(from url: String, completionHandler: @escaping (UIImage) -> Void) {
		if let cachedImage = ImageCache.shared.object(forKey: url as NSString) {
			completionHandler(cachedImage)
		} else if let urlString = URL(string: "https://image.tmdb.org/t/p/w500\(url)") {
			DispatchQueue.global().async {
				guard let data = try? Data(contentsOf: urlString), let image = UIImage(data: data) else {
					return
				}
				ImageCache.shared.setObject(image, forKey: url as NSString)
				completionHandler(image)
			}
		}
	}

	func getDetailInfo(id: Int, completionHandler: @escaping (MovieDetailEntity) -> Void) {
		self.urlComponent.path = "/3/movie/\(id)"

		guard let requestUrl = self.urlComponent.url else { return }

		session.dataTask(with: requestUrl) { data, response, error in
			guard let data = data, error == nil else {
				return
			}
			do {
				let response = try JSONDecoder().decode(MovieDetailEntity.self, from: data)
				completionHandler(response)
				return
			} catch {
				return print(error)
			}
		}.resume()
	}

	func getActorDetailInfo(id: Int, completionHandler: @escaping (ActorEntity) -> Void) {
		self.urlComponent.path = "/3/person/\(id)"

		guard let requestUrl = self.urlComponent.url else { return }
		print(requestUrl)
		session.dataTask(with: requestUrl) { data, response, error in
			guard let data = data, error == nil else {
				return
			}
			do {
				let response = try JSONDecoder().decode(ActorEntity.self, from: data)
				completionHandler(response)
//				print(response)
				return
			} catch {
				return print(error)
			}
		}.resume()
	}

	func getCastInfo(_ id: Int, completionHandler: @escaping (CastEntity) -> Void) {
		self.urlComponent.path = "/3/movie/\(id)/credits"

		guard let requestUrl = self.urlComponent.url else { return }

		session.dataTask(with: requestUrl) { data, response, error in
			guard let data = data, error == nil else {
				return
			}
			do {
				let response = try JSONDecoder().decode(CastEntity.self, from: data)
				completionHandler(response)
				return
			} catch {
				return print(error)
			}
		}.resume()
	}

	func loadExternalIds(_ id: Int, completionHandler: @escaping (ExternalIdsEntity) -> Void) {
		self.urlComponent.path = "/3/movie/\(id)/external_ids"

		guard let requestUrl = self.urlComponent.url else { return }

		session.dataTask(with: requestUrl) { data, response, error in
			guard let data = data, error == nil else {
				return
			}
			do {
				let response = try JSONDecoder().decode(ExternalIdsEntity.self, from: data)
				completionHandler(response)
				return
			} catch {
				return print(error)
			}
		}.resume()
	}

	func loadYoutubeId(_ id: Int, completionHandler: @escaping (YoutubeIdEntity) -> Void) {
		self.urlComponent.path = "/3/movie/\(id)/videos"

		guard let requestUrl = self.urlComponent.url else { return }

		session.dataTask(with: requestUrl) { data, response, error in
			guard let data = data, error == nil else {
				return
			}
			do {
				let response = try JSONDecoder().decode(YoutubeIdEntity.self, from: data)
				completionHandler(response)
				return
			} catch {
				return print(error)
			}
		}.resume()
	}

	func searchByName(_ title: String, completionHandler: @escaping (TopRated) -> Void) {
		self.urlComponent.path = "/3/search/movie"
		self.urlComponent.queryItems = [URLQueryItem(name: "query", value: title), URLQueryItem(name: "api_key", value: apiKey)]

		guard let requestUrl = self.urlComponent.url else { return }
		print(requestUrl)
		DispatchQueue.main.async(flags: .barrier) {
			self.session.dataTask(with: requestUrl) { data, response, error in
				guard let data = data, error == nil else {
					return
				}
				do {
					let response = try JSONDecoder().decode(TopRated.self, from: data)
					completionHandler(response)
					return
				} catch {
					print(error)
					return
				}
			}.resume()
		}
	}

	func loadImages(_ personId: Int, completionHandler: @escaping (ImagesEntity) -> Void) {
		self.urlComponent.path = "/3/person/\(personId)/images"

		guard let requestUrl = self.urlComponent.url else { return }
		print(requestUrl)
		DispatchQueue.main.async(flags: .barrier) {
			self.session.dataTask(with: requestUrl) { data, response, error in
				guard let data = data, error == nil else {
					return
				}
				do {
					let response = try JSONDecoder().decode(ImagesEntity.self, from: data) /// ТУТ ОШИБКА ДЕКОДИНГА
					completionHandler(response)
					return
				} catch {
					print(error)
					return
				}
			}.resume()
		}
	}

	func recommendationList(completionHandler: @escaping (TopRated) -> Void) {
		self.urlComponent.path = "/3/trending/movie/week"

		guard let requestUrl = self.urlComponent.url else { return }
		print(requestUrl)
		DispatchQueue.main.async(flags: .barrier) {
			self.session.dataTask(with: requestUrl) { data, response, error in
				guard let data = data, error == nil else {
					return
				}
				do {
					let response = try JSONDecoder().decode(TopRated.self, from: data)
					completionHandler(response)
					return
				} catch {
					print(error)
					return
				}
			}.resume()
		}
	}
}
