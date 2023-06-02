//
//  EmptyModel.swift
//  UIComponents
//
//  Created by cihan on 31.05.23.
//

 
import Foundation

public protocol EmptyCellDataSource: AnyObject {
    
}

public protocol EmptyCellEventSource: AnyObject {
    
}

public protocol EmptyCellProtocol: EmptyCellDataSource, EmptyCellEventSource {
    
}

public final class EmptyCellModel: EmptyCellProtocol {
    
}

