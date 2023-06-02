//
//  CommentEditRoute.swift
//  FodamyCihan
//
//  Created by cihan on 01.06.23.
//

import Utilities

protocol CommentEditRoute {
    func pushCommentEdit(recipeId: Int, commentId: Int, commentText: String?, editCommentDidSuccess: StringClosure?)
}

extension CommentEditRoute where Self: RouterProtocol {
    
    func pushCommentEdit(recipeId: Int, commentId: Int, commentText: String?, editCommentDidSuccess: StringClosure?) {
        let router = CommentEditRouter()
        let viewModel = CommentEditViewModel(recipeId: recipeId, commentId: commentId, commentText: commentText, router: router)
        let viewController = CommentEditViewController(viewModel: viewModel)
        viewModel.editCommentDidSuccess = editCommentDidSuccess
        
        let transition = PushTransition()
        router.viewController = viewController
        router.openTransition = transition
        
        open(viewController, transition: transition)
    }
}
