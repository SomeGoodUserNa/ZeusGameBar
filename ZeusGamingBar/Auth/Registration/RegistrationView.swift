//
//  RegistrationView.swift
//  ZeusGamingBar
//
//  Created by Danylo Klymenko on 11.09.2024.
//

import SwiftUI

struct RegistrationView: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var fullname = ""
    @State private var confirmPassword = ""
    
    @State private var isNotificationShown = false
    @State private var switcher = true
    @State private var isAlertShown = false
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: AuthViewModel
    
    var body: some View {
        ZStack {
            BackgroundView()
            ScrollView {
                VStack {
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
                        .padding(.top)
                        .shadow(radius: 10)
                    
                    TextField("", text: $fullname, prompt: Text("NAME").font(.system(size: 24, weight: .bold)).foregroundColor(.gray))
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
                    
                    SecureField("", text: $confirmPassword, prompt: Text("CONFIRM PASSWORD").font(.system(size: 24, weight: .bold)).foregroundColor(.gray))
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
                        if isFormValid {
                            viewModel.fullName = fullname
                            viewModel.email = email
                            Task {
                                try await viewModel.createUser(withEmail: email, password: password, fullname: fullname)
                            }
                            withAnimation {
                                isAlertShown.toggle()
                            }
                        } else {
                            isNotificationShown.toggle()
                        }
                    } label: {
                        Text("SIGN UP")
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
                        dismiss()
                    } label: {
                        HStack {
                            Text("DO YOU ALREADY")
                                .foregroundStyle(.white)
                            Text("HAVE AN ACCOUNT?")
                                .foregroundStyle(.yellow)
                        }
                        .font(.system(size: 14))
                    }
                    .padding(.top)
                }
            }
            .scrollIndicators(.hidden)
        }
        .overlay {
            if isAlertShown {
                ProgressAlertView(text: "Incorrect data or a user with this email already exists.", switcher: $switcher) {
                    withAnimation {
                        isAlertShown = false
                        switcher = true
                        
                        email = ""
                        password = ""
                        fullname = ""
                        confirmPassword = ""
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
    RegistrationView(viewModel: AuthViewModel())
}

extension RegistrationView: AuthViewModelProtocol {
    var isFormValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
        && confirmPassword == password
        && !fullname.isEmpty
        
    }
}
