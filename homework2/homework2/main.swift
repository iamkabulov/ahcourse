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

