//
//  TabBarRoute.swift
//  FodamyCihan
//
//  Created by cihan on 29.03.23.
//

protocol TabBarRoute {
    func presentTabBar()
}

extension TabBarRoute where Self: RouterProtocol {
    
    func presentTabBar() {
        let tabBarController = TabBarController()
        let transition = PlaceOnWindowTransition()
        
        open(tabBarController, transition: transition)
    }
}
