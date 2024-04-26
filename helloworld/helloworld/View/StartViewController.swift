//
//  StartViewController.swift
//  helloworld
//
//  Created by Nursultan Kabulov on 24.04.2024.
//

import UIKit

class StartViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()

	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "withComputer" {
			let destination = segue.destination as! ViewController
			destination.controller.isComputer = true
		} else {
			let destination = segue.destination as! ViewController
			destination.controller.isComputer = false
		}
	}
}
