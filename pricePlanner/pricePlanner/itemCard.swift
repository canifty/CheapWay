//
//  itemCard.swift
//  pricePlanner
//
//  Created by Can Dindar on 12/12/24.
//

import SwiftUI

struct ItemCard: View {
    let item: Item
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(item.name)
                .font(.headline)
            Text("Brand: \(item.brand)")
                .font(.subheadline)
                .foregroundStyle(.secondary)
            Text("Unit: \(item.unit)")
                .font(.subheadline)
                .foregroundStyle(.secondary)
            Text("Price: \(item.price, format: .currency(code: "EUR"))")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding()
        .frame(width: 150, height: 150)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemGray6))
        )
    }
}

#Preview {
    let mockItem = Item(name: "Tomato", brand: "Supero", unit: "kg", price: 2.99)
        ItemCard(item: mockItem)
}
