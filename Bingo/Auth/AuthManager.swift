//
//  AuthManager.swift
//  Bingo
//
//  Created by Johny on 16/08/23.
//

import FirebaseAuth

final class AuthManager {
    // Singleton
    // TODO: Using singleton is bad, try another way
    static let shared = AuthManager()
    
    private init() {}
    
    // TODO: Should be configured
    private let auth: Auth = {
        let auth = Auth.auth()
        auth.languageCode = "ru"
        return auth
    }()
    
    // TODO: SHould be injected
    private let provider = PhoneAuthProvider.provider()
    
    func startAuth(phoneNumber: String, completion: @escaping BoolClosure) {
        provider.verifyPhoneNumber(
            phoneNumber,
            uiDelegate: nil
        ) { verificationID, error in
            guard let verificationID, error == nil else {
                completion(false)
                return
            }
            UserDefaults.standard.set(verificationID, forKey: AppUserDefaultsKeys.verificationID)
            completion(true)
        }
    }
    
    func verifyCode(smsCode: String, completion: @escaping BoolClosure) {
        guard let verificationID = UserDefaults.standard.string(forKey: AppUserDefaultsKeys.verificationID)
        else {
            completion(false)
            return
        }
    
        let credential = provider.credential(
            withVerificationID: verificationID,
            verificationCode: smsCode
        )
        
        auth.signIn(with: credential) { authResult, error in
            guard authResult != nil, error == nil else {
                completion(false)
                return
            }
            completion(true)
        }
    }
}
