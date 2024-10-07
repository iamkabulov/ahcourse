//
//  Movies+CoreData.swift
//  appNoStoryboard
//
//  Created by Nursultan Kabulov on 28.05.2024.
//

import CoreData


public class Favourite: NSManagedObject
{
	@nonobjc public class func fetchRequest() -> NSFetchRequest<Favourites> {
		return NSFetchRequest<Favourites>(entityName: "Favourites")
	}
	@NSManaged public var id: Int32
	@NSManaged public var title: String
	@NSManaged public var posterPath: String
}

extension Favourite: Identifiable {
	
}

class MoviesCoreData
{
	let container: NSPersistentContainer
	let context: NSManagedObjectContext
	static let shared = MoviesCoreData()

	private init() {
		self.container = NSPersistentContainer(name: "MoviesCoreData")
		self.context = container.viewContext
		self.container.loadPersistentStores { _, error in
			guard let error = error else { return }
			print(error)
			print("Container: Something went wrong")
		}
	}
}

//MARK: - INotesCoreData
extension MoviesCoreData {
	func saveContext() {
		DispatchQueue.main.async(flags: .barrier) {
			do {
				try self.context.save()
			} catch {
				fatalError("Unresolved saving error \(error)")
			}
		}
	}

	func deleteNote(id: Int) {
		if let note = self.fetchById(Int(id)) {
			context.delete(note)
		}
		saveContext()
	}

	func saveNote(_ note: FavouriteMovies) {
		let newNote = Favourites(context: context)
		newNote.id = Int32(note.id)
		newNote.title = note.title
		newNote.posterPath = note.posterPath
		saveContext()
	}

	func loadNotes(completion: @escaping ([FavouriteMovies]) -> Void) {
		let request = Favourites.fetchRequest()
		do {
			var notesList: [FavouriteMovies] = []
			let entities = try context.fetch(request)
			entities.forEach { entity in
				let id = entity.id
				guard let title = entity.title, let poster = entity.posterPath else { return }
				notesList.append(FavouriteMovies(id: Int(id),
												 title: title,
												 posterPath: poster))
			}
			completion(notesList)
		} catch {
			fatalError("Unresolved fetching all notes error \(error)")
		}
	}

	private func fetchById(_ id: Int) -> Favourites? {
		let fetchRequest = Favourite.fetchRequest()
		fetchRequest.predicate = NSPredicate(format: "id == %@", NSNumber(value: id)) ///можно и строкой "\(id)"

		do {
			let results = try context.fetch(fetchRequest)
			if let note = results.first {
//				FavouriteMovies(id: note.id, title: note.title, poster: note.poster)
//				print(note)
				return note
			}
		} catch {
			fatalError("Unresolved fetching note error \(error)")
		}
		return nil
	}

	func isFav(by id: Int) -> Bool {
		let fetchRequest = Favourite.fetchRequest()
		fetchRequest.predicate = NSPredicate(format: "id == %@", NSNumber(value: id)) ///можно и строкой "\(id)"

		do {
			let results = try context.fetch(fetchRequest)
			if let note = results.first {
				return true
			}
		} catch {
			fatalError("Unresolved fetching note error \(error)")
		}
		return false
	}
}
