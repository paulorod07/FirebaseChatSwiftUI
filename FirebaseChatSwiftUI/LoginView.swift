//
//  LoginView.swift
//  FirebaseChatSwiftUI
//
//  Created by Paulo Rodrigues on 25/04/23.
//

import SwiftUI

struct LoginView: View {
    
    // MARK: - Properties
    
    @State var isLoginMode = false
    @State var email = ""
    @State var password = ""
    @State var statusMessage = ""
    @State var user: ChatUser?
    private let viewModel: LoginViewModel
    
    // MARK: - Initializer
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - View
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    Picker(selection: $isLoginMode, label: Text("")) {
                        Text("Login")
                            .tag(true)
                        Text("Create Account")
                            .tag(false)
                    }
                    .pickerStyle(.segmented)
                    
                    if !isLoginMode {
                        Button {
                            
                        } label: {
                            Image(systemName: "person.fill")
                                .font(.system(size: 64))
                                .padding()
                        }
                    }
                    
                    Group {
                        TextField("Email", text: $email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                        
                        SecureField("Password", text: $password)
                    }
                    .padding(12)
                    .background(Color.white)
                    
                    Button {
                        Task {
                            await handleAction()
                        }
                    } label: {
                        HStack {
                            Spacer()
                            Text(isLoginMode ? "Login" : "Create Account")
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                                .font(.system(size: 14, weight: .semibold))
                            Spacer()
                        }
                        .background(Color.blue)
                    }
                    
                    Text(statusMessage)
                        .foregroundColor(user != nil ? .green : .red)
                }
                .padding()
            }
            .navigationTitle(isLoginMode ? "Login" : "Create Account")
            .background(Color(.init(white: 0, alpha: 0.05))
                .ignoresSafeArea())
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    // MARK: - Methods
    
    private func handleAction() async {
        if isLoginMode {
            await login()
        } else {
            await createAccount()
        }
    }
    
    func login() async {
        let (response, error) = await viewModel.login(with: email, and: password)
        
        if let error {
            statusMessage = error.localizedDescription
            return
        }
        
        if let response {
            user = response
            statusMessage = "logado com sucesso \(response.id)"
        }
    }
    
    func createAccount() async {
        let (response, error) = await viewModel.createAccount(with: email, and: password)
        
        if let error {
            statusMessage = error.localizedDescription
            return
        }
        
        if let response {
            user = response
            statusMessage = "criado com sucesso \(response.id)"
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: FirebaseLoginViewModel())
    }
}
