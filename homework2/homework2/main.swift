//
//  main.swift
//  homework2
//
//  Created by Nursultan Kabulov on 13.04.2024.
//

import Foundation

//MARK: - CLASS
///Классы: 1.Создайте класс "Прямоугольник", который имеет свойства "ширина" и "высота". Реализуйте метод, который вычисляет площадь прямоугольника. Создайте объекты прямоугольников разных размеров и выведите их площади.

class Rectangle {

	let width: Int
	let heigth: Int

	init(width: Int, heigth: Int) {
		self.width = width
		self.heigth = heigth
	}

	func calculateArea() -> Int {
		self.width * self.heigth
	}
}

let rectangle1 = Rectangle(width: 10, heigth: 20)
let rectangle2 = Rectangle(width: 5, heigth: 15)
let rectangle3 = Rectangle(width: 15, heigth: 25)

let areaOfRectangle1 = rectangle1.calculateArea()
let areaOfRectangle2 = rectangle2.calculateArea()
let areaOfRectangle3 = rectangle3.calculateArea()

print(areaOfRectangle1)
print(areaOfRectangle2)
print(areaOfRectangle3)


///Создайте класс "Книга", который имеет свойства "название", "автор" и "год издания". Реализуйте метод, который выводит информацию о книге. Создайте несколько объектов книг и вызовите метод для каждого из них.

class Book {
	let name: String
	let author: String
	let yearOf: Int

	init(name: String, author: String, yearOf: Int) {
		self.name = name
		self.author = author
		self.yearOf = yearOf
	}

	func info() {
		print("\(self.name) was written in \(self.yearOf) by \(self.author)")
	}
}

let book1 = Book(name: "Harry Potter", author: "J.K. Rowling", yearOf: 1990)
let book2 = Book(name: "The Editor", author: "Steven Rowley", yearOf: 2000)
let book3 = Book(name: "The House on Mango Street", author: "Sandra Cisneros", yearOf: 1998)

book1.info()
book2.info()
book3.info()

///Создайте класс "Автомобиль", который имеет свойства "марка", "модель" и "год выпуска". Реализуйте метод, который выводит информацию об автомобиле. Создайте несколько объектов автомобилей и вызовите метод для каждого из них.
class Car {
	let brand: String
	let model: String
	let yearOfIssue: Int

	init(brand: String, model: String, yearOfIssue: Int) {
		self.brand = brand
		self.model = model
		self.yearOfIssue = yearOfIssue
	}

	func info() {
		print("\(brand + model) was manufactured in \(yearOfIssue)")
	}
}

let car1 = Car(brand: "TOYOTA", model: "CAMRY 70", yearOfIssue: 2018)
let car2 = Car(brand: "KIA", model: "Cerato", yearOfIssue: 2022)
let car3 = Car(brand: "Hyundai", model: "Accent", yearOfIssue: 2015)

car1.info()
car2.info()
car3.info()

///Создайте класс "Студент", который имеет свойства "имя", "возраст" и "средний балл". Реализуйте метод, который проверяет, является ли студент отличником (средний балл выше 4.5). Создайте несколько объектов студентов и вызовите метод для каждого из них.

class Student {
	let name: String
	let overall: Float

	init(name: String, overall: Float) {
		self.name = name
		self.overall = overall
	}

	func isExcellent() {
		if self.overall > 4.5 {
			print("\(name) is excellent student with \(overall)")
		} else {
			print("\(name) has \(overall)")
		}
	}
}

let student1 = Student(name: "Hypc", overall: 4.6)
let student2 = Student(name: "John", overall: 5.5)
let student3 = Student(name: "Bob", overall: 4.3)

student1.isExcellent()
student2.isExcellent()
student3.isExcellent()


///Создайте класс "Банковский счет", который имеет свойства "номер счета" и "баланс". Реализуйте методы для пополнения и снятия денег со счета. Создайте объект банковского счета, проверьте работу методов пополнения и снятия денег.

class BankAccount {
	let bin: String
	var balance: Int

	init(bin: String, balance: Int) {
		self.bin = bin
		self.balance = balance
	}

	func withdraw(amount: Int) {
		if amount > balance {
			print("Not enough money. Current balance: \(balance)")
		} else {
			balance -= amount
			print("\(amount) was withdraw. Current balance: \(balance)")
		}
	}

