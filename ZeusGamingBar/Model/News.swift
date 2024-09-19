//
//  News.swift
//  ZeusGamingBar
//
//  Created by Danylo Klymenko on 17.09.2024.
//

import Foundation


class News: Codable {
    var title: String
    var description: String
    var image: String
 
    init(title: String, description: String, image: String) {
        self.title = title
        self.description = description
        self.image = image
    }
}

extension News {
    static func MOCK() -> News {
            return News(title: "New Club Opening in the City Center", description: "The gaming club network has opened a new location in the heart of the city. Spacious rooms, the latest gaming consoles, and high-speed internet are now ready for the first visitors!", image: "https://i.ibb.co/0DfNnP2/1.webp")
    }
}
