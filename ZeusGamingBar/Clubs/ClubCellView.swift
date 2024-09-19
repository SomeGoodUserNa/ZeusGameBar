//
//  ClubCellView.swift
//  ZeusGamingBar
//
//  Created by Danylo Klymenko on 17.09.2024.
//

import SwiftUI
import MapKit

struct ClubCellView: View {
    
    var club: Club
    @State private var showAlert = false
    @State private var showReserv = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(LinearGradient(colors: [.thirdBG, .firtBG], startPoint: .top, endPoint: .bottom))
                .frame(width: displaySize().width - 50, height: 290)
                .cornerRadius(12)
                .shadow(radius: 2, y: 5)
                .overlay {
                    VStack {
                        if let url = URL(string: club.image) {
                            AsyncImage(url: url) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: displaySize().width - 50, height: 150)
                                    .clipped()
                                    .cornerRadius(12)
                            } placeholder: {
                                ProgressView()
                                    .controlSize(.large)
                                    .frame(width: displaySize().width - 50, height: 150)
                            }
                        }
                        
                        
                        VStack {
                            HStack {
                                Text(club.name)
                                    .font(.system(size: 18, weight: .bold))
                                
                                Spacer()
                                
                                Text(club.time)
                                    .font(.system(size: 16, weight: .regular))
                            }
                            .foregroundStyle(.white)
                            .padding(.bottom, 1)
                            
                            HStack {
                                Text(club.address)
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundStyle(.white)
                                Spacer()
                            }
                            
                            HStack {
                                Button {
                                    showReserv.toggle()
                                } label: {
                                    Text("RESERVE")
                                        .font(.system(size: 18, weight: .bold))
                                        .foregroundStyle(.black)
                                        .padding()
                                        .padding(.horizontal)
                                        .background {
                                            Rectangle()
                                                .cornerRadius(28)
                                                .foregroundColor(.firstButton)
                                                .shadow(radius: 10, y: 5)
                                        }
                                }
                                
                                Spacer()
                                
                                Button {
                                    openInAppleMaps(latitude: club.longitude, longitude: club.latitude)
                                } label: {
                                    Image(systemName: "mappin.and.ellipse")
                                        .font(.system(size: 18, weight: .bold))
                                        .foregroundStyle(.black)
                                        .padding(.horizontal, 3)
                                        .padding()
                                        .background {
                                            Rectangle()
                                                .cornerRadius(28)
                                                .foregroundColor(.firstButton)
                                                .shadow(radius: 10, y: 5)
                                        }
                                }
                                
                                Button {
                                    copyToClipboard(phoneNumber: club.phone)
                                    showAlert = true
                                } label: {
                                    Image(systemName: "phone")
                                        .font(.system(size: 20, weight: .bold))
                                        .foregroundStyle(.black)
                                        .padding(.horizontal, 3)
                                        .padding()
                                        .background {
                                            Rectangle()
                                                .cornerRadius(28)
                                                .foregroundColor(.firstButton)
                                                .shadow(radius: 10, y: 5)
                                        }
                                }
                            }
                            .alert(isPresented: $showAlert) {
                                Alert(title: Text("Successfully!"),
                                      message: Text("The phone number was copied: \(club.phone)"),
                                      dismissButton: .default(Text("Ok")))
                            }
                            
                        }
                        .padding(.horizontal)
                        
                        Spacer()
                    }
                }
        }
        .fullScreenCover(isPresented: $showReserv) {
            ReservationView(club: club)
        }
    }
    
    
    func openInAppleMaps(latitude: String, longitude: String) {
        guard let lat = Double(latitude), let lon = Double(longitude) else {
            print("Некорректные координаты")
            return
        }
        
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        let regionSpan = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "Destination"
        mapItem.openInMaps(launchOptions: options)
    }
    
    func copyToClipboard(phoneNumber: String) {
        UIPasteboard.general.string = phoneNumber
    }
}

#Preview {
    ClubCellView(club: Club.MOCK())
}
