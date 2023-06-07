//
//  ContentView.swift
//  SwiftDataDemo
//
//  Created by Thongchai Subsaidee on 7/6/23.
//

import SwiftUI
import SwiftData


@Model
class Book {
    var title: String
    var author: String
    var readed: Bool
    
    init(title: String, author: String, readed: Bool) {
        self.title = title
        self.author = author
        self.readed = readed
    }
}

struct BookListView: View {
    @Environment(\.modelContext) private var context
    let books: [Book]
    
    var body: some View {
        List {
            ForEach(books) { book in
                HStack {
                    Image(systemName: "book")
                        .imageScale(.large)
                    VStack(alignment: .leading){
                        Text(book.title)
                        Text(book.author)
                            .font(.caption)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    Image(systemName: book.readed ? "checkmark" : "xmark")
                }
            }
            .onDelete(perform: deleteBook)
        }
    }
    
    private func deleteBook(_ indexSet: IndexSet) {
        indexSet.forEach { index in
            let book = books[index]
            context.delete(book)
        }
    }
}

struct ContentView: View {
    @Environment(\.modelContext) private var context
    
    @Query(sort: \Book.title, order: .forward, animation: .easeInOut)
    
    private var allBooks: [Book]
    
    @State private var title = ""
    @State private var author = ""
    @State private var readed = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                GroupBox("Datos del libro") {
                    TextField(text: $title) {
                        Text("Title")
                    }
                    TextField(text: $author) {
                        Text("Author")
                    }
                    Toggle(isOn: $readed) {
                        Text("Readed")
                            .foregroundStyle(.secondary)
                    }
                }
                .textFieldStyle(.roundedBorder)
                BookListView(books: allBooks)
            }
            .padding()
            .navigationTitle("SwifData Demo")
            .toolbar {
                ToolbarItem {
                    Button(action: addBook) {
                        Label("Save", systemImage: "plus")
                    }
                }
            }
        }
    }
    
    private func addBook() {
        let newBook = Book(title: title, author: author, readed: readed)
        context.insert(newBook)
        
        do {
            try context.save()
            title = ""
            author = ""
            readed = false
        }catch{
            print(error.localizedDescription)
        }
    }
    
}

#Preview {
    ContentView()
        .modelContainer(for: [Book.self])
}

