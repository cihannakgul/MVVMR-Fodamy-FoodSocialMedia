//
//  Extensions.swift
//  UIComponents
//
//  Created by cihan on 09.05.23.
//

import Foundation
import DataProvider
import MobilliumUserDefaults
import Kingfisher


public extension UIImageView {
    static let fadeAnimation = KingfisherOptionsInfoItem.transition(.fade(0.2))

    func setImage(_ string: String?, placeholder: UIImage? = nil) {
        self.kf.indicatorType = .activity
        let url = URL(string: string ?? "")
        let width = UIScreen.main.bounds.width
        let processor = ResizingImageProcessor(referenceSize: CGSize(width: width, height: width), mode: .aspectFit)
        self.kf.setImage(with: url, placeholder: placeholder, options: [UIImageView.fadeAnimation, .processor(processor)])
    }
    
    
}


public extension UICollectionView {
    
    func register<T: UICollectionViewCell>(_: T.Type) where T: ReusableView {
        register(T.self, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func registerHeader<T: UICollectionReusableView>(_: T.Type) where T: ReusableView {
        register(T.self,
                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                 withReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func registerFooter<T: UICollectionReusableView>(_: T.Type) where T: ReusableView {
        register(T.self,
                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                 withReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    // swiftlint:disable fatal_error
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        return cell
    }
    
    func dequeueReusableCell<T: UICollectionReusableView>(ofKind: String, for indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = dequeueReusableSupplementaryView(ofKind: ofKind, withReuseIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        return cell
    }
    // swiftlint:enable fatal_error
    
}

public extension ReusableView where Self: UIView {
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}


extension CommentCellModel {
    
    public convenience init(comment: RecipeComment) {
        let recipeAndFollowerCountText = "\(comment.user.recipeCount) \(L10n.General.recipe) \(comment.user.followedCount) \(L10n.General.follower)"
        let isOwner = comment.user.id == DefaultsKey.userId.value
        self.init(userId: comment.user.id,
                  imageUrl: comment.user.image?.url,
                  username: comment.user.username,
                  recipeAndFollowerCountText: recipeAndFollowerCountText,
                  timeDifferenceText: comment.timeDifference,
                  commentId: comment.id,
                  commentText: comment.text,
                  isOwner: isOwner)
    }
}
