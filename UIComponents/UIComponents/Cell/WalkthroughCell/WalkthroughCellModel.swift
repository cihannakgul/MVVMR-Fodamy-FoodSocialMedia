//
//  WalkthroughCellModel.swift
//  UIComponents
//
//  Created by cihan on 22.03.23.
//

import Foundation
import UIKit
public protocol WalkthroughCellDataSource: AnyObject {
    var image: UIImage { get }
    var titleText: String { get }
    var descriptionText: String { get }
 
}

public protocol WalkthroughCellEventSource: AnyObject {
    
}

public protocol WalkthroughCellProtocol: WalkthroughCellDataSource, WalkthroughCellEventSource {
    
}

public final class WalkthroughCellModel: WalkthroughCellProtocol {
    public var titleText: String
    public var descriptionText: String
    public var image: UIImage
    
    public init(image: UIImage, titleText: String, descriptionText: String) {
        self.titleText = titleText
        self.descriptionText = descriptionText
        self.image = image
    }
}
