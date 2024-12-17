//
//  ContentView.swift
//  test
//
//  Created by Can Dindar on 14/12/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var itemList = ItemList()
    @State var showSheet: Bool = false
    @State var showItemDetailSheet: Bool = false
    @State var searchItem = ""
    
    @State var selectedItem: Item? = nil
    
    var filteredItems: [Item] {
        if searchItem.isEmpty {
            return itemList.items
        } else {
            return itemList.items.filter { $0.name.lowercased().contains(searchItem.lowercased()) }
        }
    }
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                if filteredItems.isEmpty {
                    Text("No items yet!")
                        .foregroundStyle(.secondary)
                        .padding()
                } else {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(filteredItems) { item in
                            ItemCard(item: item)
                                .onTapGesture {
                                    selectedItem = item
                                    showItemDetailSheet = true
                                }
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Price Comparator")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showSheet = true
                    } label: {
                        Image(systemName: "plus.circle.fill").font(.title)
                    }
                }
            }
            .sheet(isPresented: $showSheet) {
                NewItem(itemList: itemList)
            }
            .sheet(isPresented: $showItemDetailSheet) {
                if let selectedItem = selectedItem {
                    NewItem(itemList: itemList, editingItem: selectedItem)
                }
            }
        }
        .searchable(text: $searchItem, prompt: "Search items...")
    }
}

#Preview {
    ContentView()
}

