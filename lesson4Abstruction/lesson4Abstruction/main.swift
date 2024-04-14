//
//  main.swift
//  lesson4Abstruction
//
//  Created by Nursultan Kabulov on 13.04.2024.
//

import Foundation

protocol SomeProtocol: Any {
	func someFunc()
	var type: String { get set }
}

class ClassOne {
	var type: String
}

extension ClassOne: SomeProtocol {
	var type: String {
		get {
			return self.type
		}
		set {
			self.type = newValue
		}
	}


}

extension SomeProtocol {

	func someFunc() {
		print("Hypc!")
	}
}


var x = ClassOne()

x.someFunc()
