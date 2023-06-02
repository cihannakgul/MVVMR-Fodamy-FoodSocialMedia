//
//  RecipeDetailViewController.swift
//  FodamyCihan
//
//  Created by cihan on 08.05.23.
//

import UIKit
import TinyConstraints
import MobilliumUserDefaults
import UIComponents
import Utilities
import MobilliumBuilders

final class RecipeDetailViewController: BaseViewController<RecipeDetailViewModel> {
    
    private let scrollView = UIScrollViewBuilder()
        .showsHorizontalScrollIndicator(false)
        .showsVerticalScrollIndicator(false)
        .alwaysBounceVertical(false)
        .build()
    
    private let headerView = RecipeDetailHeaderView()
    
    private let contentStackView = UIStackViewBuilder()
        .axis(.vertical)
        .spacing(15)
        .build()
    
    private let topTitleView = RecipeDetailTitlesView()
    
    private let commentCountView = CountView()
    
    private let likeCountView = CountView()
    
    private let countStackView = UIStackViewBuilder()
        .axis(.horizontal)
        .spacing(1)
        .distribution(.fillEqually)
        .build()

    private let userView = UserInfoView(userViewType: .withFollowButton)
    private let stepsView = RecipeDetailInfoView()
    private let ingredientsView = RecipeDetailInfoView()
    
    private let commentsContainerView = UIViewBuilder()
        .backgroundColor(.appWhite)
        .build()
    private let commentsTitleLabel = UILabelBuilder()
        .font(.font(.nunitoBold, size: .xLarge))
        .textColor(.appCinder)
        .text(L10n.General.comments)
        .build()
    private let commentsSeparator = UIViewBuilder()
        .backgroundColor(.appZircon)
        .build()
    private let commentsCollectionView: DynamicHeightCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let width = UIScreen.main.bounds.size.width
        layout.estimatedItemSize = CGSize(width: width, height: 10)
        let collectionView = DynamicHeightCollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .appSecondaryBackground
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CommentCell.self)
        collectionView.register(EmptyCell.self)
        return collectionView
    }()
    
    private let commentButtonContainerView = UIViewBuilder()
        .backgroundColor(.clear)
        .build()
    private let commentButton = UIButtonBuilder()
        .cornerRadius(4)
        .backgroundColor(.appRed)
        .titleFont(.font(.nunitoBold, size: .large))
        .titleColor(.appWhite)
        .build()
    
    private var observer: NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setLocalize()
        subscribeViewModel()
        configureCollectionView()
        viewModel.getRecipeComment()
        viewModel.getRecipeDetail()
        subscribeActions()
        addObserver()
    }
    
    private func subscribeViewModel() {
        viewModel.reloadCommentData = { [weak self] in
            self?.commentsCollectionView.reloadData()
        }
        
        viewModel.reloadDetailData = { [weak self] in
            self?.fillData()
        }
        
        viewModel.toggleIsLiked = { [weak self] in
            guard let self = self else { return }
            self.viewModel.isLiked.toggle()
            
            let isLiked = self.viewModel.isLiked
            if isLiked {
                self.likeCountView.iconColor = .appRed
                self.viewModel.likeCount? += 1
                self.likeCountView.count = self.viewModel.likeCount
            } else {
                self.likeCountView.iconColor = .appCinder
                self.viewModel.likeCount? -= 1
                self.likeCountView.count = self.viewModel.likeCount
            }
        }
        
        viewModel.toggleIsFollowing = { [weak self] in
            guard let self = self else { return }
            self.userView.isFollowing.toggle()
            self.viewModel.isFollowing.toggle()
            
            let isFollowing = self.viewModel.isFollowing
            if isFollowing {
                self.viewModel.userFollowedCount? += 1
            } else {
                self.viewModel.userFollowedCount? -= 1
            }
            
            self.userView.recipeAndFollowerCountText = self.viewModel.recipeAndFollowerCountText
        }
    }
    
    private func addObserver() {
        observer = NotificationCenter.default.addObserver(forName: .reloadDetail, object: nil, queue: nil, using: { [weak self] _ in
            self?.viewModel.resetData()
            self?.viewModel.getRecipeComment()
            self?.viewModel.getRecipeDetail()
        })
    }
}

// MARK: - UILayout
extension RecipeDetailViewController {
    
    private func addSubviews() {
        view.backgroundColor = .appSecondaryBackground
        addScrollView()
        addContentStackView()
        addCommentsContainerView()
        addShareRightBarButton()
    }
    
    private func addScrollView() {
        view.addSubview(scrollView)
        scrollView.edgesToSuperview(excluding: .top)
        scrollView.topToSuperview(usingSafeArea: true)
    }
    
    private func addContentStackView() {
        scrollView.addSubview(contentStackView)
        contentStackView.widthToSuperview()
        contentStackView.edgesToSuperview()
        
        contentStackView.addArrangedSubview(headerView)
        contentStackView.setCustomSpacing(0, after: headerView)
        contentStackView.addArrangedSubview(topTitleView)
        contentStackView.setCustomSpacing(1, after: topTitleView)
        contentStackView.addArrangedSubview(countStackView)
        contentStackView.addArrangedSubview(userView)
        contentStackView.addArrangedSubview(ingredientsView)
        contentStackView.addArrangedSubview(stepsView)
        contentStackView.addArrangedSubview(commentsContainerView)
        contentStackView.addArrangedSubview(commentButtonContainerView)
        
        countStackView.addArrangedSubview(commentCountView)
        countStackView.addArrangedSubview(likeCountView)
        headerView.aspectRatio(1)
    }
    
