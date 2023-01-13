//
//  SearchAppInteractor.swift
//  AppSearcher
//
//  Created by Doyoung on 2022/08/06.
//

import Foundation

protocol SearchAppBussinessLogic {
    func searchApp(with id: String) async
    func searchApp(with id: String)
}

protocol SearchAppDataStore {
    var searchedApps: [SearchedApp.Response] { get }
}

final class SearchAppInteractor: SearchAppBussinessLogic, SearchAppDataStore {
    var searchedAppWorker: SearchedAppWorker?
    var presenter: SearchAppPresentionLogic?
    
    var searchedApps = [SearchedApp.Response]()

    func searchApp(with id: String) {
        searchedAppWorker?.fetchSearchedApps(with: id) { [weak self] result in
            switch result {
            case .success(let searched):
                if searched.results.isEmpty {
                    self?.presenter?.presentFailedSearchedApp()
                } else {
                    self?.searchedApps = searched.results
                    self?.presenter?.presentFindSearchedApp()
                }
            case .failure:
                self?.presenter?.presentUnexpectedNetworkError()
            }
        }
    }
    
    func searchApp(with id: String) async {
        guard let worker = searchedAppWorker else { return }
        do {
            let output = try await worker.fetchSeachedApps(with: id)
            if output.results.isEmpty { presenter?.presentFailedSearchedApp() }
            searchedApps = output.results
            presenter?.presentFindSearchedApp()
        } catch {
            presenter?.presentUnexpectedNetworkError()
        }
    }
}