	func replenishment(amount: Int) {
		balance += amount
		print("\(amount) was replenishment. Current balance: \(balance)")
	}
}

let bankAcc = BankAccount(bin: "KZ1928324043923", balance: 1000)

bankAcc.replenishment(amount: 100)
bankAcc.withdraw(amount: 2000)
bankAcc.withdraw(amount: 300)


//MARK: - ENCAPSULATION

///Создайте класс "Банковский счет" с приватным свойством "баланс". Реализуйте методы для пополнения и снятия денег со счета, которые обновляют значение баланса. Установите условие, что снятие денег возможно только при наличии достаточного баланса. Создайте объект банковского счета и проверьте работу методов.

class BankAccountEncapsulation {
	private var balance: Int

	init(balance: Int) {
		self.balance = balance
	}

	func withdraw(amount: Int) {
		if amount > balance {
			print("Not enough money. Current balance: \(balance)")
		} else {
			balance -= amount
			print("\(amount) was withdrawed. Current balance: \(balance)")
		}
	}

	func replenishment(amount: Int) {
		balance += amount
		print("\(amount) was replenishmented. Current balance: \(balance)")
	}
}

let bankAccount = BankAccountEncapsulation(balance: 100)
bankAccount.withdraw(amount: 50)
bankAccount.replenishment(amount: 150)

///Создайте класс "Студент" с приватными свойствами "имя", "возраст" и "средний балл". Реализуйте методы для установки значений свойств и получения значений свойств. Установите условие, что средний балл может быть установлен только в диапазоне от 0 до 5. Создайте объект студента и проверьте работу методов.

class StudentEncapsulation {
	private var name: String = "Hypc"
	private var age: Int = 18
	private var overall: Float = 4.5

	func setStudentName(_ name: String) {
		self.name = name
	}

	func setStudentAge(_ age: Int) {
		self.age = age
	}

	func setStudentOverall(_ overall: Float) {
		if overall > 0 && overall < 5 {
			self.overall = overall
		} else {
			print("Overall can be only from 0 to 5")
		}
	}

	func getStudentName() -> String {
		self.name
	}

	func getStudentAge() -> Int {
		self.age
	}

	func getStudentOverall() -> Float {
		self.overall
	}
}

let student = StudentEncapsulation()
print(student.getStudentAge())
print(student.getStudentName())
print(student.getStudentOverall())
student.setStudentName("An")
student.setStudentAge(20)
student.setStudentOverall(6)
student.setStudentOverall(4)
print(student.getStudentAge())
print(student.getStudentName())
print(student.getStudentOverall())

///Создайте класс "Телефон" с приватным свойством "номер телефона". Реализуйте методы для установки и получения номера телефона. Установите условие, что номер телефона должен быть валидным и соответствовать определенному формату. Создайте объект телефона и проверьте работу методов.

class Phone {
	private var number: String = ""

	func setNumber(_ number: String) {
		if validateNumber(number) {
			self.number = number
		} else {
			print("Phone number must be format like +X(XXX)XXX-XX-XX")
		}
	}

	func getNumber() -> String {
		self.number
	}

	private func validateNumber(_ number: String) -> Bool {
		guard number.count >= 13 else { return false }
		if number.hasPrefix("+") &&
			number[number.index(number.startIndex, offsetBy: 2)] == "(" &&
			number[number.index(number.startIndex, offsetBy: 6)] == ")" &&
			number[number.index(number.startIndex, offsetBy: 10)] == "-" &&
			number[number.index(number.startIndex, offsetBy: 13)] == "-"
		{
			return true
		}
		return false
	}
}

let phoneNumber = Phone()
print(phoneNumber.getNumber())
phoneNumber.setNumber("+")
phoneNumber.setNumber("+7(707)323-55-44")
print(phoneNumber.getNumber())


///Создайте класс "Книга" с приватным свойством "название". Реализуйте методы для установки и получения названия книги. Установите условие, что название книги должно быть длиннее определенного значения. Создайте объект книги и проверьте работу методов.

class BookEncapsulation {
	private var name: String = ""

	func setName(_ name: String) {
		if isValidNameBookName(name) {
			self.name = name
		} else {
			print("not valid book name")
		}
	}

	func getName() {
		print("\(self.name)")
	}

