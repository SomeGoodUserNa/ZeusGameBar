//
//  DataManager.swift
//  ZeusGamingBar
//
//  Created by Danylo Klymenko on 17.09.2024.
//

import SwiftUI
import CoreImage.CIFilterBuiltins


class DataManager {
    static let shared = DataManager()
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    private init(){}
    
    
    func generateQRCode(from string: String) -> UIImage {
        filter.message = Data("http://zeusGamingBars.com/order/?sub12\(string)".utf8)

        if let outputImage = filter.outputImage {
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }

        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
    
    func createCode() -> String {
        let randomNumber = Int.random(in: 0...999_999)
        let formattedNumber = String(format: "%06d", randomNumber)
        let formattedString = formattedNumber.prefix(3) + " " + formattedNumber.suffix(3)
        return String(formattedString)
    }
    
    func createInitialData() {
        
        if !UserDefaults.standard.bool(forKey: "init") {
            UserDefaults.standard.setValue(true, forKey: "init")
            
            UserDefaults.standard.setValue(createCode(), forKey: "code")
        }
    }
}
