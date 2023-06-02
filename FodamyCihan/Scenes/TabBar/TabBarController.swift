//
//  TabBarController.swift
//  FodamyCihan
//
//  Created by cihan on 29.03.23.
//

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureContents()
        let homeViewController = createHomeViewController()
        let favoritesViewController = createFavoritesViewController()
        viewControllers = [homeViewController, favoritesViewController]
    }
    
    private func configureTabBarIcons(navController: NavigationController, icon:UIImage?) {
        navController.tabBarItem.image = icon
        
    }
    private func configureContents() {
        tabBar.tintColor = .appRed
    }
    private func createHomeViewController() -> UINavigationController {
        let homeRouter = HomeRouter()
        let homeViewModel = HomeViewModel(router: homeRouter)
        let homeViewController = HomeViewController(viewModel: homeViewModel)
        let navController = NavigationController(rootViewController: homeViewController)
        configureTabBarIcons(navController: navController, icon: .icHome)
        homeRouter.viewController = homeViewController
        return navController
    }
    
    private func createFavoritesViewController() -> UINavigationController {
        let favoritesRouter = FavoritesRouter()
        let favoritesViewModel = FavoritesViewModel(router: favoritesRouter)
        let favoritesViewController = FavoritesViewController(viewModel: favoritesViewModel)
        let navController = NavigationController(rootViewController: favoritesViewController)
        configureTabBarIcons(navController: navController, icon: .icHeart)
        favoritesRouter.viewController = favoritesViewController
        return navController
    }
    
}
