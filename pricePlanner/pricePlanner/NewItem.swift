import SwiftUI

struct NewItem: View {
    @ObservedObject var itemList: ItemList
    
    @State var itemName: String = ""
    @State var itemBrand: String = ""
    @State var itemPrice: Double = 0.0
    @State var itemQuantity: Double = 0.0
    @State var itemUnit: String = "kg"
    
    @State private var availableBrands: [String] = ["Supero", "MD", "Conrad"]
    @State private var brandSections: [BrandSection] = []
    
    @Environment(\.dismiss) var dismiss
    
    var editingItem: Item?
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Name") {
                    TextField("Product name", text: $itemName)
                }
                
                Section("Brand") {
                    Picker("Brand:", selection: $itemBrand) {
                        ForEach(availableBrands, id: \.self) { brand in
                            Text(brand).tag(brand)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    
                    TextField("Price", value: $itemPrice, format: .currency(code: "EUR"))
                        .keyboardType(.decimalPad)
                }
                
                ForEach(brandSections.indices, id: \.self) { index in
                    Section {
                        Picker("Brand:", selection: $brandSections[index].brandName) {
                            ForEach(availableBrands, id: \.self) { brand in
                                Text(brand).tag(brand)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        
                        TextField("Price", value: $brandSections[index].brandPrice, format: .currency(code: "EUR"))
                            .keyboardType(.decimalPad)
                    }
                }
                
                Button("Add Brand") {
                    brandSections.append(BrandSection(brandName: availableBrands.first ?? "", brandPrice: 0.0))
                }
            }
            .navigationTitle(editingItem == nil ? "Add New Item" : "Edit Item")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        if let editingItem = editingItem {
                            // Update the existing item
                            if let index = itemList.items.firstIndex(where: { $0.id == editingItem.id }) {
                                itemList.items[index] = Item(
                                    id: editingItem.id,
                                    name: itemName,
                                    brand: itemBrand,
                                    unit: itemUnit,
                                    price: itemPrice,
                                    quantity: itemQuantity,
                                    brandSections: brandSections // Add brandSections here
                                )
                            }
                        } else {
                            // Create a new item
                            let newItem = Item(
                                name: itemName,
                                brand: itemBrand,
                                unit: itemUnit,
                                price: itemPrice,
                                quantity: itemQuantity,
                                brandSections: brandSections // Add brandSections here
                            )
                            itemList.items.append(newItem)
                        }
                        
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
        .onAppear {
            if let editingItem = editingItem {
                itemName = editingItem.name
                itemBrand = editingItem.brand
                itemPrice = editingItem.price
                itemQuantity = editingItem.quantity
                itemUnit = editingItem.unit
                brandSections = editingItem.brandSections // Load the brandSections for editing
            }
        }
    }
}
struct BrandSection: Identifiable {
    var id = UUID()
    var brandName: String
    var brandPrice: Double
}

#Preview {
    NewItem(itemList: ItemList())
}
