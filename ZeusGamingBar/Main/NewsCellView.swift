//
//  NewsCellView.swift
//  ZeusGamingBar
//
//  Created by Danylo Klymenko on 11.09.2024.
//

import SwiftUI

struct NewsCellView: View {
    
    var news: News
    
    @State private var isDetailShown = false
    
    var body: some View {
        Rectangle()
            .fill(LinearGradient(colors: [.firstTF , .secondTF], startPoint: .top, endPoint: .bottom))
            .frame(width: displaySize().width - 60, height: 300)
            .cornerRadius(24)
            .shadow(radius: 4, y: 10)
            .overlay {
                VStack {
                    if let url = URL(string: news.image) {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: displaySize().width - 60, height: 180)
                                .clipped()
                                .cornerRadius(12)
                        } placeholder: {
                            ProgressView()
                                .frame(width: displaySize().width - 60, height: 180)
                        }

                    }
                    
                    Text(news.title)
                        .font(.system(size: 26, weight: .bold))
                        .foregroundStyle(.white)
                        .frame(width: displaySize().width - 90, alignment: .leading)
                        .padding(.top)
                    
                    Spacer()
                }
            }
            .onTapGesture {
                isDetailShown.toggle()
            }
            .sheet(isPresented: $isDetailShown) {
                NewsDetailView(news: news)
            }
    }
}

#Preview {
    NewsCellView(news: News.MOCK())
}
