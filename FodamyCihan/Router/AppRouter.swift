//
//  AppRouter.swift
//  FodamyCihan
//
//  Created by cihan on 08.03.23.
//

import Foundation
import DataProvider
import UIKit
import MobilliumUserDefaults

final class AppRouter: Router, AppRouter.Routes {
    
    typealias Routes = WalkthroughRoute & TabBarRoute & SKPhotoBrowserRoute
    
    static let shared = AppRouter()

    func startApp() {
        DataProviderAPIClient.testRun()
        if DefaultsKey.isIntroNotComplete.value == true {
            AppRouter.shared.presentWalkthrough()
        } else {
            AppRouter.shared.presentTabBar()
        }
     }
    
    func presentSKPhotoBrowser(with photos: [String], delegate: PhotoSlider, initialPageIndex: Int = 0) {
        guard let topVC = topViewController() else { return }
        presentSKPhotoBrowser(with: photos, viewController: topVC, initialPageIndex: initialPageIndex, delegate: delegate)
    }
    
    private func topViewController() -> UIViewController? {
        let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow })
        if var topController = keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        return nil
    }
    
}
