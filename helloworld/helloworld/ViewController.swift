//
//  ViewController.swift
//  helloworld
//
//  Created by Nursultan Kabulov on 17.04.2024.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var status: UILabel!

	@IBOutlet var xoButtons: [UIButton]!

	@IBOutlet weak var restartButton: UIButton!

	var controller = TicTacToeController()

	override func viewDidLoad() {
		super.viewDidLoad()
		self.updateView()
		// Do any additional setup after loading the view.
	}

	@IBAction func clickButton(_ sender: UIButton) {
		guard let indexOfButton = xoButtons.firstIndex(of: sender) else { return }
		controller.choiceXO(for: indexOfButton)
		self.updateView()
	}

	private func updateView() {
		for i in xoButtons.indices {
			let button = xoButtons[i]
			let XO = controller.arrayXO[i]
			if let label = XO.label {
				button.setTitle(label, for: .normal)
				button.isEnabled = false
			} else {
				button.setTitle("", for: .normal)
				button.isEnabled = true
			}
		}

		if let win = controller.findWinner() {
			self.status.text = "Winner \(win)"
			xoButtons.forEach { button in
				button.isEnabled = false
			}
		}

		if controller.counter == 0 {
			self.restartButton.isHidden = true
		} else {
			self.restartButton.isHidden = false
		}
	}

	@IBAction func restartButton(_ sender: UIButton) {
		controller = TicTacToeController()
		self.status.text = "TIC TAC TOE"
		self.updateView()
	}
}

