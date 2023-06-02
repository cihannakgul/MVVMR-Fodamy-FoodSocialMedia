//
//  WalkthroughRoute.swift
//  FodamyCihan
//
//  Created by cihan on 10.03.23.
//

protocol WalkthroughRoute {
    func presentWalkthrough()
}

extension WalkthroughRoute where Self: RouterProtocol { // if a protocol has WalkthroughRoute and RouterProtocol same time, these func. will be applied:
    
    func presentWalkthrough() {
        let router = WalkthroughRouter()
        let viewModel = WalkthroughViewModel(router: router)
        let viewController = WalkthroughViewController(viewModel: viewModel)

        let transition = PlaceOnWindowTransition()
        router.viewController = viewController
        router.openTransition = transition

        open(viewController, transition: transition)
     }
}
