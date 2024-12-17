//
//  ItemModel.swift
//  test
//
//  Created by Can Dindar on 14/12/24.
//

import Foundation

class ItemList: ObservableObject {
    @Published var items: [Item] = []
}

struct Item: Identifiable {
    var id = UUID()
    var name: String
    var brand: String
    var unit: String
    var price: Double // Price of the main brand
    var quantity: Double
    var brandSections: [BrandSection] // Holds all brand price info
    
    // Computed property to find the cheapest price and brand
    var cheapestBrand: String {
        let allBrands = brandSections + [BrandSection(brandName: brand, brandPrice: price)] // Include the main brand
        if let cheapestSection = allBrands.min(by: { $0.brandPrice < $1.brandPrice }) {
            return cheapestSection.brandName
        } else {
            return brand // Default to main brand if no sections
        }
    }
    
    var cheapestPrice: Double {
        let allBrands = brandSections + [BrandSection(brandName: brand, brandPrice: price)] // Include the main brand
        if let cheapestSection = allBrands.min(by: { $0.brandPrice < $1.brandPrice }) {
            return cheapestSection.brandPrice
        } else {
            return price // Default to main price if no sections
        }
    }
}
