//
//  ReusableView.swift
//  UIComponents
//
//  Created by cihan on 27.03.23.
//
import Foundation

public protocol ReusableView: AnyObject {
    static var identifier: String { get }
}
