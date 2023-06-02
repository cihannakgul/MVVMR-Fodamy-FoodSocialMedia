//
//  Animator.swift
//  FodamyCihan
//
//  Created by cihan on 16.03.23.
//

import UIKit

protocol Animator: UIViewControllerAnimatedTransitioning {
    var isPresenting: Bool { get set }
}
