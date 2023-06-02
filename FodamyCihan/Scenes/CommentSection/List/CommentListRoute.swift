//
//  CommentListRoute.swift
//  FodamyCihan
//
//  Created by cihan on 31.05.23.
//

protocol CommentListRoute {
    func pushCommentList(recipeId: Int, isKeyboardOpen: Bool?)
}

extension CommentListRoute where Self: RouterProtocol {
    
    func pushCommentList(recipeId: Int, isKeyboardOpen: Bool?) {
        let router = CommentListRouter()
        let viewModel = CommentListViewModel(recipeId: recipeId, router: router)
        let viewController = CommentListViewController(viewModel: viewModel)
        viewController.isKeyboardOpen = isKeyboardOpen ?? false
        let transition = PushTransition()
        router.viewController = viewController
        router.openTransition = transition
        
        open(viewController, transition: transition)
    }
}
