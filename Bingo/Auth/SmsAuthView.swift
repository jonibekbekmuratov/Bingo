//
//  SmsAuthView.swift
//  Bingo
//
//  Created by Johny on 16/08/23.
//

import SwiftUI

struct SmsAuthView: View {
    private let subtitle = "Enter sms code"
    @State private var smsCode = ""
    @State private var shouldOpenContentView = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(subtitle)
                .font(.title2)
            TextField("Type here sms code...", text: $smsCode)
                .padding()
                .background {
                    Color.gray.opacity(0.3)
                }
                .cornerRadius(12)
            Spacer()
            Button {
                signIn()
            } label: {
                RoundedRectangle(cornerRadius: 16)
                    .foregroundColor(
                        isSmsCodeValid()
                        ? Color.blue
                        : Color.blue.opacity(0.5)
                    )
                    .frame(maxHeight: 75)
                    .overlay {
                        Text("Sign In")
                    }
            }
            .disabled(!isSmsCodeValid())

        }
        .fullScreenCover(isPresented: $shouldOpenContentView) {
            ContentView()
        }
        .padding(.horizontal, 12)
    }
    
    func isSmsCodeValid() -> Bool {
        smsCode.count > 5
    }
    
    func signIn() {
        AuthManager.shared.verifyCode(
            smsCode: smsCode
        ) { success in
            if success {
                shouldOpenContentView = true
            }
        }
    }
}

struct SmsAuthView_Previews: PreviewProvider {
    static var previews: some View {
        SmsAuthView()
    }
}
