import SwiftUI

class ItemList: ObservableObject {
    @Published var items: [Item] = []
}

struct ContentView: View {
    
    @State var showNew = false
    @StateObject var itemList = ItemList()
    
    // Define grid layout
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                if itemList.items.isEmpty {
                    Text("No items yet!")
                        .foregroundStyle(.secondary)
                        .padding()
                } else {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(itemList.items) { item in
                            ItemCard(item: item)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Price Comparator")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        showNew = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showNew) {
                newItem(itemList: itemList) // Pass the item list
            }
        }
    }
}



#Preview {
    ContentView()
}
