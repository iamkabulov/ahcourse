//
//  ViewController.swift
//  helloworld
//
//  Created by Nursultan Kabulov on 17.04.2024.
//

import UIKit

class ViewController: UIViewController {

	private var isPlayer1: Bool = true

	@IBOutlet var xoButtons: [UIButton]!

	@IBOutlet weak var restartButton: UIButton!

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}

	@IBAction func clickButton(_ sender: UIButton) {
		if isPlayer1 {
			isPlayer1 = false
			sender.setTitle("❌", for: .normal)
			sender.isEnabled = false
		} else {
			isPlayer1 = true
			sender.setTitle("⭕️", for: .normal)
			sender.isEnabled = false
		}
	}


	@IBAction func restartButton(_ sender: UIButton) {
		for i in xoButtons {
			i.setTitle("", for: .normal)
			i.isEnabled = true
		}
	}

	func findWinner() {

	}
}

