//
//  CommentListRouter.swift
//  FodamyCihan
//
//  Created by cihan on 31.05.23.
//

final class CommentListRouter: Router, CommentListRouter.LoginRoutes, CommentListRouter.CommentRoutes {
    typealias LoginRoutes = LoginWarningPopupRoute & LoginRoute
    typealias CommentRoutes = CommentEditDeleteAlertViewRoute & CommentEditRoute
    
}
