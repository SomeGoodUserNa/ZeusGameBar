//
//  StorageManager.swift
//  ZeusGamingBar
//
//  Created by Danylo Klymenko on 17.09.2024.
//

import Foundation
import RealmSwift

class StorageManager {
    static let shared = StorageManager()
    let realm = try! Realm()
    private init(){}
    
    @ObservedResults(RealmReserv.self) var reservations
    @ObservedResults(RealmOrder.self) var orders
    @ObservedResults(RealmCart.self) var carts
    
    func saveReservation(for date: String, and time: String) {
        let reserv = RealmReserv()
        reserv.date = date
        reserv.time = time
        reserv.code = DataManager.shared.createCode()
        
        $reservations.append(reserv)
    }
    
    //cart
    
    func addToCart(foodItem: Product) {
        let cart = realm.objects(RealmCart.self).first ?? RealmCart()
        
        if cart.realm == nil {
            try! realm.write {
                realm.add(cart)
            }
        }
        
        if let existingElement = cart.elements.first(where: { $0.name == foodItem.name }) {
            do {
                try realm.write {
                    existingElement.quantity = (existingElement.quantity ?? 0) + 1
                }
            } catch {
                print("Error updating count")
            }
        } else {
            let newElement = RealmCartElement()
            newElement.name = foodItem.name
            newElement.price = Double(foodItem.price)
            newElement.quantity = 1
            
            do {
                try realm.write {
                    cart.elements.append(newElement)
                }
            } catch {
                print("Error adding new element to cart")
            }
            
            
        }
        
        updateOrderTotalValue(cart: cart)
    }
    
    func updateOrderTotalValue(cart: RealmCart) {
        var total: Double = 0
        
        for element in cart.elements {
            let elementValue = element.price ?? 0
            let elementQuantity = Double(element.quantity ?? 0)
            total += elementValue * elementQuantity
        }
        do {
            try realm.write {
                cart.totalValue = total
            }
        } catch {
            print("Error updating")
        }
    }
    
    func removeElement(element: RealmCartElement) {
        let cart = realm.objects(RealmCart.self).first ?? RealmCart()
        
        if let itemToUpdate = realm.object(ofType: RealmCartElement.self, forPrimaryKey: element.id), let quantity = itemToUpdate.quantity {
            let newQuantity = quantity - 1
            do {
                try realm.write {
                    itemToUpdate.quantity = newQuantity
                }
                if newQuantity <= 0 {
                    deleteFoodItem(element: element)
                }
                updateOrderTotalValue(cart: cart)
                
            } catch {
                
            }
        } else {
            print("Элемент с id не найден в базе данных.")
        }
    }
    
    func deleteFoodItem(element: RealmCartElement) {
        
        do {
            try realm.write {
                realm.delete(element)
            }
        } catch {
            print("Error deleting")
        }
    }
    
    func deleteCart() {
        let allCarts = realm.objects(RealmCart.self)
        let allOrderElements = realm.objects(RealmCartElement.self)
        
        do {
            try realm.write {
                realm.delete(allCarts)
                realm.delete(allOrderElements)
            }
        } catch {
            print("Error deleting cart")
        }
    }
    
    //order
    func createOrder() {
        guard let cart = carts.first else { return }
        let order = RealmOrder()
        
        for i in cart.elements {
            let element = RealmOrderElement()
            element.name = i.name
            element.price = i.price
            element.quantity = i.quantity
            
            order.elements.append(element)
        }
        
        order.totalValue = cart.totalValue
        order.orderCode = DataManager.shared.createCode()
        
        let image = DataManager.shared.generateQRCode(from: order.orderCode ?? "000000")
        order.orderQR = image.jpegData(compressionQuality: 1.0)
        
        do {
            try realm.write {
                realm.add(order)
            }
        } catch {
            print("Error adding new order to realm")
        }
        
    }
    
    func deleteOrder(element: RealmOrder) {
        
        do {
            try realm.write {
                realm.delete(element)
            }
        } catch {
            print("Error deleting")
        }
    }
}
