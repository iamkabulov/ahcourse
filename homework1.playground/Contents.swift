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


//MARK: - Diffult tasks
let romanNumb: [Character: Int] = [
	"I": 1,
	"V": 5,
	"X": 10,
	"L": 50,
	"C": 100,
	"D": 500,
	"M": 1000
]

func romanToInt(_ str: String) -> Int {
	var result = 0
	var previousValue = 0

	for char in str {
		guard let value = romanNumb[char] else { return 0 }

		result += value

		if value > previousValue {
			result -= 2 * previousValue
		}

		previousValue = value
	}

	return result
}

romanToInt("MMMCMVI")

let englishAlphabet: [Character: Int] = [
	"A": 1, "a": 1,
	"B": 2, "b": 2,
	"C": 3, "c": 3,
	"D": 4, "d": 4,
	"E": 5, "e": 5,
	"F": 6, "f": 6,
	"G": 7, "g": 7,
	"H": 8, "h": 8,
	"I": 9, "i": 9,
	"J": 10, "j": 10,
	"K": 11, "k": 11,
	"L": 12, "l": 12,
	"M": 13, "m": 13,
	"N": 14, "n": 14,
	"O": 15, "o": 15,
	"P": 16, "p": 16,
	"Q": 17, "q": 17,
	"R": 18, "r": 18,
	"S": 19, "s": 19,
	"T": 20, "t": 20,
	"U": 21, "u": 21,
	"V": 22, "v": 22,
	"W": 23, "w": 23,
	"X": 24, "x": 24,
	"Y": 25, "y": 25,
	"Z": 26, "z": 26
]

func decodeString(_ str: String, k: Int) -> String {
	var result = [Character]()
	str.map { char in
		guard let value = englishAlphabet[char] else {
			result.append(char)
			return
		}

		var temp: Int
		if value + k > 26 {
			temp = value + k - 26
		} else {
			temp = value + k
		}

		guard let decodedChar = englishAlphabet.first(
			where: {
				$0.value == temp
			})?.key
		else {
			return
		}


		if char.isUppercase {
			result.append(contentsOf: decodedChar.uppercased())
		} else {
			result.append(contentsOf: decodedChar.lowercased())
		}


	}
	return String(result)
}

decodeString("middle-Outz", k: 2)


//sort string
func sortString(_ str: String) -> String {
	let sortedCharacters = str.sorted { (char1, char2) -> Bool in
		if char1.isLetter && !char2.isLetter {
			return true
		} else if !char1.isLetter && char2.isLetter {
			return false
		} else if char1.lowercased() != char2.lowercased() {
			return char1.lowercased() < char2.lowercased()
		} else {
			return char1 > char2
		}
	}
	return String(sortedCharacters)
}

sortString("eA2a1E")
