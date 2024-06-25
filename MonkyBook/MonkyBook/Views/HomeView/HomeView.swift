//
//  HomeView.swift
//  MonkyBook
//
//  Created by Caio Marques on 24/06/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            List {

            }
        }
        .navigationTitle("Library App")
        .toolbar(content: {
            ToolbarItem(placement: .topBarLeading) {
                EditButton()
            }
            
            ToolbarItem {
                Button {
                    
                } label: {
                    Image(systemName: "plus")
                }
            }
        })
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}