    private func addCommentsContainerView() {
        commentsContainerView.addSubview(commentsTitleLabel)
        commentsContainerView.addSubview(commentsSeparator)
        commentsContainerView.addSubview(commentsCollectionView)
        
        commentsTitleLabel.edgesToSuperview(excluding: .bottom, insets: .init(top: 11, left: 15, bottom: 11, right: 15))
        
        commentsSeparator.height(1)
        commentsSeparator.edgesToSuperview(excluding: [.top, .bottom])
        commentsSeparator.topToBottom(of: commentsTitleLabel).constant = 11
        
        commentsCollectionView.edgesToSuperview(excluding: .top)
        commentsCollectionView.topToBottom(of: commentsSeparator)
        
        commentButtonContainerView.addSubview(commentButton)
        commentButton.edgesToSuperview(insets: .init(top: 0, left: 15, bottom: 15, right: 15))
        commentButton.addTarget(self, action: #selector(commentButtonTapped), for: .touchUpInside)
    }
    
    private func addShareRightBarButton() {
        let shareBarButton = UIBarButtonItem(image: .icShare, style: .plain, target: self, action: #selector(shareBarButtonTapped))
        navigationItem.rightBarButtonItem = shareBarButton
    }
}

// MARK: - Configure and Localize
extension RecipeDetailViewController {
    
    private func configureCollectionView() {
        commentsCollectionView.dataSource = self
        commentsCollectionView.delegate = self
    }
    
    private func setLocalize() {
        commentCountView.icon = .icComment
        commentCountView.info = L10n.General.comment
        likeCountView.icon = .icHeart.withRenderingMode(.alwaysTemplate)
        likeCountView.info = L10n.General.like
        ingredientsView.title = L10n.General.recipeIngredients
        ingredientsView.icon = .icRestaurant
        stepsView.title = L10n.General.recipeSteps
        stepsView.icon = .icClock
        commentButton.setTitle(L10n.General.addComment, for: .normal)
    }
    
    private func fillData() {
        navigationItem.title = viewModel.recipeName
        headerView.recipeHeaderData = viewModel.recipeHeaderCellItems
        topTitleView.recipeName = viewModel.recipeName
        topTitleView.categoryName = viewModel.categoryName
        topTitleView.timeDifferenceText = viewModel.timeDifferenceText
        commentCountView.count = viewModel.commentCount
        likeCountView.count = viewModel.likeCount
        likeCountView.iconColor = viewModel.isLiked ? .appRed : .appCinder
        userView.username = viewModel.username
        userView.recipeAndFollowerCountText = viewModel.recipeAndFollowerCountText
        userView.userImageUrl = viewModel.userImageUrl
        userView.isFollowing = viewModel.isFollowing
        ingredientsView.iconSubtitle = viewModel.numberOfPeople
        ingredientsView.info = viewModel.ingredients
        stepsView.iconSubtitle = viewModel.time
        stepsView.info = viewModel.steps
        if DefaultsKey.userId.value == viewModel.userId {
            userView.isFollowButtonHidden = true
        }
    }
}

// MARK: - Actions
extension RecipeDetailViewController {
    
    private func subscribeActions() {
        likeCountView.iconButtonTapped = { [weak self] in
            guard let self = self else { return }
            self.viewModel.likeButtonTapped()
        }
        
        userView.followButtonTapped = { [weak self] in
            guard let self = self else { return }
            self.viewModel.followButtonTapped()
        }
    }
    
    @objc
    private func commentButtonTapped() {
        viewModel.commentButtonTapped()
    }
    
    @objc
    private func shareBarButtonTapped() {
        viewModel.shareBarButtonTapped()
    }
}

// MARK: - UICollectionViewDataSource
extension RecipeDetailViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if viewModel.numberOfItemsAt(section: section) == 0 {
            return 1
        } else if viewModel.numberOfItemsAt(section: section) > 3 {
            return 3
        }
        return viewModel.numberOfItemsAt(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if viewModel.numberOfItemsAt(section: 0) == 0 {
            let cell: EmptyCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.infoText = L10n.Modules.RecipeDetail.noComment
            return cell
        }
        
        let cell: CommentCell = collectionView.dequeueReusableCell(for: indexPath)
        let cellItem = viewModel.cellItemAt(indexPath: indexPath)
        cell.set(with: cellItem)
        cell.isMoreButtonHidden = true
        return cell
    }
    
}

// MARK: - UICollectionViewDelegate
extension RecipeDetailViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectComment()
    }
}

// swiftlint:disable line_length
// MARK: - UICollectionViewDelegateFlowLayout
extension RecipeDetailViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 195)
    }
    
}
// swiftlint:enable line_length
