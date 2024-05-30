//
//  MovieBarController.swift
//  appNoStoryboard
//
//  Created by Nursultan Kabulov on 28.05.2024.
//

import UIKit

final class MovieBarController: UITabBarController {

	override func viewDidLoad() {
		super.viewDidLoad()
		setupViews()
		configure()
	}

	func setupViews() {
		let mainViewController = MoviesViewController()
		let favouritesController = FavouritesViewController()
		let watchListController = WatchListViewController()
		let findController = UIViewController()
		let profileController = UIViewController()

		let homeNav = UINavigationController(rootViewController: mainViewController)
		let watchNav = UINavigationController(rootViewController: watchListController)

		mainViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: nil)
		favouritesController.tabBarItem = UITabBarItem(title: "Favourites", image: UIImage(systemName: "star"), selectedImage: nil)
		watchListController.tabBarItem = UITabBarItem(title: "Watch list", image: UIImage(systemName: "memories.badge.plus"), selectedImage: nil)
		findController.tabBarItem = UITabBarItem(title: "Find", image: UIImage(systemName: "magnifyingglass"), selectedImage: nil)
		profileController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle"), selectedImage: nil)
		let tabBarList = [homeNav, favouritesController, watchNav, findController, profileController]
		self.viewControllers = tabBarList
	}


	func configure() {
		self.tabBar.tintColor = .label
	}
}

