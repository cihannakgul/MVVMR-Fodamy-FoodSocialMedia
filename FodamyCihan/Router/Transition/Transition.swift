//
//  Transition.swift
//  FodamyCihan
//
//  Created by cihan on 16.03.23.
//

import Foundation
import UIKit
protocol Transition: AnyObject {
    var viewController: UIViewController? { get set }
    
    func open(_ viewController: UIViewController)
    func close(_ viewController: UIViewController)
}
