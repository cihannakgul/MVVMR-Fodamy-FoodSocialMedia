//
//  CommentEditViewController.swift
//  FodamyCihan
//
//  Created by cihan on 01.06.23.
//

import UIKit
import MobilliumBuilders
import Utilities
import UIComponents

final class CommentEditViewController: BaseViewController<CommentEditViewModel> {
    
    private let commentTextView = UITextViewBuilder()
        .font(.font(.nunitoSemiBold, size: .large))
        .textColor(.appRaven)
        .build()
    
    private let bottomView = UIView()
    private let saveButton = UIButtonBuilder()
        .cornerRadius(4)
        .backgroundColor(.appRed)
        .titleFont(.font(.nunitoBold, size: .medium))
        .titleColor(.appWhite)
        .build()
    
    private let keyboardHelper = KeyboardHelper()
    private var bottomViewBottomConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        configureContents()
        setLocalize()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        commentTextView.becomeFirstResponder()
    }
}

// MARK: - UILayout
extension CommentEditViewController {
    
    private func addSubViews() {
        addCommentTextView()
        addBottomView()
    }
    
    private func addCommentTextView() {
        view.addSubview(commentTextView)
        commentTextView.edgesToSuperview(excluding: .bottom, insets: UIEdgeInsets(top: 26, left: 15, bottom: 0, right: 15), usingSafeArea: true)
        commentTextView.height(150)
    }
    
    private func addBottomView() {
        view.addSubview(bottomView)
        bottomView.widthToSuperview()
        bottomViewBottomConstraint = bottomView.bottomToSuperview(usingSafeArea: true)
        bottomViewBottomConstraint?.isActive = true
        bottomView.height(75)
        
        bottomView.addSubview(saveButton)
        saveButton.topToSuperview()
        saveButton.centerXToSuperview()
        saveButton.size(CGSize(width: 162.5, height: 50))
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
}

// MARK: - Configure and Localize
extension CommentEditViewController {
    
    private func configureContents() {
        navigationItem.title = viewModel.title
        keyboardHelper.delegate = self
        commentTextView.text = viewModel.commentText
    }
    
    private func setLocalize() {
        saveButton.setTitle(L10n.Modules.CommentEditController.save, for: .normal)
    }
}

// MARK: - Actions
extension CommentEditViewController {
    
    @objc
    private func saveButtonTapped() {
        guard let commentText = commentTextView.text, !commentText.isEmpty else {
            showWarningToast(message: L10n.Error.empty(""))
            return
        }
        viewModel.editComment(commentText: commentText)
    }
}

// MARK: - KeyboardHelper Delegate
extension CommentEditViewController: KeyboardHelperDelegate {
    
    func keyboardWillShow(_ keyboardHeight: CGFloat) {
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self = self else { return }
            self.bottomViewBottomConstraint?.constant = self.view.safeAreaInsets.bottom - keyboardHeight
            self.view.layoutIfNeeded()
        }
    }
    
    func keyboardWillHide() {
        UIView.animate(withDuration: 0.2) { [weak self] in
            guard let self = self else { return }
            self.bottomViewBottomConstraint?.constant = 0
            self.view.layoutIfNeeded()
        }
    }
        
}
