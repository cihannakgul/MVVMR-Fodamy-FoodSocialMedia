//
//  UnfollowAlertViewRoute.swift
//  FodamyCihan
//
//  Created by cihan on 01.06.23.
//

import UIKit
import Utilities

protocol UnfollowAlertViewRoute {
    func presentUnfollowAlertView(unFollowAction: VoidClosure?)
}

extension UnfollowAlertViewRoute where Self: RouterProtocol {
    
    func presentUnfollowAlertView(unFollowAction: VoidClosure?) {
        let transition = ModalTransition()
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let unFollowAction = UIAlertAction(title: "Takibi Bırak", style: .destructive) {_ in
            unFollowAction?()
        }
        let dismissAction = UIAlertAction(title: "İptal", style: .cancel, handler: nil)
        
        alert.addAction(unFollowAction)
        alert.addAction(dismissAction)
        
        open(alert, transition: transition)
    }
}