	private func isValidNameBookName(_ name: String) -> Bool {
		if name.count > 10 {
			return true
		}
		return false
	}
}
var bookEnc = BookEncapsulation()
bookEnc.setName("xzzxcsssxzc")
bookEnc.getName()

///Создайте класс "Автомобиль" с приватными свойствами "марка" и "модель". Реализуйте методы для установки и получения значений свойств. Установите условие, что модель автомобиля может быть установлена только для определенной марки. Создайте объект автомобиля и проверьте работу методов.

class CarEncapsulation {
	private var brand: String = "TOYOTA"
	private var model: String = ""

	func setInfo(brand: String, model: String) {
		if self.brand == brand {
			self.brand = brand
			self.model = model
			return
		}
		print("Can set only \(self.brand)")
	}

	func getInfo() {
		print("Brand: \(self.brand). \n Model: \(self.model)")
	}
}

let carEnc = CarEncapsulation()
carEnc.setInfo(brand: "KIA", model: "K5")
carEnc.getInfo()
carEnc.setInfo(brand: "TOYOTA", model: "K5")
carEnc.getInfo()


//MARK: - INHERITANCE

///Создайте базовый класс "Фигура" с методом "вычислить площадь". Создайте подклассы "Квадрат", "Прямоугольник" и "Треугольник", которые унаследуют базовый класс "Фигура". Реализуйте метод "вычислить площадь" для каждого подкласса, учитывая их уникальные свойства (например, стороны квадрата, ширина и высота прямоугольника, основание и высота треугольника). Создайте объекты каждого подкласса и вызовите метод "вычислить площадь" для каждого из них.

class Shape {

	func calculateArea() {
	}
}

class Triangle: Shape {
	private let side: Int
	private let height: Int

	init(side: Int, height: Int) {
		self.side = side
		self.height = height
	}

	override func calculateArea() {
		print((self.side * self.height) / 2)
	}
}

class RectangleInheritance: Shape {
	private let height: Int
	private let width: Int

	init(height: Int, width: Int) {
		self.height = height
		self.width = width
	}

	override func calculateArea() {
		print(self.height * self.width)
	}
}

class SquareInheritance: Shape {
	private let side: Int

	init(side: Int) {
		self.side = side
	}

	override func calculateArea() {
		print(self.side * self.side)
	}
}


let tri = Triangle(side: 10, height: 5)
let rec = RectangleInheritance(height: 10, width: 20)
let squ = SquareInheritance(side: 40)

tri.calculateArea()
rec.calculateArea()
squ.calculateArea()


///Создайте базовый класс "Транспортное средство" с методом "движение". Создайте подклассы "Автомобиль", "Велосипед" и "Мотоцикл", которые унаследуют базовый класс "Транспортное средство". Реализуйте метод "движение" для каждого подкласса, который будет выводить сообщение о способе движения соответствующего транспортного средства. Создайте объекты каждого подкласса и вызовите метод "движение" для каждого из них.

class Vehicle {

	func drive() {

	}
}

class CarInheritance: Vehicle {

	override func drive() {
		print("Car is driving!")
	}
}

class BikeInheritance: Vehicle {

	override func drive() {
		print("Bike is driving!")
	}
}

class MotocycleInheritance: Vehicle {

	override func drive() {
		print("Motocycle is driving!")
	}
}

let carInh = CarInheritance()
let bikeInh = BikeInheritance()
let motocycleInh = MotocycleInheritance()

carInh.drive()
bikeInh.drive()
motocycleInh.drive()


///Создайте базовый класс "Животное" с методом "издать звук". Создайте подклассы "Кот", "Собака" и "Лев", которые унаследуют базовый класс "Животное". Реализуйте метод "издать звук" для каждого подкласса, который будет выводить соответствующий звук каждого животного. Создайте объекты каждого подкласса и вызовите метод "издать звук" для каждого из них.

class Animal {

	func makeSound() {

	}
}

class Cat: Animal {

	override func makeSound() {
		print("Meow!")
	}
}

class Dog: Animal {

	override func makeSound() {
		print("Woo!")
	}
}

class Lion: Animal {

	override func makeSound() {
		print("Roar!")
	}
}

let cat = Cat()
let dog = Dog()
let lion = Lion()

cat.makeSound()
dog.makeSound()
lion.makeSound()


