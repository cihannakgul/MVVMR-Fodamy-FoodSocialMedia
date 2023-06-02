//
//  HomeRoute.swift
//  FodamyCihan
//
//  Created by cihan on 10.03.23.
//

protocol HomeRoute {
    func presentHome()
}

extension HomeRoute where Self: RouterProtocol {
    
    func presentHome() {
        let router = HomeRouter()
        let viewModel = HomeViewModel(router: router)
        let viewController = HomeViewController(viewModel: viewModel)
        
        let transition = ModalTransition()
        router.viewController = viewController
        router.openTransition = transition
        
        open(viewController, transition: transition)
    }
}
