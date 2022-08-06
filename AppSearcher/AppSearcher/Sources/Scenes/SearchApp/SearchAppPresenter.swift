//
//  SearchAppPresenter.swift
//  AppSearcher
//
//  Created by Doyoung on 2022/08/06.
//

import Foundation

protocol SearchAppPresentionLogic {
    func presentFindSearchedApp()
}

final class SearchAppPresenter: SearchAppPresentionLogic {
    weak var viewController: SearchAppDisplayLogic?
    
    init(_ viewController: SearchAppDisplayLogic) {
        self.viewController = viewController
    }
    
    func presentFindSearchedApp() {
        viewController?.displaySuccessSearching()
    }
    func presentFailedSearchedApp() {
    }
    func presentUnexpectedNetworkError() {
    }
}
