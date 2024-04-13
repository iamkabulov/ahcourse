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
