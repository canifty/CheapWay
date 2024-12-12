// newItem.swift
import SwiftUI

struct newItem: View {
    
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var itemList: ItemList
    
    @State private var itemName: String = ""
    @State private var brand: String = ""
    @State private var price: Double = 0.0
    @State private var unit: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Item Name") {
                    TextField("Item name", text: $itemName)
                }
                Section("Brand") {
                    TextField("Brand", text: $brand)
                }
                Section("Unit") {
                    TextField("Unit", text: $unit)
                }
                Section("Price") {
                    TextField("Price", value: $price, format: .currency(code: "EUR"))
                        .keyboardType(.decimalPad)
                }
            }
            .navigationTitle("Add New Item")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        let newItem = Item(name: itemName, brand: brand, unit: unit, price: price)
                        itemList.items.append(newItem)
                        dismiss()
                    } label: {
                        Text("Save")
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
            }
        }
    }
}

#Preview {
    newItem(itemList: ItemList())
}
