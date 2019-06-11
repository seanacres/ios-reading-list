//
//  BookController.swift
//  Reading List
//
//  Created by Sean Acres on 6/11/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    var books: [Book] = []
    
    var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        return documents.appendingPathComponent("ReadingList.plist")
    }
    
    var readBooks: [Book] {
        return books.filter { $0.hasBeenRead == true }
    }
    
    var unreadBooks: [Book] {
        return books.filter { $0.hasBeenRead == false }
    }
    
    init() {
        loadFromPersistentStore()
    }
    
    func saveToPersistentStore() {
        guard let url = readingListURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let booksData = try encoder.encode(books)
            try booksData.write(to: url)
        } catch {
            print("Error saving data: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        do {
            guard let url = readingListURL else { return }
            
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodedBooks = try decoder.decode([Book].self, from: data)
            books = decodedBooks
        } catch {
            print("Error loading data: \(error)")
        }
    }
    
    func createBook(title: String, reasonToRead: String) {
        let book = Book(title: title, reasonToRead: reasonToRead)
        
        books.append(book)
        saveToPersistentStore()
    }
    
    func deleteBook(book: Book) {
        guard let index = books.firstIndex(of: book) else { return }
        
        books.remove(at: index)
        saveToPersistentStore()
    }
    
    func updateHasBeenRead(for book: Book) {
        guard let index = books.firstIndex(of: book) else { return }
        
        books[index].hasBeenRead = !books[index].hasBeenRead
        saveToPersistentStore()
    }
    
    func updateBookDetails(for book: Book, newTitle: String?, newReasonToRead: String?) {
        guard let index = books.firstIndex(of: book),
            let title = newTitle,
            let reasonToRead = newReasonToRead else { return }
        
        books[index].title = title
        books[index].reasonToRead = reasonToRead
        saveToPersistentStore()
    }
}
