//
//  Product.swift
//  ZeusGamingBar
//
//  Created by Danylo Klymenko on 17.09.2024.
//

import Foundation


class Product: Codable {
    
    var name: String
    var description: String
    var price: String
    var image: String
    
    
    init(name: String, description: String, price: String, image: String) {
        self.name = name
        self.description = description
        self.price = price
        self.image = image
    }
}

extension Product {
    static func MOCK() -> Product {
        return Product(name: "Mana Potion", description: "A bright blue energy drink that instantly restores your energy during long gaming sessions.", price: "4.99", image: "https://i.ibb.co/BBY57Sw/pixlr-image-generator-e7849abd-8ff2-46b7-aa6d-48b1a45b76d0.webp")
    }
}

