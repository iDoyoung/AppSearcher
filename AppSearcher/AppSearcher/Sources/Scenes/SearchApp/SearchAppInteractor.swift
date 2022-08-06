//
//  SearchAppInteractor.swift
//  AppSearcher
//
//  Created by Doyoung on 2022/08/06.
//

import Foundation

protocol SearchAppBussinessLogic {
    func searchApp(with id: String)
}

protocol SearchAppDataStore {
    var searchedApps: [SearchedApp] { get }
}

final class SearchAppInteractor: SearchAppBussinessLogic, SearchAppDataStore {
    var searchedAppWorker: SearchedAppWorker?
    var presenter: SearchAppPresentionLogic?
    
    var searchedApps = [SearchedApp]()

    init(searchedAppWorker: SearchedAppWorker, presenter: SearchAppPresentionLogic) {
        self.searchedAppWorker = searchedAppWorker
        self.presenter = presenter
    }
    
    func searchApp(with id: String) {
        searchedAppWorker?.fetchSearchedApps(with: id) { [weak self] result in
            switch result {
            case .success(let searched):
                self?.searchedApps = searched.results
                self?.presenter?.presentFindSearchedApp()
            case .failure(let error):
                print(error)
                switch error {
                case .noResponse:
                    break
                case .parsing:
                    break
                case .urlGeneration:
                    break
                case .error(statusCode: let statusCode, data: let data):
                    break
                }
            }
        }
    }
}
