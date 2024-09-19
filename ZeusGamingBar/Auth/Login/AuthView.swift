//
//  AuthView.swift
//  ZeusGamingBar
//
//  Created by Danylo Klymenko on 11.09.2024.
//

import SwiftUI

struct AuthView: View {
    
    @State private var email = ""
    @State private var password = ""
    
    @ObservedObject var viewModel: AuthViewModel
    @State private var isAlertShown = false
    @State private var switcher = true
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView()
                
                ScrollView {
                    VStack {
                        Image("logo")
                            .resizable()
                            .frame(width: 250, height: 250)
                        
                        TextField("", text: $email, prompt: Text("EMAIL").font(.system(size: 24, weight: .bold)).foregroundColor(.gray))
                            .foregroundColor(.white)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                            .colorMultiply(.white)
                            .tint(.white)
                            .padding()
                            .padding(.vertical)
                            .background {
                                Rectangle()
                                    .fill(LinearGradient(colors: [.firstTF , .secondTF], startPoint: .top, endPoint: .bottom))
                                    .cornerRadius(24)
                            }
                            .padding(.horizontal)
                            .font(.system(size: 28))
                            .shadow(radius: 10)
                        
                        SecureField("", text: $password, prompt: Text("PASSWORD").font(.system(size: 24, weight: .bold)).foregroundColor(.gray))
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                            .foregroundColor(.white)
                            .colorMultiply(.white)
                            .tint(.white)
                            .padding()
                            .padding(.vertical)
                            .background {
                                Rectangle()
                                    .fill(LinearGradient(colors: [.firstTF , .secondTF], startPoint: .top, endPoint: .bottom))
                                    .cornerRadius(24)
                            }
                            .padding(.horizontal)
                            .font(.system(size: 28))
                            .padding(.top)
                            .shadow(radius: 10)
                        
                        
                        Button {
                            viewModel.email = email
                            Task {
                                try await viewModel.signIn(email: email, password: password)
                            }
                            withAnimation {
                                isAlertShown.toggle()
                            }
                        } label: {
                            Text("LOG IN")
                                .font(.system(size: 38, weight: .black))
                                .foregroundStyle(.black)
                                .padding(.horizontal, 50)
                                .padding(.vertical, 15)
                                .background {
                                    Rectangle()
                                        .fill(LinearGradient(colors: [.firstButton, .secondButton], startPoint: .top, endPoint: .bottom))
                                        .cornerRadius(26)
                                }
                                .padding(.top)
                        }
                        
                        Button {
                            Task {
                                await viewModel.signInAnonymously()
                            }
                            withAnimation {
                                isAlertShown.toggle()
                            }
                        } label: {
                            Text("ANONYMOUS LOG IN")
                                .font(.system(size: 22, weight: .black))
                                .foregroundStyle(.black)
                                .padding(.horizontal, 50)
                                .padding(.vertical, 15)
                                .background {
                                    Rectangle()
                                        .fill(LinearGradient(colors: [.firstButton, .secondButton], startPoint: .top, endPoint: .bottom))
                                        .cornerRadius(26)
                                }
                                .padding(.top)
                        }
                        
                        NavigationLink {
                            RegistrationView(viewModel: viewModel)
                        } label: {
                            HStack {
                                Text("YOU DON’T HAVE AN ACCOUNT YET?")
                                    .foregroundStyle(.white)
                                Text("SIGN UP NOW.")
                                    .foregroundStyle(.yellow)
                            }
                            .font(.system(size: 14))
                        }
                        .padding(.top)
                        .padding(.bottom, 150)
                        
                    }
                }
                .scrollIndicators(.hidden)
            }
        }
        .tint(.white)

        .overlay {
            if isAlertShown {
                ProgressAlertView(text: "Incorrect email or password.", switcher: $switcher) {
                    withAnimation {
                        isAlertShown = false
                        switcher = true
                    }
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                        switcher = false
                    }
                }
            }
        }
    }
}

#Preview {
    AuthView(viewModel: AuthViewModel())
}
