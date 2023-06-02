//
//  HomeViewController.swift
//  FodamyCihan
//
//  Created by cihan on 10.03.23.
//

import UIKit
import Segmentio
import MobilliumBuilders


final class HomeViewController: BaseViewController<HomeViewModel> {
    private lazy var subViewControllers: [UIViewController] = {
        return self.allViewControllers()
    }()
    
    private let imageView = UIImageViewBuilder().build()

    var pageVC: UIPageViewController = {
       let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
       return pageViewController
   }()
        
    private lazy var segmentioView: Segmentio = {
        let segmentView = Segmentio()
        segmentView.setup(content: [SegmentioItem(title: viewModel.segmentBarTitles[0], image: nil),
                                    SegmentioItem(title: viewModel.segmentBarTitles[1], image: nil)], style: .onlyLabel, options: options())
    return segmentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureContents()
        addNavigationBarLogo()
        addPageViewController()
        addSegmentioView()
        configureSegmentio()
    }
}

// MARK: - SubViewControllers
extension HomeViewController {
    private func allViewControllers() -> [UIViewController] {
        let editorChoiceRouter = RecipesRouter()
        let editorChoiceViewModel = RecipesViewModel(recipesType: .editorChoice, router: editorChoiceRouter)
        let editorChoiceviewController = RecipesViewController(viewModel: editorChoiceViewModel)
         editorChoiceRouter.viewController = editorChoiceviewController
         
        let lastAddedRouter = RecipesRouter()
        let lastAddedRecipesViewModel = RecipesViewModel(recipesType: .lastAdded, router: lastAddedRouter)
        let lastAddedRecipesviewController = RecipesViewController(viewModel: lastAddedRecipesViewModel)
         lastAddedRouter.viewController = lastAddedRecipesviewController
         
         return [
             editorChoiceviewController,
             lastAddedRecipesviewController
         ]
    }
}
// MARK: - Configure UI
extension HomeViewController {
    private func addNavigationBarLogo() {
        imageView.image = UIImage.imgLogoFodamy
        navigationItem.titleView = imageView
        imageView.contentMode = .scaleAspectFit
        imageView.width(110)
        imageView.height(30)
    }
    private func configureContents() {
        pageVC.dataSource = self
        pageVC.delegate = self
        view.addSubview(pageVC.view)
        view.addSubview(segmentioView)
    }
    
    private func addPageViewController() {
        pageVC.didMove(toParent: self)
        pageVC.view.topToBottom(of: segmentioView)
        pageVC.view.leadingToSuperview()
        pageVC.view.trailingToSuperview()
        pageVC.view.bottomToSuperview()
        pageVC.setViewControllers([subViewControllers[viewModel.selectedSegmentIndex]], direction: .forward, animated: true, completion: nil)
        addChild(pageVC)

    }
    
    private func addSegmentioView() {
        segmentioView.topToSuperview(usingSafeArea: true)
        segmentioView.trailingToSuperview()
        segmentioView.leadingToSuperview()
        segmentioView.height(50)
        
    }
    private func configureSegmentio() {
        segmentioView.selectedSegmentioIndex = viewModel.selectedSegmentIndex
        segmentioView.valueDidChange = { [weak self] _, segmentIndex in
            self?.switchPage(segmentIndex: segmentIndex)
        }
    }
    
}
// MARK: - UIPageViewController
extension HomeViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = subViewControllers.firstIndex(of: viewController), currentIndex > 0 else {
            return nil
        }
        return subViewControllers[currentIndex - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = subViewControllers.firstIndex(of: viewController), currentIndex < subViewControllers.count - 1 else {
                 return nil
             }
             return subViewControllers[currentIndex + 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
      
        if let currentVC = pageViewController.viewControllers?.first, let currentIndex = subViewControllers.firstIndex(of: currentVC) {
            segmentioView.selectedSegmentioIndex = currentIndex
        }
    }
    
}

// MARK: - SegmentIO
extension HomeViewController {
    func switchPage(segmentIndex: Int) {
        guard segmentIndex < subViewControllers.count else {
            return
        }
        let direction: UIPageViewController.NavigationDirection = segmentIndex > pageVC.viewControllers!.first!.view.tag ? .forward : .reverse
        pageVC.setViewControllers([subViewControllers[segmentIndex]], direction: direction, animated: true, completion: nil)
    }
    
    private func options() -> SegmentioOptions {
        let indicatorOptions = SegmentioIndicatorOptions(type: .bottom, ratio: 0.32, height: 2, color: .appRed)
        let horizontalSeparatorOptions = SegmentioHorizontalSeparatorOptions(type: .none, height: 0, color: .appWhite)
        let verticalSeparatorOptions = SegmentioVerticalSeparatorOptions(ratio: 1, color: .appZircon)
        
        let segmentStates = SegmentioStates(defaultState: SegmentioState(backgroundColor: .clear,
                                                                         titleFont: .font(.nunitoBold, size: .medium),
                                                                         titleTextColor: .appCinder),
                                            selectedState: SegmentioState(backgroundColor: .clear,
                                                                          titleFont: .font(.nunitoBold, size: .medium),
                                                                          titleTextColor: .appRed),
                                            highlightedState: SegmentioState(backgroundColor: .clear,
                                                                             titleFont: .font(.nunitoBold, size: .medium),
                                                                             titleTextColor: .appRed))
        
        let options = SegmentioOptions(backgroundColor: .appWhite,
                                       segmentPosition: .fixed(maxVisibleItems: 2),
                                       scrollEnabled: false, indicatorOptions: indicatorOptions,
                                       horizontalSeparatorOptions: horizontalSeparatorOptions,
                                       verticalSeparatorOptions: verticalSeparatorOptions,
                                       imageContentMode: .center,
                                       labelTextAlignment: .center,
                                       segmentStates: segmentStates)
        return options
    }
}
