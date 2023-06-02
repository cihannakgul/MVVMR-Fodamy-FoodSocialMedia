//
//  PhotoDK.swift
//  FodamyCihan
//
//  Created by cihan on 31.05.23.
//

import SKPhotoBrowser
import Utilities

final class PhotoSlider: SKPhotoBrowserDelegate {

    var willDismissAtPage: IntClosure?

    func willDismissAtPageIndex(_ index: Int) {
        if let didDismiss = willDismissAtPage {
            didDismiss(index)
        }
    }
    
}
