//
//  BaseViewModel.swift
//  FodamyCihan
//
//  Created by cihan on 10.03.23.
//

import Utilities
import DataProvider

protocol BaseViewDataSource: AnyObject { }

protocol BaseViewEventSource: AnyObject {
    var showActivityIndicatorView: VoidClosure? {get set}
    var hideActivityIndicatorView: VoidClosure? {get set}
    var showLoading: VoidClosure? { get set }
    var hideLoading: VoidClosure? { get set }
    
    var showWarningToast: StringClosure? { get set }
}

protocol BaseViewModelProtocol: BaseViewDataSource, BaseViewEventSource {}

class BaseViewModel<R: Router>: BaseViewModelProtocol {
    
    let router: R
    var showActivityIndicatorView: VoidClosure?
    var hideActivityIndicatorView: VoidClosure?
    var showLoading: VoidClosure?
    var hideLoading: VoidClosure?
    var showWarningToast: StringClosure?
    let dataProvider: DataProviderContracts

    init(router: R, dataProvider: DataProviderContracts = apiDataProvider) {
        self.router = router
        self.dataProvider = dataProvider
    }
    
    #if DEBUG
    deinit {
        debugPrint("deinit \(self)")
    }
    #endif
}
