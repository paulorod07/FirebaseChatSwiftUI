//
//  LoginViewModel.swift
//  FirebaseChatSwiftUI
//
//  Created by Paulo Rodrigues on 30/04/23.
//

import Foundation

protocol LoginViewModel {
    func createAccount(with email: String, and password: String) async -> (ChatUser?, Error?)
    func login(with email: String, and password: String) async -> (ChatUser?, Error?)
}
