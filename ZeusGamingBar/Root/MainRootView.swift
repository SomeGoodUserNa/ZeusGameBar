//
//  MainRootView.swift
//  ZeusGamingBar
//
//  Created by Danylo Klymenko on 18.09.2024.
//

import SwiftUI

struct MainRootView: View {
    
    @StateObject private var viewModel = AuthViewModel()
    
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                TabRootView()
                    .environmentObject(viewModel)
            } else {
                AuthView(viewModel: viewModel)
                  
            }
        }
    }
}

#Preview {
    MainRootView()
}
