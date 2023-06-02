//
//  RecipeDetailHeaderView.swift
//  FodamyCihan
//
//  Created by cihan on 31.05.23.
//

import UIKit
import MobilliumBuilders
import UIComponents

final class RecipeDetailHeaderView: UIView {
    
    private let  collectionView = UICollectionViewBuilder()
        .allowsMultipleSelection(false)
        .scrollDirection(.horizontal)
        .backgroundColor(.clear)
        .isPagingEnabled(true)
        .showsHorizontalScrollIndicator(false)
        .registerCell(RecipeHeaderCell.self, reuseIdentifier: "RecipeHeaderCell")
        .build()
    
    private let pageControl = UIPageControlBuilder<PageControl>()
        .build()
    
    // swiftlint:disable weak_delegate
    var photoBrowserDelegate: PhotoSlider?
    // swiftlint:enable weak_delegate
    
    var recipeHeaderData: [RecipeHeaderCellProtocol] = [] {
        didSet {
            collectionView.reloadData()
            pageControl.numberOfPages = recipeHeaderData.count
            pageControl.isHidden = pageControl.numberOfPages == 1
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        configurePhotoBrowserDelegate()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubViews()
        configurePhotoBrowserDelegate()
    }
}

// MARK: - UILayout
extension RecipeDetailHeaderView {
    
    private func addSubViews() {
        collectionView.delegate = self
        collectionView.dataSource = self
        addSubview(collectionView)
        collectionView.edgesToSuperview()
        
        addSubview(pageControl)
        pageControl.bottom(to: collectionView)
        pageControl.centerX(to: collectionView)
    }
}

// MARK: - Configure
extension RecipeDetailHeaderView {
    
    private func configurePhotoBrowserDelegate() {
        photoBrowserDelegate = PhotoSlider()
        photoBrowserDelegate?.willDismissAtPage = { [weak self] (index) in
            guard let self = self else { return }
            let indexPath = IndexPath(item: index, section: 0)
            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            self.pageControl.currentPage = index
        }
    }
}

// MARK: - UICollectionViewDelegate
extension RecipeDetailHeaderView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let delegate = photoBrowserDelegate else { return }
        let photos = recipeHeaderData.map { $0.imageUrl }
        AppRouter.shared.presentSKPhotoBrowser(with: photos, delegate: delegate, initialPageIndex: indexPath.row)
    }
    
}

// MARK: - UICollectionViewDataSource
extension RecipeDetailHeaderView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipeHeaderData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: RecipeHeaderCell = collectionView.dequeueReusableCell(for: indexPath)
        let currentRecipeHeaderModel = recipeHeaderData[indexPath.row]
        cell.set(with: currentRecipeHeaderModel)
        return cell
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension RecipeDetailHeaderView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
}

// MARK: - UIScrollViewDelegate
extension RecipeDetailHeaderView {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    
}
