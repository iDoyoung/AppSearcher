//
//  AppDetailInteractor.swift
//  AppSearcher
//
//  Created by Doyoung on 2022/08/07.
//

import Foundation

protocol AppDetailBussinessLogic {
    func getSearchedApp()
}

protocol AppDetailDataStore {
    var searchedApp: SearchedApp.Response? { get set }
}

final class AppDetailInteractor: AppDetailBussinessLogic, AppDetailDataStore {
    var searchedApp: SearchedApp.Response?
    var presenter: AppDetailPresentationLogic?
    
    func getSearchedApp() {
        guard let searchedApp = searchedApp else {
            return
        }
        presenter?.presentSearched(searchedApp)
    }
}
