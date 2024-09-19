//
//  MainView.swift
//  ZeusGamingBar
//
//  Created by Danylo Klymenko on 11.09.2024.
//

import SwiftUI

struct MainView: View {
    
    @State var news: [News] = []
    
    var body: some View {
        ZStack {
            BackgroundView()
            
            VStack {
                VStack(alignment: .leading) {
                    Image("logo")
                        .resizable() 
                        .frame(width: 200, height: 200)
                    
                    Text("NEWS")
                        .foregroundColor(.secondButton)
                        .font(.system(size: 32, weight: .black))
                        .padding(.leading)
                }
                .frame(width: displaySize().width - 60, alignment: .leading)
                
                ScrollView {
                    ForEach(news, id: \.title) { element in
                        NewsCellView(news: element)
                            .padding(.bottom, 10)
                    }
                    .padding(.bottom, 100)
                }
                .padding(.bottom, 70)
                .scrollIndicators(.hidden)
            }
        }
        .onAppear {
            DataManager.shared.createInitialData()
            NetworkManager.shared.fetchNews(from: URLS.news.rawValue) { news in
                if let news = news {
                    self.news = news
                }
            }
        }
    }
}

#Preview {
    MainView()
}
