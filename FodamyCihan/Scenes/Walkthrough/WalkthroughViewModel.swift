//
//  WalkthroughViewModel.swift
//  FodamyCihan
//
//  Created by cihan on 10.03.23.
//

import Foundation
import MobilliumUserDefaults
import UIComponents

protocol WalkthroughViewDataSource {
    func numberOfItemsAt(section: Int) -> Int
    func cellItemAt(indexPath: IndexPath) -> WalkthroughCellProtocol
    
}

protocol WalkthroughViewEventSource {}

protocol WalkthroughViewProtocol: WalkthroughViewDataSource, WalkthroughViewEventSource {}

final class WalkthroughViewModel: BaseViewModel<WalkthroughRouter>, WalkthroughViewProtocol {
    func numberOfItemsAt(section: Int) -> Int {
        allCellItems.count
    }
    
    func cellItemAt(indexPath: IndexPath) -> UIComponents.WalkthroughCellProtocol {
        allCellItems[indexPath.row]
    }
    
    private var allCellItems: [WalkthroughCellProtocol] = [WalkthroughCellModel(image: .imgWalkthrough1,
                                                                             titleText: L10n.Modules.WalkThrough.firstTitle,
                                                                             descriptionText: L10n.Modules.WalkThrough.descriptionText),
                                                        WalkthroughCellModel(image: .imgWalkthrough2,
                                                                             titleText: L10n.Modules.WalkThrough.secondTitle,
                                                                             descriptionText: L10n.Modules.WalkThrough.descriptionText),
                                                        WalkthroughCellModel(image: .imgWalkthrough3,
                                                                             titleText: L10n.Modules.WalkThrough.thirdTitle,
                                                                             descriptionText: L10n.Modules.WalkThrough.descriptionText),
                                                        WalkthroughCellModel(image: .imgWalkthrough4,
                                                                             titleText: L10n.Modules.WalkThrough.fourthTitle,
                                                                             descriptionText: L10n.Modules.WalkThrough.descriptionText)]
    
}

extension WalkthroughViewModel {
    func finishedIntro() {
        DefaultsKey.isIntroNotComplete.value = false
        router.presentTabBar()
    }
}
