//
//  TicTacToeController.swift
//  helloworld
//
//  Created by Nursultan Kabulov on 22.04.2024.
//

import Foundation
import UIKit

class TicTacToeController {

	var arrayXO: [XO] = []
	var isComputer = false
	var isComputerTurn = false
	var counter = 0
	weak var viewController: ViewController?
	private let winCombinations =
	[
		[0, 1, 2],
		[3, 4, 5],
		[6, 7, 8],
		[1, 4, 7],
		[0, 3, 6],
		[2, 5, 8],
		[0, 4, 8],
		[2, 4, 6]
	]

	init(_ viewController: ViewController) {
		self.viewController = viewController
		for _ in 0...8 {
			let XO = XO()
			arrayXO.append(XO)
		}
	}

	func choiceXO(for index: Int) {
		counter += 1
		if isComputer {
			if counter % 2 != 0 {
				arrayXO[index].label = "❌"
				isComputerTurn = true
			} else {
				arrayXO[index].label = "⭕️"
				isComputerTurn = false
			}
		} else {
			if counter % 2 != 0 {
				arrayXO[index].label = "❌"
			} else {
				arrayXO[index].label = "⭕️"
			}
		}

	}

	func findWinner() -> String? {
		for i in winCombinations {
			if arrayXO[i[0]].label == arrayXO[i[1]].label &&
				arrayXO[i[1]].label == arrayXO[i[2]].label &&
				arrayXO[i[0]].label != nil {
				return arrayXO[i[0]].label
			}
		}
		if counter == 9 {
			return "draw"
		}
		return nil
	}

	func computerTurn() {
		if isComputerTurn {
			let enabledButtons = viewController?.xoButtons.compactMap { button in
				if button.isEnabled == true {
					return button
				}
				return nil
			}
			guard enabledButtons?.isEmpty == false else { return }
			var click: UIButton?

			for check in [checkEmptySide, checkEmptyCorner, checkCenter, blockUserWin, findComputerWin] {
				if let button = check() {
					click = button
				}
			}

			DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
				guard let button = click else { return }
				self.viewController?.clickButton(button)
//				self.viewController?.clickButton(enabledButtons![Int.random(in: 0...enabledButtons!.count-1)])
			}
		}
	}

	func resetXO() {
		self.counter = 0
		arrayXO.removeAll()
		for _ in 0...8 {
			let XO = XO()
			arrayXO.append(XO)
		}
	}

	func checkCenter() -> UIButton? {
		if self.viewController?.xoButtons[4].title(for: .normal) == "" {
			return self.viewController?.xoButtons[4]
		}
		return nil
	}

	func checkEmptyCorner() -> UIButton? {
		let corners = [0, 2, 6, 8]
		let emptyCorners = corners.filter { corner in
			self.viewController?.xoButtons[corner].title(for: .normal) == ""
		}

		if !emptyCorners.isEmpty {
			let randomCorner = emptyCorners.randomElement()!
			return self.viewController?.xoButtons[randomCorner]
		}

		return nil
	}

	func checkEmptySide() -> UIButton? {
		let sides = [1, 3, 5, 7]

		let emptySides = sides.filter { side in
			self.viewController?.xoButtons[side].title(for: .normal) == ""
		}

		if !emptySides.isEmpty {
			let randomSide = emptySides.randomElement()!
			return self.viewController?.xoButtons[randomSide]
		}

		return nil
	}

	func blockUserWin() -> UIButton? {

		for combination in winCombinations {
			let positions = combination.map { self.viewController?.xoButtons[$0].title(for: .normal) }
			let userSymbolCount = positions.filter { $0 == "❌" }.count
			let emptyCellIndex = positions.firstIndex(of: "")

			if userSymbolCount == 2 && emptyCellIndex != nil {
				return self.viewController?.xoButtons[combination[emptyCellIndex!]]
			}
		}

		return nil
	}

	func findComputerWin() -> UIButton? {

		for combination in winCombinations {
			let positions = combination.map { self.viewController?.xoButtons[$0].title(for: .normal) }
			let computerSymbolCount = positions.filter { $0 == "⭕️" }.count
			let emptyCellIndex = positions.firstIndex(of: "")

			if computerSymbolCount == 2 && emptyCellIndex != nil {
				return self.viewController?.xoButtons[combination[emptyCellIndex!]]
			}
		}

		return nil
	}
}
