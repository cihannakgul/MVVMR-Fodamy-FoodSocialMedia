//
//  BaseViewController.swift
//  FodamyCihan
//
//  Created by cihan on 10.03.23.
//

import UIKit
import UIComponents

class BaseViewController<V: BaseViewModelProtocol>: UIViewController {
    var viewModel: V
    
    init(viewModel: V) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .appWhite
        subscribeToast()
       
    }
    
    // swiftlint:disable fatal_error unavailable_function
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func subscribeToast() {
        viewModel.showWarningToast = { text in
            ToastPresenter.showWarningToast(text: text)
        }
    }
    
    func showWarningToast(message: String) {
        ToastPresenter.showWarningToast(text: message)
    }
    // swiftlint:enable fatal_error unavailable_function
    
}
 
