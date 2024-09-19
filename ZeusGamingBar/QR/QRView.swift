//
//  QRView.swift
//  ZeusGamingBar
//
//  Created by Danylo Klymenko on 17.09.2024.
//

import SwiftUI

struct QRView: View {
    
    @State var code = ""
    @State var reservations: [RealmReserv] = []
    
    @State var isAlertShown = false
    
    var body: some View {
        ZStack {
            BackgroundView()
            
            VStack {
                HStack {
                    Text("QR")
                        .foregroundColor(.secondButton)
                        .font(.system(size: 32, weight: .black))
                        .padding(.leading, 25)
                    
                    Spacer()
                    
                    Button {
                        isAlertShown.toggle()
                    } label: {
                        Image(systemName: "info")
                            .font(.system(size: 20, weight: .bold))
                            .padding(10)
                            .foregroundColor(.black)
                            .background {
                                Circle()
                                    .foregroundColor(.firstButton)
                            }
                    }
                    .padding(.trailing, 25)
                }
                .padding(.horizontal, 10)
                
                ScrollView {
                    Rectangle()
                        .fill(LinearGradient(colors: [.firtBG, .thirdBG], startPoint: .top, endPoint: .bottom))
                        .frame(width: 250, height: 250)
                        .cornerRadius(12)
                        .overlay {
                            Image(uiImage: DataManager.shared.generateQRCode(from: code))
                                .interpolation(.none)
                                .resizable()
                                .frame(width: 220, height: 220)
                        }
                    HStack {
                        Text("CODE:")
                            .foregroundStyle(.white)
                            .font(.system(size: 28, weight: .bold))
                            .padding(.top)
                            .padding(.leading)
                        
                        Spacer()
                    }
                  
                    Text("\(code)")
                        .foregroundStyle(.white)
                        .font(.system(size: 22, weight: .bold))
                        .padding()
                        .padding(.horizontal, 120)
                        .background {
                            Rectangle()
                                .fill(LinearGradient(colors: [.secondBG, .thirdBG], startPoint: .top, endPoint: .bottom))
                                .cornerRadius(24)
                        }
                    
                    HStack {
                        Text("RESERVATIONS:")
                            .foregroundStyle(.white)
                            .font(.system(size: 28, weight: .bold))
                            .padding(.top)
                            .padding(.leading)
                        
                        Spacer()
                    }
                    
                    ForEach(reservations, id: \.id) { reserv in
                        HStack {
                            Text(reserv.date)
                            
                            Spacer()
                            
                            Text(reserv.code)
                            
                            Spacer()
                            
                            Text(reserv.time)
                        }
                        .foregroundStyle(.white)
                        .padding(.vertical)
                        .padding(.horizontal)
                        .background {
                            Rectangle()
                                .fill(LinearGradient(colors: [.secondBG, .thirdBG], startPoint: .top, endPoint: .bottom))
                                .cornerRadius(24)
                        }
                        .padding(.horizontal)

                    }
                }
                .scrollIndicators(.hidden)
                .padding(.horizontal)
            }
        }
        .alert("Information", isPresented: $isAlertShown) {
            Button {
                
            } label: {
                Text("Ok")
            }
        } message: {
            Text("To use the club's services, participate in the loyalty program and confirm your booking, show the QR code to the manager.")
        }
        .onAppear {
            code = UserDefaults.standard.string(forKey: "code") ?? "832 123"
            reservations = Array(StorageManager.shared.reservations)
        }
    }
}

//#Preview {
//    QRView()
//}
//
//#Preview {
//    TabRootView()
//}
