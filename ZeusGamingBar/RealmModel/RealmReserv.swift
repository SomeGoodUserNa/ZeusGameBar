//
//  RealmReserv.swift
//  ZeusGamingBar
//
//  Created by Danylo Klymenko on 17.09.2024.
//

import Foundation
import RealmSwift

class RealmReserv: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    
    @Persisted var date: String = ""
    @Persisted var time: String = ""
    @Persisted var code: String = ""
    
}

extension RealmReserv {
    static func MOCK() -> RealmReserv {
        let reserv = RealmReserv()
        reserv.date = "22 September"
        reserv.time = "10:00"
        reserv.code = "412 341"
        return reserv
    }
}
