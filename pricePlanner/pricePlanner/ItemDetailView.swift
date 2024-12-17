import SwiftUI

struct ItemDetailView: View {
    var item: Item
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Item Details")) {
//                    Text("Name: \(item.name)")
                    Text("Brand: \(item.brand)")
//                    Text("Unit: \(item.quantity) \(item.unit)")
                    Text("Price: \(item.price, format: .currency(code: "EUR"))")
                }
            }
            .navigationTitle(item.name)
        }
    }
}

#Preview {
    ItemDetailView(item: Item(name: "Tomato", brand: "Supero", unit: "kg", price: 2.99, quantity: 1, brandSections: []))
}
