//
//  Club.swift
//  ZeusGamingBar
//
//  Created by Danylo Klymenko on 13.09.2024.
//

import Foundation


class Club: Codable {
    
    var name: String
    var address: String
    
    var time: String
    var longitude: String
    var latitude: String
    
    var phone: String
    var image: String
    
    init(name: String, address: String, time: String, longitude: String, latitude: String, phone: String, image: String) {
        self.name = name
        self.address = address
        self.time = time
        self.longitude = longitude
        self.latitude = latitude
        self.phone = phone
        self.image = image
    }
}


extension Club {
    static func MOCK() -> Club {
        return Club(name: "Zeus BaseStack Club", address: "Kampstraße 1, 44137 Dortmund", time: "10:00-01:00", longitude: "51.576930534829124", latitude: "7.534698138950673", phone: "+4923158969939", image: "https://i.ibb.co/gTHsNW7/2.jpg")
    }
}
