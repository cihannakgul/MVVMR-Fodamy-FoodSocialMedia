//
//  LoginWarningPopupViewModel.swift
//  FodamyCihan
//
//  Created by cihan on 01.06.23.
//

import Utilities
import DataProvider

protocol LoginWarningPopupViewDataSource {}

protocol LoginWarningPopupViewEventSource {
    var loginHandler: VoidClosure? { get set }
}

protocol LoginWarningPopupViewProtocol: LoginWarningPopupViewDataSource, LoginWarningPopupViewEventSource {
    func giveUpButtonAction()
    func loginButtonAction()
}

final class LoginWarningPopupViewModel: BaseViewModel<LoginWarningPopupRouter>, LoginWarningPopupViewProtocol {
        
    var loginHandler: VoidClosure?
    
    func giveUpButtonAction() {
        router.close()
    }
    func loginButtonAction() {
        router.close()
        loginHandler?()
    }
    
}
