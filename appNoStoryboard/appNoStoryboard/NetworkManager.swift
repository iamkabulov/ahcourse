//
//  NetworkManager.swift
//  appNoStoryboard
//
//  Created by Nursultan Kabulov on 22.05.2024.
//

import Foundation


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
				let response = try JSONDecoder().decode(PopularMovieEntity.self, from: data)
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
				let response = try JSONDecoder().decode(TopRated.self, from: data)
				completionHandler(response.results)
				return
			} catch {
				return print(error)
			}
		}.resume()
	}
}
