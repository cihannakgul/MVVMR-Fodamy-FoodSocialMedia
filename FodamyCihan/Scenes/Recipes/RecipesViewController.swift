//
//  RecipesViewController.swift
//  FodamyCihan
//
//  Created by cihan on 05.04.23.
//

import UIKit
import UIComponents
import MobilliumBuilders

final class RecipesViewController: BaseViewController<RecipesViewModel> {
    private let refreshControl = UIRefreshControl()
    private var loadingFooterView: ActivityIndicatorFooterView?
    private let collectionView = UICollectionViewBuilder()
         .backgroundColor(.clear)
         .build()
     
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        configureContents()
        listeningEvents()
        viewModel.fetchingRecipes()
    }

}

// MARK: - UILayout
extension RecipesViewController {
    private func addSubViews() {
        view.addSubview(collectionView)
        collectionView.edgesToSuperview()
    }
}

// MARK: - Configure
extension RecipesViewController {
    private func configureContents() {
        view.backgroundColor = .appSecondaryBackground
        navigationItem.title = viewModel.title
        refreshControl.addTarget(self, action: #selector(pull), for: .valueChanged)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(RecipeCell.self, forCellWithReuseIdentifier: "RecipeCell")
        collectionView.register(ActivityIndicatorFooterView.self,
                                  forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                  withReuseIdentifier: ActivityIndicatorFooterView.identifier)
        collectionView.refreshControl = refreshControl
    }
}

extension RecipesViewController {
    private func listeningEvents() {
        viewModel.didSuccessFetchRecipes = { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}

// MARK: - Actions
extension RecipesViewController {
    @objc
    private func pull() {
        viewModel.cellItems.isEmpty ? viewModel.fetchingRecipes() : nil
        refreshControl.endRefreshing()
    }
}

extension RecipesViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > scrollView.contentSize.height - scrollView.frame.size.height, viewModel.isPagingEnabled, viewModel.isRequestEnabled {
            viewModel.checkPages()
        }
    }
}

// MARK: - UICollectionViewDataSource
extension RecipesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return viewModel.numberOfItems
       }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //let cell: RecipeCell = collectionView.dequeueReusableCell(for: indexPath)
        // swiftlint:disable fatal_error unavailable_function
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeCell.identifier, for: indexPath) as? RecipeCell else { fatalError("Could not dequeu RecipeCell") }
        // swiftlint:enable fatal_error unavailable_function
        let cellViewModel = viewModel.cellItem(for: indexPath)
        cell.set(viewModel: cellViewModel)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        let footer: ActivityIndicatorFooterView = collectionView.dequeueReusableCell(ofKind: kind, for: indexPath)
        loadingFooterView = footer
        return footer
    }

    func collectionView(_ collectionView: UICollectionView,
                        willDisplaySupplementaryView view: UICollectionReusableView,
                        forElementKind elementKind: String,
                        at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            self.loadingFooterView?.activityIndicator.startAnimating()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didEndDisplayingSupplementaryView view: UICollectionReusableView,
                        forElementOfKind elementKind: String, at indexPath: IndexPath) {
            if elementKind == UICollectionView.elementKindSectionFooter {
                self.loadingFooterView?.activityIndicator.stopAnimating()
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension RecipesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectRecipe(at: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWitdh = view.frame.width
        let recipeImageHeight = cellWitdh - viewModel.decreaseCellWidth
        let cellHeight = recipeImageHeight + viewModel.otherCellItemsHeight
        return CGSize(width: cellWitdh, height: cellHeight)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForFooterInSection section: Int) -> CGSize {
        let height: CGFloat = viewModel.isPagingEnabled ? 100 : 0
        return CGSize(width: collectionView.bounds.size.width, height: height)
    }
}
