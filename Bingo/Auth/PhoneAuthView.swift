//
//  PhoneAuthView.swift
//  Bingo
//
//  Created by Johny on 16/08/23.
//

import SwiftUI

struct PhoneAuthView: View {
    private let subtitle = "Enter phone number"
    @State private var phoneNumber = ""
    @State private var shouldOpenSmsView = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(subtitle)
                .font(.title2)
            TextField("91 123 45 67", text: $phoneNumber)
                .padding()
                .background {
                    Color.gray.opacity(0.3)
                }
                .cornerRadius(12)
            Spacer()
            Button {
                verifyNumber()
            } label: {
                RoundedRectangle(cornerRadius: 16)
                    .foregroundColor(
                        isPhoneNumberValid()
                        ? Color.green
                        : Color.green.opacity(0.5)
                    )
                    .frame(maxHeight: 75)
                    .overlay {
                        Text("Sign In")
                    }
            }
            .disabled(!isPhoneNumberValid())

        }
        .fullScreenCover(isPresented: $shouldOpenSmsView) {
            SmsAuthView()
        }
        .padding(.horizontal, 12)
    }
    
    func isPhoneNumberValid() -> Bool {
        phoneNumber.count > 8
    }
    
    func verifyNumber() {
        AuthManager.shared.startAuth(
            phoneNumber: phoneNumber
        ) { success in
            if success {
                shouldOpenSmsView = true
            }
        }
    }
}

struct PhoneAuthView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneAuthView()
    }
}
