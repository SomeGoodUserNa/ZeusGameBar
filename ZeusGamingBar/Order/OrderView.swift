//
//  OrderView.swift
//  ZeusGamingBar
//
//  Created by Danylo Klymenko on 18.09.2024.
//

import SwiftUI

struct OrderView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var orders: [RealmOrder] = []
    @State private var isShown = false
    
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
                    
                    
                    Text("Orders")
                        .foregroundColor(.secondButton)
                        .font(.system(size: 32, weight: .black))
                        .padding(.leading, 75)
                    
                    Spacer()
                    
                }
                .padding(.horizontal, 10)
                
                if !orders.isEmpty {
                    ScrollView {
                        ForEach(orders, id: \.id) { order in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("Order Code: \(order.orderCode ?? "")")
                                    Text("Total Value: \(String(format: "%.2f", order.totalValue ?? 0))")
                                }
                                .font(.system(size: 22, weight: .semibold))
                                .foregroundColor(.black)
                                
                                Spacer()
                                
                                if let imageData = order.orderQR, let image = UIImage(data: imageData) {
                                    Image(uiImage: image)
                                        .interpolation(.none)
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                }
                                
                                
                            }
                            .sheet(isPresented: $isShown) {
                                VStack {
                                    if let imageData = order.orderQR, let image = UIImage(data: imageData) {
                                        Image(uiImage: image)
                                            .interpolation(.none)
                                            .resizable()
                                            .frame(width: 400, height: 400)
                                    }
                                    
                                    Button {
                                        StorageManager.shared.deleteOrder(element: order)
                                        orders = []
                                        orders = Array(StorageManager.shared.orders)
                                        isShown.toggle()
                                    } label: {
                                        Text("Delete the Order")
                                            .foregroundStyle(.red)
                                    }
                                    .padding(.top)
                                }
                            }
                            .onTapGesture {
                                isShown.toggle()
                            }
                            .padding()
                            .background {
                                Rectangle()
                                    .fill(LinearGradient(colors: [.firstButton, .secondButton], startPoint: .bottom, endPoint: .top))
                                    .cornerRadius(12)
                            }
                            .padding(.horizontal)
                        }
                    }
                } else {
                    ScrollView {
                        VStack {
                            Text("The Orders is Empty")
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
        .onAppear {
            orders = Array(StorageManager.shared.orders)
        }
    }
}

#Preview {
    OrderView()
}
