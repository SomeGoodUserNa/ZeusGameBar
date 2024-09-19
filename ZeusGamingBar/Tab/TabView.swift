//
//  TabView.swift
//  ZeusGamingBar
//
//  Created by Danylo Klymenko on 11.09.2024.
//

import SwiftUI

struct TabRootView: View {
    
    @State private var current = "News"
    @State private var isTabBarShown = true
    @EnvironmentObject var authViewModel: AuthViewModel
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
                TabView(selection: $current) {
                    
                    MainView()
                        .tag("News")
                    
                    ClubListView()
                        .tag("Clubs")
                    
                    QRView()
                        .tag("QR")
                    
                    ProductView()
                        .tag("Menu")
                    
                    ProfileView()
                        .environmentObject(authViewModel)
                        .tag("Profile")
                }
                
                if isTabBarShown {
                    
                    HStack(spacing: 0) {
                        TabButton(title: "News", image: "newsIcon", selected: $current)
                        
                        Spacer(minLength: 0)
                        
                        TabButton(title: "Clubs", image: "clubsIcon", selected: $current)
                        
                        Spacer(minLength: 0)
                        
                        TabButton(title: "QR", image: "qrIcon", selected: $current)
                        
                        Spacer(minLength: 0)
                        
                        TabButton(title: "Menu", image: "menuIcon", selected: $current)
                        
                        Spacer(minLength: 0)
                        
                        TabButton(title: "Profile", image: "personIcon", selected: $current)
                    }
                    .frame(width: displaySize().width - 55, height: 80)
                    .padding(.vertical)
                    .padding(.horizontal)
                    .background {
                        Rectangle()
                            .fill(LinearGradient(colors: [.thirdBG, .secondBG], startPoint: .top, endPoint: .bottom))
                            .frame(width: displaySize().width - 5, height: 80)
                            .cornerRadius(24)
                    }
                    .padding(.horizontal, 25)
                }
            }
        }
    }
}

#Preview {
    TabRootView()
        .environmentObject(AuthViewModel())
}
