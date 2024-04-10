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

//MARK: - Lesson3

class Person2 {
	var name: String

	init(name: String) {
		self.name = name
	}

	func sayHello() {
		print("Hello there. I'm \(self.name)")
	}
}

let pers = Person2(name: "Hypc - K")

print(pers.name)

pers.sayHello()

class Person3: Person2 {
	var type: String

	init(type: String) {
		self.type = type
		super.init(name: type)
	}

	override func sayHello() {
		print("PERSON3 OVERRIDED FUNC \(self.type)")
	}
}


let p = Person3(type: "TYPE")
p.sayHello()


var jack = Person2(name: "HYPC!")

var myFriend = jack

print(jack.name)
print(myFriend.name)


struct PersonS {
	var firstName: String = "By default"
	var lastName: String

	func sayHello() {
		print("Hello there! My name is \(self.firstName)!")
	}
}

let personStruct = PersonS(lastName: "Not default value")

print(personStruct.firstName)

personStruct.sayHello()


class PersonC {
	private var name: String
	internal var lastName: String

	init(name: String, lastName: String) {
		self.name = name
		self.lastName = lastName
	}

	func sayHello() {
		print("Hello there. I'm \(self.name)")
	}
}

let personClass = PersonC(name: "Hypc - KJlACC", lastName: "LastName")

//print(personClass.name)

personClass.sayHello()

class Worker: PersonC {
	var position: String

	init(position: String, name: String, lastName: String) {
		self.position = position
		super.init(name: name, lastName: lastName)
	}
}


var worker = Worker.init(position: "iOS", name: "Hypc", lastName: "K")

//worker.name
worker.position

class Square {
	var height: Int
	var width: Int

	init(h: Int, w: Int) {
		self.width = w
		self.height = h
	}

	func calculate() -> Int {
		return height * width
	}
}

class Rectangle: Square {

	init(h: Int) {
		super.init(h: h, w: h)
	}
}


let sq = Square(h: 10, w: 10)
let re = Rectangle(h: 15)

sq.calculate()
re.calculate()


class Parallelogramma: Square {
	override init(h: Int, w: Int) {
		super.init(h: h, w: w)
	}
}

let pr = Parallelogramma(h: 10, w: 50)
pr.calculate()