///Создайте базовый класс "Фрукт" с методом "съесть". Создайте подклассы "Яблоко", "Груша" и "Апельсин", которые унаследуют базовый класс "Фрукт". Реализуйте метод "съесть" для каждого подкласса, который будет выводить сообщение о том, что фрукт съеден. Создайте объекты каждого подкласса и вызовите метод "съесть" для каждого из них.

class Fruit {

	func eat() {
		print("Fruit was eaten")
	}
}

class Apple: Fruit {

	override func eat() {
		print("Apple was eaten")
	}
}

class Pear: Fruit {

	override func eat() {
		print("Pear was eaten")
	}
}

class Orange: Fruit {

	override func eat() {
		print("Orange was eaten")
	}
}


let apple = Apple()
let pear = Pear()
let orange = Orange()

apple.eat()
pear.eat()
orange.eat()

///Создайте базовый класс "Фигура" с методом "нарисовать". Создайте подклассы "Круг", "Квадрат" и "Треугольник", которые унаследуют базовый класс "Фигура". Реализуйте метод "

class ShapeDraw {

	func draw() {
		print("Drawing")
	}
}

class CircleInh: ShapeDraw {

	override func draw() {
		print("Circle are drawing")
	}
}

class SquareInh: ShapeDraw {

	override func draw() {
		print("Square are drawing")
	}
}

class TriangleInh: ShapeDraw {

	override func draw() {
		print("Triangle are drawing")
	}
}

let circle = CircleInh()
let square = SquareInh()
let triangle = TriangleInh()

circle.draw()
square.draw()
triangle.draw()


//MARK: - Difficult tasks
///Создайте класс "Библиотека", который имеет свойство "каталог книг". Реализуйте методы для добавления книги в каталог, удаления книги из каталога и поиска книги по названию или автору. Создайте объект библиотеки и проверьте работу методов.

class Library {
	private var books: [String: String]

	init(books: [String : String]) {
		self.books = books
	}

	func addNewBookToLibrary(name: String, author: String) {
		books[name] = author
	}

	func removeBookFromLibrary(name: String) {
		books.removeValue(forKey: name)
	}

	func findBookBy(name: String) {
		let result = books.filter { (key: String, value: String) in
			if name == key {
				print("\(key). \(value)")
				return true
			}
			return false
		}

		if result.isEmpty {
			print("There is no books named: \(name)")
		}
	}

	func findBookBy(author: String) {
		let result = books.filter { (key: String, value: String) in
			if author == value {
				print("\(key). \(value)")
				return true
			}
			return false
		}

		if result.isEmpty {
			print("There is no books by: \(author)")
		}
	}
}

let books = [
	"Harry Potter": "J.K. Rowling",
	"The Great Gatsby": "F. Scott Fitzgerald",
	"To Kill a Mockingbird": "Harper Lee",
	"1984": "George Orwell"
]

let lib = Library(books: books)

lib.addNewBookToLibrary(name: "Qara sozder", author: "Abay.K")
lib.addNewBookToLibrary(name: "Aq sozder", author: "Abay.K")
lib.removeBookFromLibrary(name: "Aq sozder")
lib.findBookBy(author: "Abay.K")
lib.findBookBy(author: "Ronaldo")
lib.findBookBy(name: "1984")
lib.findBookBy(name: "1983")


///Создайте класс "Задача", который имеет свойства "название", "описание" и "статус" (например, "выполнено", "в процессе", "не выполнено"). Реализуйте методы для изменения статуса задачи и вывода информации о задаче. Создайте объекты задач и проверьте работу методов.

enum Status {
	case WIP
	case DONE
	case NOT_DONE
}

class Tasks {
	private var name: String
	private var description: String
	private var state: Status = Status.NOT_DONE

	init(name: String, description: String) {
		self.name = name
		self.description = description
	}

	func changeStatus(_ state: Status) {
		self.state = state
		print("\nTask: \(self.name) \nDescription: \(self.description)\nStatus: \(self.state)\n")
	}
}

let taskOne = Tasks(name: "Develop UI", description: "Need to implement view")
taskOne.changeStatus(Status.NOT_DONE)


///Создайте класс "Магазин", который имеет свойство "инвентарь" (список товаров) и методы для добавления товара в инвентарь, удаления товара из инвентаря и поиска товара по названию или категории. Каждый товар должен иметь свойства "название", "цена" и "количество на складе". Создайте объект магазина и проверьте работу методов.
struct Product {
	let name: String
	let price: Double
	let quantity: Int
}
class Store {
	private var goods: [Product]

