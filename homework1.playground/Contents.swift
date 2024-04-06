import Foundation

//MARK: - medium difficulty tasks

// camelCase ⇄ snake_case
func toCamelCase(_ str: String) -> String {
	let arr = str.split(separator: "_")
	var result = ""
	for (key, word) in arr.enumerated() {
		if key == 0 {
			result += word
		}
		else {
			result += word.capitalized
		}
	}
	return result
}

toCamelCase("to_camel")

// camelCase ⇄ snake_case
func to_snake_case(_ str: String) -> String {
	let arr = str.map { char in
		if char.isUppercase {
			return "_" + String(char).lowercased()
		}
		return String(char)
	}
	return arr.joined()
}

to_snake_case("toCamel")

// find least common multiple
func gcd(_ a: Int, _ b: Int) -> Int {
	var num1 = a
	var num2 = b

	while num2 != 0 {
		let temp = num1 % num2
		num1 = num2
		num2 = temp
	}

	return num1
}

func lcm(_ a: Int, _ b: Int) -> Int {
	return abs(a * b) / gcd(a, b)
}

func leastCommonMultiple(of numbers: [Int]) -> Int {
	guard numbers.count >= 3 else { fatalError("Массив должен содержать более 3 чисел") }

	var result = numbers[0]
	for i in 1..<numbers.count {
		result = lcm(result, numbers[i])
	}

	return result
}

let array = [72, 80, 96]
let result = leastCommonMultiple(of: array)

// find first vowel index
func firstVowelIndex(_ word: String) -> Int {
	var result = 0
	for (key, value) in word.uppercased().enumerated() {
		if result == 0 {
			switch value {
			case "A", "E", "I", "O", "U":
				result = key
			case "Y":
				if key > 0 {
					result = key
				}
			default:
				break
			}
		}
	}
	return result
}

firstVowelIndex("yes")

//find numb in string
func findNumbInString(_ arrOfString: [String]) -> [String] {
	var numbersInString = [String]()
	arrOfString.filter { str in
		str.filter { char in
			guard let _ = Int("\(char)") else { return false }
			if !numbersInString.contains(str) {
				numbersInString.append(str)
			}
			return true
		}
		return true
	}
	return numbersInString
}

findNumbInString(["1a", "a", "2b", "b2vvv"])
