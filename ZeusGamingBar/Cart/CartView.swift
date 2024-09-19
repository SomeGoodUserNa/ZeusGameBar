//
//  CartView.swift
//  ZeusGamingBar
//
//  Created by Danylo Klymenko on 18.09.2024.
//

import SwiftUI

struct CartView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var cart: RealmCart?
    @State private var isAlertShown = false
    
    var body: some View {
        ZStack {
            BackgroundView()
            
            VStack {
                HStack {
                    
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 20, weight: .bold))
                            .padding(10)
                            .foregroundColor(.black)
                            .background {
                                Circle()
                                    .foregroundColor(.firstButton)
                            }
                    }
                    .padding(.trailing, 25)
                    
                    
                    Text("Cart")
                        .foregroundColor(.secondButton)
                        .font(.system(size: 32, weight: .black))
                        .padding(.leading, 95)
                    
                    Spacer()
                    
                }
                .padding(.horizontal, 10)
                
                if cart != nil {
                    ScrollView {
                        VStack {
                            if let cart = cart {
                                ForEach(cart.elements, id: \.id) { element in
                                    HStack {
                                        Text(element.name ?? "")
                                            .font(.system(size: 32, weight: .bold))
                                        
                                        Spacer()
                                        
                                        Button {
                                            removeProduct(element: element)
                                            self.cart = nil
                                            getCart()
                                            
                                            if cart.elements.isEmpty {
                                                self.cart = nil
                                                StorageManager.shared.deleteCart()
                                            }
                                        } label: {
                                            Image(systemName: "minus")
                                                .font(.system(size: 22, weight: .bold))
                                                .foregroundStyle(.white)
                                        }
                                        
                                        Text("\(element.quantity ?? 0)")
                                            .font(.system(size: 22, weight: .light))
                                        
                                        Button {
                                            addProduct(element: element)
                                            self.cart = nil
                                            getCart()
                                            
                                        } label: {
                                            Image(systemName: "plus")
                                                .font(.system(size: 22, weight: .bold))
                                                .foregroundStyle(.white)
                                        }
                                    }
                                    .foregroundStyle(.white)
                                    .padding(.horizontal, 20)
                                    .padding(.bottom)
                                    
                                }
                            }
                        }
                        .padding()
                        .background {
                            Rectangle()
                                .fill(LinearGradient(colors: [.firtBG, .thirdBG], startPoint: .top, endPoint: .bottom))
                                .cornerRadius(24)
                        }
                        
                        Rectangle()
                            .fill(LinearGradient(colors: [.firtBG, .secondBG], startPoint: .leading, endPoint: .trailing))
                            .frame(width: 260, height: 60)
                            .cornerRadius(24)
                            .overlay {
                                Text("TOTAL: \(String(format: "%.2f", cart?.totalValue ?? 0))")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 22, weight: .bold))
                            }
                            .padding(.top)
                        
                        Button {
                            isAlertShown.toggle()
                        } label: {
                            Text("MAKE AN ORDER")
                                .font(.system(size: 22, weight: .bold))
                                .foregroundStyle(.black)
                                .padding()
                                .background {
                                    Rectangle()
                                        .fill(LinearGradient(colors: [.firstButton, .secondButton], startPoint: .bottom, endPoint: .top))
                                        .cornerRadius(12)
                                }
                        }
                        .padding(.top)
                        
                        Button {
                            self.cart = nil
                            StorageManager.shared.deleteCart()
                        } label: {
                            Text("Clear the Cart")
                                .foregroundStyle(.red)
                        }
                        .padding(.top, 40)
                        .padding(.bottom, 100)
                    }
                } else {
                    ScrollView {
                        VStack {
                            Text("The Cart is Empty")
                                .foregroundStyle(.gray)
                                .font(.system(size: 32, weight: .bold))
                                .padding(.top, 100)
                            
                            Image(systemName: "cart.badge.questionmark.rtl")
                                .foregroundStyle(.gray)
                                .font(.system(size: 132, weight: .bold))
                                .padding(.top, 100)
                        }
                    }
                }
            }
        }
        .alert("The order has been successfully created!", isPresented: $isAlertShown) {
            Button {
                StorageManager.shared.createOrder()
                self.cart = nil
                StorageManager.shared.deleteCart()
                dismiss()
            } label: {
                Text("OK")
            }
        } message: {
            Text("You can find your order on the all orders screen. To make a payment and receive your order - show the QR code to the manager.")
        }
        .onAppear {
            getCart()
        }
    }
    
    func getCart() {
        guard let cart = StorageManager.shared.carts.first else { return }
        self.cart = cart
    }
    
    
    func addProduct(element: RealmCartElement) {
        let product = Product(name: element.name ?? "", description: "", price: String(element.price ?? 0), image: "")
        StorageManager.shared.addToCart(foodItem: product)
        getCart()
    }
    
    func removeProduct(element: RealmCartElement) {
        StorageManager.shared.removeElement(element: element)
        getCart()
    }
}

#Preview {
    CartView()
}
