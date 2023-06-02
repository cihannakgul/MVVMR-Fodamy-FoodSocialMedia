//
//  FavoritesViewModel.swift
//  FodamyCihan
//
//  Created by cihan on 29.03.23.
//

protocol FavoritesViewDataSource {}

protocol FavoritesViewEventSource {}

protocol FavoritesViewProtocol: FavoritesViewDataSource, FavoritesViewEventSource {}

final class FavoritesViewModel: BaseViewModel<FavoritesRouter>, FavoritesViewProtocol {
    
}
