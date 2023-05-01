//
//  FirebaseLoginViewModel.swift
//  FirebaseChatSwiftUI
//
//  Created by Paulo Rodrigues on 30/04/23.
//

import Foundation
import Firebase

struct FirebaseLoginViewModel: LoginViewModel {
    
    // MARK: - Properties
    
    var auth: Auth
    
    // MARK: - Initializer
    
    init() {
        FirebaseApp.configure()
        auth = Auth.auth()
    }
    
    // MARK: - Methods
    
    func createAccount(with email: String, and password: String) async -> (ChatUser?, Error?) {
        do {
            let response = try await auth.createUser(withEmail: email, password: password)
            
            let user = ChatUser(id: response.user.uid, email: response.user.email)
            
            return (user, nil)
        } catch {
            debugPrint(error.localizedDescription)
            return (nil, error)
        }
    }
    
    func login(with email: String, and password: String) async -> (ChatUser?, Error?) {
        do {
            let response = try await auth.signIn(withEmail: email, password: password)
            
            let user = ChatUser(id: response.user.uid, email: response.user.email)
            
            return (user, nil)
        } catch {
            debugPrint(error.localizedDescription)
            return (nil, error)
        }
    }
    
}
