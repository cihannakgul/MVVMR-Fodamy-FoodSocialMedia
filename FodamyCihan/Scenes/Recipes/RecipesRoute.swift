//
//  RecipesRoute.swift
//  FodamyCihan
//
//  Created by cihan on 05.04.23.
//

protocol RecipesRoute {
    func pushRecipes(categoryId: Int, title: String)
}

extension RecipesRoute where Self: RouterProtocol {
    
    func pushRecipes(categoryId: Int, title: String) {
        let router = RecipesRouter()
        let viewModel = RecipesViewModel(recipesType: .categoryRecipes(categoryId: categoryId), router: router)
        let viewController = RecipesViewController(viewModel: viewModel)
        
        let transition = PushTransition()
        router.viewController = viewController
        router.openTransition = transition
        
        open(viewController, transition: transition)
    }
}
