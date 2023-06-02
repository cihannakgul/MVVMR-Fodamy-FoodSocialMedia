//
//  PlaceOnWindowTransition.swift
//  FodamyCihan
//
//  Created by cihan on 17.03.23.
//

import UIKit
class PlaceOnWindowTransition: Transition {
    func close(_ viewController: UIViewController) {
    }
    
    var viewController: UIViewController?
    
    func open(_ viewController: UIViewController) {
        guard let window = UIApplication.shared.windows.first else { return }
        UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: {
            UIView.performWithoutAnimation {
                window.rootViewController = viewController
            }
        }, completion: nil)
    }

}
