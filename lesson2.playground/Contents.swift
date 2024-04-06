import UIKit

////MARK: - COLLECTIONS
//
//var names: [String] = ["Anne", "Gary", "John"]
//
//func greetEveryOne(_ arr: [String]) {
//	var result = arr.map { name in
//		"Hello, \(name)!"
//	}
//	print(result)
//}
//
//greetEveryOne(names)
//
//var dict = ["Henry": 20, "John": 10]
//
//print(dict["Henry"])
//dict["Hypc"]
//
////MARK: - Optional Binding
//
//if var x = dict["Henry"] {
//	print(x)
//}
//
//guard let x = dict["John"] else { fatalError("Error!") }
//print(x)
//
//if let x = dict["John"] {
//	print(x)
//}
//
////MARK: - Key change
//
//var dict2 = ["Henry": 20, "John": 10]
//

//MARK: - COLLECTION TASKS

func firstVowelAndDistance(_ word: String) -> [Int] {
	var result = [Int]()
	var index: Int = 0
	for (key, value) in word.uppercased().enumerated() {
		switch value {
		case "A", "E", "I", "O", "U":
			index = 0
			result.append(0)
		case "B", "C", "D", "F", "G", "H", "J", "K", "L", "M", "N", "P", "Q", "R", "S", "T", "V", "W", "X", "Z":
			if index == 0 {
				index = 1
				result.append(1)
			} else if index >= 1 {
				result.append(index + 1)
				index += 1
			}
		case "Y":
			if key > 0 {
				index = key
				result[key] = 0
			}
		default:
			result[key] += 1
		}
	}

	return result
}

firstVowelAndDistance("word")
