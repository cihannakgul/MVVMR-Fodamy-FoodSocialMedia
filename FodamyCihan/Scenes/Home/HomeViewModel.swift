//
//  HomeViewModel.swift
//  FodamyCihan
//
//  Created by cihan on 10.03.23.

import UIComponents

protocol HomeViewDataSource {}

protocol HomeViewEventSource {}

protocol HomeViewProtocol: HomeViewDataSource, HomeViewEventSource {}

final class HomeViewModel: BaseViewModel<HomeRouter>, HomeViewProtocol {
    var selectedSegmentIndex = 0
    var segmentBarTitles: [String] = [L10n.Modules.Home.editorChoiceRecipes,
                                            L10n.Modules.Home.lastAddedRecipes]
}
