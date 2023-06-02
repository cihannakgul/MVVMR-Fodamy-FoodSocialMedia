//
//  PhotoRoute.swift
//  FodamyCihan
//
//  Created by cihan on 31.05.23.
//

import SKPhotoBrowser

protocol SKPhotoBrowserRoute {
    func presentSKPhotoBrowser(with photos: [String], viewController: UIViewController, initialPageIndex: Int, delegate: PhotoSlider)
}

extension SKPhotoBrowserRoute where Self: RouterProtocol {
    
    func presentSKPhotoBrowser(with photos: [String], viewController: UIViewController, initialPageIndex: Int, delegate: PhotoSlider) {
        let skPhotos = photos.map { SKPhoto.photoWithImageURL($0) }
        let photoBrowser = SKPhotoBrowser(photos: skPhotos, initialPageIndex: initialPageIndex)
        photoBrowser.delegate = delegate
        viewController.present(photoBrowser, animated: true)
    }
    
}
