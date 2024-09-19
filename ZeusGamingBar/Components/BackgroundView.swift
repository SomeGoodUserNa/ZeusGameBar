//
//  BackgroundView.swift
//  ZeusGamingBar
//
//  Created by Danylo Klymenko on 11.09.2024.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        RadialGradient(colors: [ .secondBG, .thirdBG], center: .center, startRadius: 10, endRadius: 450)
            .ignoresSafeArea()
    }
}

#Preview {
    BackgroundView()
}
