//
//  CommentListViewModel.swift
//  FodamyCihan
//
//  Created by cihan on 31.05.23.
//

import KeychainSwift
import Utilities
import UIComponents
import DataProvider

protocol CommentListViewDataSource {
    var title: String { get }
    
    func numberOfItemsAt(section: Int) -> Int
    func cellItemAt(indexPath: IndexPath) -> CommentCellProtocol
}

protocol CommentListViewEventSource {
    var reloadData: VoidClosure? { get set }
    var postCommentDidSuccess: VoidClosure? { get set }
    var deleteCommentDidSuccess: IndexPathClosure? { get set }
}

protocol CommentListViewProtocol: CommentListViewDataSource, CommentListViewEventSource {
    func sendButtonTapped(commentText: String)
    func moreButtonTapped(at indexPath: IndexPath)
    func checkComments()
    func checkPages()
    func postNotification()
}

final class CommentListViewModel: BaseViewModel<CommentListRouter>, CommentListViewProtocol {
    
    let title = L10n.Modules.CommentListController.title
    private let recipeId: Int
    private let keychain = KeychainSwift()
    var reloadData: VoidClosure?
    var postCommentDidSuccess: VoidClosure?
    var deleteCommentDidSuccess: IndexPathClosure?
    
    var isRequestEnabled = false
    var isPagingEnabled = false
    private var page = 1
    
    init(recipeId: Int, router: CommentListRouter) {
        self.recipeId = recipeId
        super.init(router: router)
    }
    
    func numberOfItemsAt(section: Int) -> Int {
        return cellItems.count
    }
    
    func cellItemAt(indexPath: IndexPath) -> CommentCellProtocol {
        return cellItems[indexPath.row]
    }
    
    var cellItems: [CommentCellProtocol] = []
}

// MARK: - Actions
extension CommentListViewModel {
    
    func sendButtonTapped(commentText: String) {
        guard keychain.get(Keychain.token) != nil else {
            router.presentLoginWarningPopup(loginHandler: { [weak self] in
                self?.router.presentLogin()
            })
            return
        }
        postRecipeComment(commentText: commentText)
    }
    
    func moreButtonTapped(at indexPath: IndexPath) {
        router.presentCommentEditDeleteAlertView(edit: { [weak self] in
            self?.editCommentButtonTapped(indexPath: indexPath)
        }, delete: { [weak self] in
            self?.deleteCommentRequest(indexPath: indexPath)
        })
    }
    
    private func editCommentButtonTapped(indexPath: IndexPath) {
        let viewModel = cellItems[indexPath.row]
        let commentId = viewModel.commentId
        let commentText = viewModel.commentText
        
        let editCommentDidSuccess: StringClosure = { [weak self] text in
            viewModel.commentText = text
            viewModel.commentTextDidChanged?()
            self?.reloadData?()
            self?.postNotification()
            
        }
        
        router.pushCommentEdit(recipeId: recipeId,
                               commentId: commentId,
                               commentText: commentText,
                               editCommentDidSuccess: editCommentDidSuccess)
    }
}

// MARK: - Network
// swiftlint:disable line_length
extension CommentListViewModel {
    
    func checkComments() {
        self.isRequestEnabled = false
        if page == 1 { showActivityIndicatorView?() }
        let request = GetRecipeCommentsRequest(recipeId: recipeId, page: page)
        dataProvider.request(for: request) { [weak self] (result) in
            guard let self = self else { return }
            self.hideActivityIndicatorView?()
            self.isRequestEnabled = true
            switch result {
            case .success(let response):
                if self.page == 1 {
                    self.cellItems.removeAll()
                }
                let cellItems = response.data.map({ CommentCellModel(comment: $0) })
                self.cellItems.append(contentsOf: cellItems)
                self.isPagingEnabled = response.pagination.currentPage < response.pagination.lastPage
                if self.isPagingEnabled { self.page += 1 }
                self.reloadData?()
            case .failure:
                if self.page == 1 { self.showWarningToast?(L10n.Error.refreshFromTop) }
            }
        }
    }
    // swiftlint:enable line_length
    
    private func deleteCommentRequest(indexPath: IndexPath) {
        let commentId = cellItems[indexPath.row].commentId
        showLoading?()
        let request = RecipeDeleteCommentRequest(recipeId: recipeId, commentId: commentId)
        dataProvider.request(for: request) { [weak self] (result) in
            guard let self = self else { return }
            self.hideLoading?()
            switch result {
            case .success:
                self.cellItems.remove(at: indexPath.row)
                self.deleteCommentDidSuccess?(indexPath)
            case .failure(let error):
                self.showWarningToast?(error.localizedDescription)
            }
        }
    }
    
    private func postRecipeComment(commentText: String) {
        showLoading?()
        let request = RecipePostCommentRequest(recipeId: recipeId, commentText: commentText)
        dataProvider.request(for: request) { [weak self] (result) in
            guard let self = self else { return }
            self.hideLoading?()
            switch result {
            case .success(let response):
                debugPrint(response)
                self.checkComments()
                self.postCommentDidSuccess?()
            case .failure(let error):
                self.showWarningToast?(error.localizedDescription)
            }
        }
    }
    
    func checkPages() {
        checkComments()
    }
    
    func postNotification() {
        NotificationCenter.default.post(name: .reloadDetail, object: nil)
    }
}
