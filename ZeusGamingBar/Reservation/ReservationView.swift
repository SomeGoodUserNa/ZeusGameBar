//
//  ReservationView.swift
//  ZeusGamingBar
//
//  Created by Danylo Klymenko on 17.09.2024.
//

import SwiftUI
import MessageUI

struct ReservationView: View {
    
    var club: Club
    
    @State private var date: Date = Date()
    @State private var time = "10:00"
    @State private var duration = "1"
    @State private var players = "1"
    @State private var name = ""
    @State private var phone = ""
    @State private var email = ""
    @State private var additionInfo = ""
    
    @State private var availableTime: [String] = ["10:00", "11: 00", "12:00", "13:00","14:00","15:00","16:00","17:00","18:00","19:00","20:00","21:00","22:00","23:00"]
    
    @State private var durationTime: [String] = ["1", "2", "3", "4", "5", "6", "7", "8"]
    
    @State private var isMailShown = false
    @State private var messageAlert = false
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            BackgroundView()
            
            VStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 20, weight: .bold))
                            .padding(10)
                            .foregroundColor(.black)
                            .background {
                                Rectangle()
                                    .foregroundColor(.firstButton)
                                    .cornerRadius(24)
                            }
                    }
                    .padding(.leading)
                    
                    Spacer()
                    
                    Text("RESERVATION")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundStyle(Color.firstButton)
                        .padding(.trailing, 40)
                    
                    Spacer()
                }
                .padding(.top)
                
                
                ScrollView {
                    
                    //MARK: - DATE
                    HStack {
                        Text("DATE:")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        DatePicker("", selection: $date, in: Date()..., displayedComponents: .date)
                            .datePickerStyle(.compact)
                        
                    }
                        .foregroundColor(.white)
                        .colorMultiply(.white)
                        .tint(.yellow)
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
                        .preferredColorScheme(.dark)
                    
                    //MARK: - START TIME
                    HStack {
                        Text("START TIME:")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Picker("", selection: $time) {
                            ForEach(availableTime, id: \.self) { time in
                                Text(time)
                            }
                        }
                        
                    }
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
                        .preferredColorScheme(.dark)
                    
                    //MARK: - DURATION
                    HStack {
                        Text("DURATION:")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Picker("", selection: $duration) {
                            ForEach(durationTime, id: \.self) { time in
                                Text(time)
                            }
                        }
                        
                    }
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
                        .preferredColorScheme(.dark)
                    
                    //MARK: - Players
                    HStack {
                        Text("PLAYERS:")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Picker("", selection: $players) {
                            ForEach(durationTime, id: \.self) { time in
                                Text(time)
                            }
                        }
                        
                    }
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
                        .preferredColorScheme(.dark)
                    
                    //MARK: - NAME
                    HStack {
                        Text("NAME:")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                        
                        
                        TextField("", text: $name, prompt: Text("Your name").font(.system(size: 24, weight: .light)).foregroundColor(.gray))
                            .multilineTextAlignment(.trailing)
                    }
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
                    
                    //MARK: - EMAIL
                    HStack {
                        Text("EMAIL:")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                        
                        
                        TextField("", text: $email, prompt: Text("Your email").font(.system(size: 24, weight: .light)).foregroundColor(.gray))
                            .multilineTextAlignment(.trailing)
                    }
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
                    
                    //MARK: - NAME
                    HStack {
                        Text("PHONE:")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                        
                        
                        TextField("", text: $phone, prompt: Text("Your phone number").font(.system(size: 24, weight: .light)).foregroundColor(.gray))
                            .multilineTextAlignment(.trailing)
                    }
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
                        if MFMailComposeViewController.canSendMail() {
                            isMailShown.toggle()
                        } else {
                            messageAlert.toggle()
                        }
                    } label: {
                        Text("MAKE RESERV")
                            .foregroundStyle(.black)
                            .font(.system(size: 20, weight: .bold))
                            .padding()
                            .padding(.horizontal, 40)
                            .background {
                                Rectangle()
                                    .foregroundColor(.firstButton)
                                    .cornerRadius(24)
                            }
                    }
                    .padding(.top)
                    .padding(.bottom, 150)
                }
                .scrollIndicators(.hidden)
            }
        }
        //MARK: - MessageView
        .sheet(isPresented: $isMailShown) {
            MailComposeView(isShowing: $isMailShown, subject: "Order message", recipientEmail: "pharaohCoffe@mail.com", textBody: makeReservMessage()) { result, error in
                switch result {
                case .cancelled:
                    print("Mail cancelled")
                case .saved:
                    print("Mail saved")
                case .sent:
                    print("Mail sent")
                    StorageManager.shared.saveReservation(for: formatDateToString(date: date), and: time)
                    dismiss()
                case .failed:
                    print("Mail failed: \(error?.localizedDescription ?? "Unknown error")")
                @unknown default:
                    print("Unknown result")
                }
            }
          
        }
        //MARK: - Message Alert
        .alert("Unable to send email", isPresented: $messageAlert) {
            Button {
                messageAlert.toggle()
            } label: {
                Text("Ok")
            }
        } message: {
            Text("Your device does not have a mail client configured. Please configure your mail or contact support on our website.")
        }
    }
    
    func makeReservMessage() -> String {
        let message = """
RESERVATION MESSAGE

CLUB: \(club.name)

Name: \(name)
Email: \(email)
Phone: \(phone)

Date: \(date)
Start time: \(time)
Duration: \(duration)
Players: \(players)

"""
        
        return message
    }
    
    func availableTimes(from timeRange: String) -> [String] {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        let times = timeRange.split(separator: "-").map { String($0) }
        
        print(times)
        
        guard times.count == 2,
              let startTime = formatter.date(from: times[0]),
              let endTime = formatter.date(from: times[1]) else {
            return []
        }
        
        var availableTimes: [String] = []
        
        print(availableTimes)
        
        var currentTime = startTime
        
        let oneHourBeforeClosing = Calendar.current.date(byAdding: .hour, value: -1, to: endTime)!
        
        while currentTime < oneHourBeforeClosing {
            availableTimes.append(formatter.string(from: currentTime))
            currentTime = Calendar.current.date(byAdding: .hour, value: 1, to: currentTime)!
        }
        
        print(availableTimes)
        return availableTimes
    }
}

#Preview {
    ReservationView(club: Club.MOCK())
}
