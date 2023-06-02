//
//  ShareSheet.swift
//  FodamyCihan
//
//  Created by cihan on 01.06.23.
//

import UIKit

protocol ShareSheetRoute {
    func presentShareSheet(items: [Any])
}

extension ShareSheetRoute where Self: RouterProtocol {
    
    func presentShareSheet(items: [Any]) {
        let shareSheetController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        
        let transition = ModalTransition()
        
        open(shareSheetController, transition: transition)
    }
}
