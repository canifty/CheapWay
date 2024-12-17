//
//  ItemCard.swift
//  test
//
//  Created by Can Dindar on 14/12/24.
//

import SwiftUI

struct ItemCard: View {
    var item: Item
    
    var body: some View {
        VStack {
            Text(item.name)
                .font(.headline)
            
            // Show the cheapest price and brand
            if !item.brandSections.isEmpty {
                Text(item.cheapestBrand)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text("\(item.cheapestPrice, format: .currency(code: "EUR"))")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            } else {
                // If no brand sections, show main price and brand
                Text(item.cheapestBrand)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text("Price: \(item.price, format: .currency(code: "EUR"))")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

        }
        .frame(width: 150, height: 150)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemGray6))
        )
    }
}

//#Preview {
//    let mockItem = Item(name: "Tomato", brand: "Supero", unit: "kg", price: 2.99, quantity: 1)
//    ItemCard(item: mockItem)
//
//}
