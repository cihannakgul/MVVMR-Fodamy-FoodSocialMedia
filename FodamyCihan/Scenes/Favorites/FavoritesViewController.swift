//
//  FavoritesViewController.swift
//  FodamyCihan
//
//  Created by cihan on 29.03.23.
//

import UIKit
import MobilliumBuilders

final class FavoritesViewController: BaseViewController<FavoritesViewModel> {
    private let imageView = UIImageViewBuilder().build()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .appZircon
        addNavigationBarLogo()
    }
    
    private func addNavigationBarLogo() {
        imageView.image = UIImage.imgLogoFodamy
        navigationItem.titleView = imageView
        imageView.contentMode = .scaleAspectFit
        imageView.width(110)
        imageView.height(30)
    }
    
}
