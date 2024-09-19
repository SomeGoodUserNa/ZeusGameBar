//
//  ProductCellView.swift
//  ZeusGamingBar
//
//  Created by Danylo Klymenko on 18.09.2024.
//

import SwiftUI

struct ProductCellView: View {
    
    var product: Product
    var completion: (Product) -> ()
    
    var body: some View {
        Rectangle()
            .fill(LinearGradient(colors: [.firtBG, .thirdBG], startPoint: .bottom, endPoint: .top))
            .frame(width: displaySize().width - 40, height: 100)
            .cornerRadius(24)
            .shadow(radius: 5, y: 5)
            .overlay {
                HStack {
                    if let url = URL(string: product.image) {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 80)
                                .clipped()
                                .cornerRadius(18)
                                .padding(1.5)
                                .background {
                                    Rectangle()
                                        .fill(LinearGradient(colors: [.firstButton, .secondButton], startPoint: .top, endPoint: .bottom))
                                        .cornerRadius(18)
                                        .shadow(radius: 5)
                                }
                        } placeholder: {
                            ProgressView()
                                .frame(width: 100, height: 80)
                        }
                        .padding(.leading, 15)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("\(product.name) - \(product.price)")
                            .foregroundStyle(.white)
                            .font(.system(size: 14, weight: .bold))
                        Text(product.description)
                            .font(.system(size: 8, weight: .regular))
                            .foregroundStyle(.gray)
                    }
                    .frame(width: 170)
                    
                    Button {
                        completion(product)
                    } label: {
                        Image(systemName: "plus")
                            .bold()
                            .foregroundColor(.white)
                    }
                    .padding(.trailing)
                    
                    Spacer()
                }
            }
    }
}

#Preview {
    ProductCellView(product: Product.MOCK()) {_ in}
}
