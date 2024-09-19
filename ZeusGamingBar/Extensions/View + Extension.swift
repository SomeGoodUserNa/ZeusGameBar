//
//  View + Extension.swift
//  ZeusGamingBar
//
//  Created by Danylo Klymenko on 11.09.2024.
//

import SwiftUI

extension View {
    
    func displaySize() -> CGSize {
        guard let window = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }
        return window.screen.bounds.size
    }
    
    func formatDateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM"
        dateFormatter.locale = Locale(identifier: "en_US")
        return dateFormatter.string(from: date)
    }

}