	init(goods: [Product]) {
		self.goods = goods
	}

	func addProduct(name: String, price: Double, quantity: Int) {
		let newProduct = Product(name: name, price: price, quantity: quantity)
		self.goods.append(newProduct)
	}

	func removeProduct(name: String) {
		self.goods.removeAll { $0.name == name }
	}

	func findProductByName(name: String) {
		let result = self.goods.filter { $0.name == name }
		if result.isEmpty {
			print("There is no goods named: \(name)")
			return
		}
		print(result)
	}
}

let equipments = [
	Product(name: "Knife", price: 100.0, quantity: 1),
	Product(name: "Fork", price: 120.0, quantity: 2),
	Product(name: "Spoon", price: 150.0, quantity: 5),
		]

let shop = Store(goods: equipments)
shop.addProduct(name: "Plate", price: 155.0, quantity: 10)
shop.findProductByName(name: "Fork")
shop.removeProduct(name: "Fork")
shop.findProductByName(name: "Fork")
shop.findProductByName(name: "Plate")


///Создайте класс "Банк", который имеет свойства "клиенты" (список клиентов) и методы для открытия нового банковского счета для клиента, закрытия существующего счета и перевода денег между счетами клиентов. Каждый клиент должен иметь свойства "имя" и "счет". Создайте объект банка и проверьте работу методов.

struct Client {
	let name: String
	let account: UUID
	var balance: Double = 0.0

	mutating func withdraw(amount: Double) {
		self.balance -= amount
	}

	mutating func refill(amount: Double) {
		self.balance += amount
	}
}

class Bank {
	var clients: [Client]

	init(clients: [Client]) {
		self.clients = clients
	}

	func openAccount(client: String) {
		let client = Client(name: client, account: UUID())
		self.clients.append(client)
	}

	func closeAccount(client: String) {
		self.clients.removeAll { $0.name == client }
	}

	func transfer(from: String, to: String, amount: Double) {
		var fromIndex: Int?
		var toIndex: Int?
		for (key, client) in clients.enumerated() {
			if client.name == from {
				fromIndex = key
			} else if client.name == to {
				toIndex = key
			}
		}
		guard let fromIndex = fromIndex, let toIndex = toIndex else { return print("\nCan not make transfer! There is error")}
		self.clients[fromIndex].withdraw(amount: amount)
		self.clients[toIndex].refill(amount: amount)
	}
}
let clients = [
	Client(name: "Hypc", account: UUID(), balance: 200.0),
	Client(name: "Nurzhan", account: UUID(), balance: 150.0),
	Client(name: "Anton", account: UUID(), balance: 180.0),
	Client(name: "Petr", account: UUID(), balance: 190.0)
]
let bank = Bank(clients: clients)
bank.openAccount(client: "John")
bank.closeAccount(client: "Petr")
bank.transfer(from: "Petr", to: "John", amount: 10.0)

bank.transfer(from: "Anton", to: "John", amount: 10.0)
print(bank.clients)
bank.transfer(from: "John", to: "Anton", amount: 10.0)
print(bank.clients)

///Создайте класс "Игра", который имеет свойство "игроки" (список игроков) и методы для добавления нового игрока, удаления игрока и определения победителя (например, игрок с наибольшим количеством очков). Каждый игрок должен иметь свойства "имя" и "очки". Создайте объект игры и проверьте работу методов.

class Game {
	var gamers: [String: Int]

	init(gamers: [String : Int]) {
		self.gamers = gamers
	}

	func addNewGamer(name: String) {
		self.gamers[name] = 0
	}

	func removeGamer(name: String) {
		self.gamers.removeValue(forKey: name)
	}

	func findWinner() {
		guard let result = self.gamers.max(by: { $0.value < $1.value }) else { return print("Something went wrong")}
		print("Winner \(result.key) with points:\(result.value)")
	}
}
let gamers = [
	"Hypc": 10,
	"Anton": 9,
	"Petr": 6,
	"Ackap": 7
]
let game = Game(gamers: gamers)
game.addNewGamer(name: "Epgoc")
game.removeGamer(name: "Petr")
print(game.gamers)
game.findWinner()
