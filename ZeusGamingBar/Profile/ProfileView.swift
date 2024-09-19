//
//  ProfileView.swift
//  ZeusGamingBar
//
//  Created by Danylo Klymenko on 17.09.2024.
//

import SwiftUI
import MessageUI

struct ProfileView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @State var isDeleteAlertShown = false
    @State var isAlertShown = false
    @State var isSuggestionShown = false
    @State var isErrorShown = false

    
    var body: some View {
        ZStack {
            BackgroundView()
            
            VStack {
                HStack {
                    Text("PROFILE")
                        .foregroundColor(.secondButton)
                        .font(.system(size: 32, weight: .black))
                        .padding(.leading, 25)
                    
                    Spacer()
                }
                
                ScrollView {
                    Rectangle()
                        .fill(LinearGradient(colors: [.secondBG, .thirdBG], startPoint: .top, endPoint: .bottom))
                        .frame(width: 200, height: 200)
                        .cornerRadius(12)
                        .overlay {
                            Image("zeus")
                                .resizable()
                                .frame(width: 200, height: 200)
                        }
                    if authViewModel.currentuser != nil {
                        HStack {
                            Text("NAME:")
                                .foregroundStyle(.white)
                                .font(.system(size: 18, weight: .bold))
                            Text(authViewModel.currentuser?.fullname ?? "")
                                .foregroundStyle(.white)
                                .font(.system(size: 18, weight: .bold))
                            Spacer()
                            
                        }
                        .frame(width: displaySize().width - 100)
                        .padding()
                        .background {
                            Rectangle()
                                .fill(LinearGradient(colors: [.secondBG, .thirdBG], startPoint: .bottom, endPoint: .top))
                                .cornerRadius(24)
                        }
                        .padding(.top)
                        
                        HStack {
                            Text("EMAIL:")
                                .foregroundStyle(.white)
                                .font(.system(size: 18, weight: .bold))
                            Text(authViewModel.currentuser?.email ?? "")
                                .foregroundStyle(.white)
                                .font(.system(size: 18, weight: .bold))
                            Spacer()
                            
                        }
                        .frame(width: displaySize().width - 100)
                        .padding()
                        .background {
                            Rectangle()
                                .fill(LinearGradient(colors: [.secondBG, .thirdBG], startPoint: .bottom, endPoint: .top))
                                .cornerRadius(24)
                        }
                    }
                    
                    Button {
                        if MFMailComposeViewController.canSendMail() {
                            isSuggestionShown.toggle()
                        } else {
                            isAlertShown.toggle()
                        }
                    } label: {
                        Text("SUGGEST A MODIFICATION")
                            .foregroundStyle(.black)
                    }
                    .frame(width: 250)
                    .padding()
                    .background {
                        Rectangle()
                            .foregroundColor(.firstButton)
                            .cornerRadius(24)
                    }
                    .padding(.top)
                    .sheet(isPresented: $isSuggestionShown) {
                        MailComposeView(isShowing: $isSuggestionShown, subject: "Improvement suggestion", recipientEmail: "", textBody: "")
                    }
                    
                    Button {
                        if MFMailComposeViewController.canSendMail() {
                            isErrorShown.toggle()
                        } else {
                            isAlertShown.toggle()
                        }
                    } label: {
                        Text("FLAG AN ERROR")
                            .foregroundStyle(.black)
                    }
                    .frame(width: 250)
                    .padding()
                    .background {
                        Rectangle()
                            .foregroundColor(.firstButton)
                            .cornerRadius(24)
                    }
                    .sheet(isPresented: $isErrorShown) {
                        MailComposeView(isShowing: $isErrorShown, subject: "Error message", recipientEmail: "", textBody: "")
                    }
                    
                    
                    Button {
                        openPrivacyPolicy()
                    } label: {
                        Text("PRIVACY POLICY")
                            .foregroundStyle(.black)
                    }
                    .frame(width: 250)
                    .padding()
                    .background {
                        Rectangle()
                            .foregroundColor(.firstButton)
                            .cornerRadius(24)
                    }
                                        
                    
                        Button {
                            authViewModel.signOut()
                        } label: {
                            Text("EXIT")
                                .font(.system(size: 26, weight: .bold))
                                .foregroundStyle(.white)
                        }
                        .frame(width: 100)
                        .padding()
                        .background {
                            Rectangle()
                                .foregroundColor(.secondBG)
                                .cornerRadius(24)
                        }
                        .padding(.top)
                        
                    if authViewModel.currentuser != nil {

                        Button {
                            isDeleteAlertShown.toggle()
                        } label: {
                            Text("Delete account")
                                .foregroundStyle(.red)
                        }
                        .padding(.top)
                        .padding(.bottom, 150)
                    }
                  
                }
                .scrollIndicators(.hidden)
            }
        }
        .alert("Are you sure you want to delete your account?", isPresented: $isDeleteAlertShown) {
            Button {
                authViewModel.deleteUserAccount { result in
                    switch result {
                    case .success():
                        print("Account deleted successfully.")
                        authViewModel.userSession = nil
                        authViewModel.currentuser = nil
                    case .failure(let error):
                        print("ERROR DELELETING: \(error.localizedDescription)")
                    }
                }
            } label: {
                Text("Yes")
            }
            
            Button {
                isDeleteAlertShown.toggle()
            } label: {
                Text("No")
            }
        } message: {
            Text("To access your reserves you will need to create a new account.")
        }
        .alert("Unable to send email", isPresented: $isAlertShown) {
            Button {
                isAlertShown.toggle()
            } label: {
                Text("Ok")
            }
        } message: {
            Text("Your device does not have a mail client configured. Please configure your mail or contact support on our website.")
        }
    }
   
    func openPrivacyPolicy() {
        if let url = URL(string: "") {
            UIApplication.shared.open(url)
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(AuthViewModel())
}
