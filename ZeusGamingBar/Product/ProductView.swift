//
//  ProductView.swift
//  ZeusGamingBar
//
//  Created by Danylo Klymenko on 18.09.2024.
//

import SwiftUI

struct ProductView: View {
    
    @State private var products: [Product] = []
    @State private var selectedButtonIndex = 0
    @State private var isCartShown = false
    @State private var isOrdersShown = false
    
    @State var cart: RealmCart?
    
    var body: some View {
        ZStack {
            BackgroundView()
            
            VStack {
                
                //MARK: - HEADER
                HStack {
                    Text("MENU")
                        .foregroundColor(.secondButton)
                        .font(.system(size: 32, weight: .black))
                        .padding(.leading, 25)
                    
                    Spacer()
                    
                    Button {
                        isCartShown.toggle()
                    } label: {
                        Image(systemName: "cart.fill")
                            .font(.system(size: 20, weight: .bold))
                            .padding(10)
                            .foregroundColor(.black)
                            .background {
                                Circle()
                                    .foregroundColor(.firstButton)
                            }
                    }
                    .overlay {
                        if let cart = cart {
                            Text("\(cart.elements.count)")
                                .foregroundColor(.white)
                                .padding(5)
                                .background {
                                    Circle()
                                        .foregroundColor(.red)
                                }
                                .offset(x: 15, y: 15)
                        }
                        
                    }
                    .padding(.trailing, 25)
                    
                    Button {
                        isOrdersShown.toggle()
                    } label: {
                        Image(systemName: "menubar.dock.rectangle")
                            .font(.system(size: 20, weight: .bold))
                            .padding(10)
                            .foregroundColor(.black)
                            .background {
                                Circle()
                                    .foregroundColor(.firstButton)
                            }
                    }
                    .padding(.trailing, 25)
                }
                .padding(.horizontal, 10)
                //MARK: - SEGMENTED
                
                HStack {
                    
                    Button {
                        products = []
                        NetworkManager.shared.fetchProduct(from: URLS.dirnks.rawValue) { data in
                            if let products = data {
                                self.products = products
                            }
                        }
                        withAnimation {
                            selectedButtonIndex = 0
                        }
                    } label: {
                        Text("DRINKS")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundStyle( selectedButtonIndex == 0 ? .black : .white )
                    }
                    .padding()
                    .padding(.horizontal)
                    .background {
                        Rectangle()
                            .fill(LinearGradient(colors:  selectedButtonIndex == 0 ? [.firstButton, .secondButton] : [.clear], startPoint: .top, endPoint: .bottom))
                            .cornerRadius(24)
                    }
                    
                    Spacer()
                    
                    Button {
                        products = []
                        NetworkManager.shared.fetchProduct(from: URLS.food.rawValue) { data in
                            if let products = data {
                                self.products = products
                            }
                        }
                        withAnimation {
                            selectedButtonIndex = 1
                        }
                    } label: {
                        Text("FOOD")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundStyle( selectedButtonIndex == 1 ? .black : .white )
                    }
                    .padding()
                    .padding(.horizontal)
                    .background {
                        Rectangle()
                            .fill(LinearGradient(colors:  selectedButtonIndex == 1 ? [.firstButton, .secondButton] : [.clear], startPoint: .top, endPoint: .bottom))
                            .cornerRadius(24)
                    }
                    
                    Spacer()
                    
                    Button {
                        products = []
                        NetworkManager.shared.fetchProduct(from: URLS.snacks.rawValue) { data in
                            if let products = data {
                                self.products = products
                            }
                        }
                        withAnimation {
                            selectedButtonIndex = 2
                        }
                    } label: {
                        Text("SNACKS")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundStyle( selectedButtonIndex == 2 ? .black : .white )
                    }
                    .padding()
                    .padding(.horizontal)
                    .background {
                        Rectangle()
                            .fill(LinearGradient(colors:  selectedButtonIndex == 2 ? [.firstButton, .secondButton] : [.clear], startPoint: .top, endPoint: .bottom))
                            .cornerRadius(24)
                    }
                }
                .padding(10)
                .background {
                    RoundedRectangle(cornerRadius: 24)
                        .stroke()
                        .foregroundColor(.firstButton)
                }
                .padding(.horizontal, 30)
                
                //MARK: - PRODUCTS
                ScrollView {
                    ForEach(products, id: \.name) { product in
                        ProductCellView(product: product) { product in
                            print(product.name)
                            StorageManager.shared.addToCart(foodItem: product)
                            self.cart = nil
                            getCart()
                        }
                    }
                    .padding(.bottom, 100)
                }
                .padding(.bottom, 70)
                .scrollIndicators(.hidden)
            }
        }
        .onAppear {
            NetworkManager.shared.fetchProduct(from: URLS.dirnks.rawValue) { data in
                if let products = data {
                    self.products = products
                }
            }
            self.cart = nil
            getCart()
        }
        .fullScreenCover(isPresented: $isOrdersShown) {
            OrderView()
        }
        .fullScreenCover(isPresented: $isCartShown) {
            CartView()
                .onDisappear {
                    self.cart = nil
                    getCart()
                }
        }
    }
    
    func getCart() {
        guard let cart = StorageManager.shared.carts.first else { return }
        self.cart = cart
    }
}

#Preview {
    ProductView()
}
