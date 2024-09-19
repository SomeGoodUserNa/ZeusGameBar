//
//  TabButton.swift
//  ZeusGamingBar
//
//  Created by Danylo Klymenko on 11.09.2024.
//

import SwiftUI

struct TabButton: View {
    var title: String
    var image: String
    
    @Binding var selected: String
    
    var body: some View {
        Button {
            withAnimation(.spring) {
                selected = title
            }
        } label: {
            HStack(spacing: 10) {
                Image(image)
                    .resizable()
                    .colorInvert()
                    .scaledToFill()
                    .frame(width: 30, height: 30)
                
                if selected == title {
                    Text(title)
                        .frame(width: 50)
                }
            }
            .foregroundColor(.white)
            .padding(.vertical, 7)
            .padding(.horizontal)
            //.padding()
            .background(
                Rectangle()
                    .fill(Color.white.opacity(selected == title ? 0.08 : 0))
                    //.frame(width: 120, height: 65)
                    .cornerRadius(18)
            )
        }
    }
}

#Preview {
    TabRootView()
}
