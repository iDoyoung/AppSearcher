//
//  SearchAppPresenter.swift
//  AppSearcher
//
//  Created by Doyoung on 2022/08/06.
//

import Foundation

protocol SearchAppPresentionLogic {
    func presentFindSearchedApp()
    func presentFailedSearchedApp()
    func presentUnexpectedNetworkError()
}

final class SearchAppPresenter: SearchAppPresentionLogic {
    weak var viewController: SearchAppDisplayLogic?
    
    func presentFindSearchedApp() {
        viewController?.displaySuccessSearching()
    }
    func presentFailedSearchedApp() {
        viewController?.displayFailedSearching()
    }
    func presentUnexpectedNetworkError() {
        viewController?.displayUnexpectedNetworkError()
    }
}
