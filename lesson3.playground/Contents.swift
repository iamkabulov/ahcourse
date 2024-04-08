import UIKit

var name = "John"
struct Person {
	var name: String = "By default"

	func sayHello() {
		print("Hello there! My name is \(self.name)!")
	}
}

let person = Person(name: "Hypc")

print(person.name)

person.sayHello()
let prs = Person.init()

struct Temperature {
	var celsius: Double
	var fahrenheit: Double
	var kelvin: Double

	init(celsius: Double) {
		self.celsius = celsius
		self.fahrenheit = celsius * 1.8 + 32
		self.kelvin = celsius + 273.15
	}

	init(fahrenheit: Double) {
		self.celsius = (fahrenheit - 32) / 1.8
		self.fahrenheit = fahrenheit
		self.kelvin = self.celsius + 273.15
	}

	init(kelvin: Double) {
		self.kelvin = kelvin
		self.celsius = kelvin - 273.15
		self.fahrenheit = self.celsius + 273.15
	}
}

let temperature = Temperature(kelvin: 273)


struct StepCounter {
	var totalSteps: Int = 0 {
		willSet {
			print("About to set total steps to \(newValue)")
		}
		didSet {
			if totalSteps < oldValue {
				print("Added \(totalSteps - oldValue) steps")
			}
		}
	}
}


var stepCounter = StepCounter()
stepCounter.totalSteps = 30
stepCounter.totalSteps = 10


struct Odometer {
	var count: Int = 0


	mutating func increment() {
		count += 1
	}

	mutating func increment(by amount: Int) {
		count += amount
	}

	mutating func reset() {
		count = 0
	}
}

var odometer = Odometer()

print(odometer.count)
odometer.increment()
print(odometer.count)
odometer.increment(by: 100)
print(odometer.count)
odometer.reset()
odometer.count

print("Here is _ \(odometer.count)")

