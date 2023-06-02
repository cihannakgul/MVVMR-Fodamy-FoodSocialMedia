//
//  ToastPresenter.swift
//  UIComponents
//
//  Created by cihan on 01.06.23.
//

import Foundation
import SwiftEntryKit
import MobilliumBuilders

public class ToastPresenter {
    
    public static func showWarningToast(text: String) {
        var attributes = EKAttributes.topToast
        attributes.entryBackground = .color(color: EKColor(light: .appRed, dark: .appRed))
        attributes.entranceAnimation = .translation
        attributes.exitAnimation = .translation

        let customView = TostWarningView(text: text)
        SwiftEntryKit.display(entry: customView, using: attributes)
    }
}


class TostWarningView: UIView {
    
    private let label = UILabelBuilder()
        .font(.font(.nunitoSemiBold, size: .large))
        .textColor(.appWhite)
        .textAlignment(.center)
        .numberOfLines(0)
        .build()
    
    init(text: String) {
        label.text = text
        label.sizeToFit()
        super.init(frame: .zero)
        configureContents()
    }
    
    // swiftlint:disable fatal_error unavailable_function
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // swiftlint:enable fatal_error unavailable_function
    
    private func configureContents() {
        addSubview(label)
        label.edgesToSuperview(insets: .init(top: 14, left: 14, bottom: 14, right: 14))
    }
    
}
