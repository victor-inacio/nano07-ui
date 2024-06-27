//
//  HomeView.swift
//  MonkyBook
//
//  Created by Caio Marques on 24/06/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject var vm = HomeViewModel()
    
    var body: some View {
        VStack {
            List {
                ForEach(vm.books, id: \.id) {book in
                    NavigationLink {
                        EditView(book: book)
                    } label: {
                        HStack {
                            Text(book.name)
                            Text(book.author)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                .onDelete(perform: { indexSet in
                    vm.removeBook(indexSet)
                })
            }
            .refreshable {
                vm.fetchBooks()
            }
        }
        .navigationTitle("Library App")
        .toolbar(content: {
            ToolbarItem(placement: .topBarLeading) {
                EditButton()
            }
            
            ToolbarItem {
                NavigationLink {
                    AddView()
                } label: {
                    Image(systemName: "plus")
                }

            }
        })
        .onAppear {
            vm.fetchBooks()
        }
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}
