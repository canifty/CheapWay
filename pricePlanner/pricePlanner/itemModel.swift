//
//  itemModel.swift
//  pricePlanner
//
//  Created by Can Dindar on 12/12/24.
//

// Item.swift
import Foundation

struct Item: Identifiable {
    let id = UUID()
    var name: String
    var brand: String
    var unit: String
    var price: Double
}
