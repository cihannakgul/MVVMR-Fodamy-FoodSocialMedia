//
//  RecipeDetailRouter.swift
//  FodamyCihan
//
//  Created by cihan on 08.05.23.
//

final class RecipeDetailRouter: Router, RecipeDetailRouter.Routes {
    typealias Routes = LoginWarningPopupRoute &
        LoginRoute &
        UnfollowAlertViewRoute &
        CommentListRoute &
        ShareSheetRoute
}
