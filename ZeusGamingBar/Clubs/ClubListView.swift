//
//  ClubListView.swift
//  ZeusGamingBar
//
//  Created by Danylo Klymenko on 13.09.2024.
//

import SwiftUI

struct ClubListView: View {
    
    @State private var clubs: [Club] = []
    
    var body: some View {
        ZStack {
            BackgroundView()
            
            VStack {
                HStack {
                    Text("CLUBS")
                        .foregroundColor(.secondButton)
                        .font(.system(size: 32, weight: .black))
                        .padding(.leading, 25)
                    
                    Spacer()
                }
                .padding(.horizontal, 10)
                
                ScrollView {
                    ForEach(clubs, id: \.name) { club in
                        ClubCellView(club: club) 
                            .padding(.bottom, 10)
                    }
                    .padding(.bottom, 100)
                }
                .padding(.bottom, 70)
                .scrollIndicators(.hidden)
                
            }
            
        }
        .onAppear {
            NetworkManager.shared.fetchClubs(from: URLS.clubs.rawValue) { data in
                if let clubs = data {
                    self.clubs = clubs
                }
            }
        }
    }
}

#Preview {
    ClubListView()
}
