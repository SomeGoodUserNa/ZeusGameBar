//
//  NewsDetailView.swift
//  ZeusGamingBar
//
//  Created by Danylo Klymenko on 17.09.2024.
//

import SwiftUI

struct NewsDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    var news: News
    
    var body: some View {
        ZStack {
            BackgroundView()
            
            ScrollView {
                VStack {
                    if let url = URL(string: news.image) {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: displaySize().width, height: 300)
                                .cornerRadius(24)
                                .clipped()
                        } placeholder: {
                            ProgressView()
                                .frame(width: displaySize().width, height: 300)
                        }
                        .padding(.top, -20)
                     
                    }
                    
                    Text(news.title)
                        .foregroundStyle(.white)
                        .font(.system(size: 32, weight: .bold))
                        .frame(width: displaySize().width - 40, alignment: .leading)
                    
                    Text(news.description)
                        .foregroundStyle(.white)
                        .font(.system(size: 22, weight: .regular))
                        .frame(width: displaySize().width - 40, alignment: .leading)
                        .padding(.top, 1)
                    
                    Spacer()
                }
            }
            .scrollIndicators(.hidden)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    NewsDetailView(news: News.MOCK())
}
