//
//  LoginRoute.swift
//  FodamyCihan
//
//  Created by cihan on 01.06.23.
//

protocol LoginRoute {
    func presentLogin()
}

extension LoginRoute where Self: RouterProtocol {
    
    func presentLogin() {
        print("routing to login")
        // JOB TO DO
        // Will page routing LoginViewController
        // LoginViewModel needs
    }
}
