//
//  UserInfoView.swift
//  UIComponents
//
//  Created by cihan on 09.05.23.
//

import MobilliumBuilders
import Utilities
import UIKit

public class UserInfoView: UIView {
    
    private lazy var followButton = UIButtonBuilder()
        .cornerRadius(4)
        .backgroundColor(.appRed)
        .titleFont(.font(.nunitoBold, size: .large))
        .titleColor(.appWhite)
        .build()
    
    private let userPhoto = UIImageViewBuilder()
        .cornerRadius(20)
        .clipsToBounds(true)
        .build()
    
    private let textStackView = UIStackViewBuilder()
        .axis(.vertical)
        .distribution(.fillEqually)
        .build()
    
    private let usernameLabel = UILabelBuilder()
        .font(.font(.nunitoBold, size: .medium))
        .textColor(.appCinder)
        .build()
    
    private let recipeAndFollowerCountLabel = UILabelBuilder()
        .font(.font(.nunitoSemiBold, size: .medium))
        .textColor(.appRaven)
        .build()
    
    public var userImageUrl: String? {
        willSet {
            if let url = newValue {
                userPhoto.setImage(url)
            } else {
                userPhoto.image = nil
            }
        }
    }

    public var recipeAndFollowerCountText: String? {
        willSet {
            recipeAndFollowerCountLabel.text = newValue
        }
    }

    public var username: String? {
        willSet {
            usernameLabel.text = newValue
        }
    }

    public var isFollowButtonHidden: Bool? {
        willSet {
            followButton.isHidden = newValue ?? false
        }
    }

    public enum UserViewType {
        case withFollowButton
        case withoutFollowButton
    }

    let userViewType: UserViewType

    public var isFollowing = false {
        didSet {
            updateFollowButtonState()
        }
    }

    public var followButtonTapped: VoidClosure?

    public init(userViewType: UserViewType) {
        self.userViewType = userViewType
        super.init(frame: .zero)
        addSubViews()
    }

    // swiftlint:disable fatal_error unavailable_function
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // swiftlint:enable fatal_error unavailable_function
    
}

// MARK: - UILayout
extension UserInfoView {
    
    private func addSubViews() {
        backgroundColor = .appWhite
        addUserPhoto()
        addTextStackView()
       
    switch userViewType {
        case .withFollowButton:
            addSubview(followButton)
            followButton.trailingToSuperview().constant = -15
            followButton.leadingToTrailing(of: textStackView).constant = 10
            followButton.centerYToSuperview()
            followButton.width(120)
            updateFollowButtonState()
        case .withoutFollowButton:
            textStackView.trailingToSuperview().constant = -15
        }
        followButton.addTarget(self, action: #selector(followButtonTapped(_:)), for: .touchUpInside)
    }
    
    private func addUserPhoto() {
        addSubview(userPhoto)
        userPhoto.edgesToSuperview(excluding: .trailing, insets: .init(top: 15, left: 15, bottom: 15, right: 15))
        userPhoto.width(40)
        userPhoto.height(40)
    }
    
    private func addTextStackView() {
        addSubview(textStackView)
        textStackView.leadingToTrailing(of: userPhoto).constant = 10
        textStackView.centerYToSuperview()
        textStackView.addArrangedSubview(usernameLabel)
        textStackView.addArrangedSubview(recipeAndFollowerCountLabel)
    }
}

// MARK: - Configure
extension UserInfoView {
    
    private func updateFollowButtonState() {
        if isFollowing {
            followButton.setTitle(L10n.General.following, for: .normal)
            followButton.setTitleColor(.white, for: .normal)
            followButton.backgroundColor = .appRed
        } else {
            followButton.setTitle(L10n.General.follow, for: .normal)
            followButton.setTitleColor(.appRed, for: .normal)
            followButton.backgroundColor = .appWhite
        }
    }
}

// MARK: - Actions
extension UserInfoView {
    
    @objc
    private func followButtonTapped(_ sender: Any?) {
        followButtonTapped?()
    }
}

