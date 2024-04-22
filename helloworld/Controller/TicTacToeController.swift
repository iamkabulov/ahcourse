//
//  TicTacToeController.swift
//  helloworld
//
//  Created by Nursultan Kabulov on 22.04.2024.
//

import Foundation

class TicTacToeController {

	var arrayXO: [XO] = []
	var counter = 0
	private let winCombination =
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

	init() {
		for _ in 0...8 {
			let XO = XO()
			arrayXO.append(XO)
		}
	}

	func choiceXO(for index: Int) {
		counter += 1
		if counter % 2 != 0 {
			arrayXO[index].label = "❌"
			
		} else {
			arrayXO[index].label = "⭕️"
		}
	}

	func findWinner() -> String? {
		for i in winCombination {
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
}
