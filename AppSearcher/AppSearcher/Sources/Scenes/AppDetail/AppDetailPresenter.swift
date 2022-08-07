//
//  AppDetailPresenter.swift
//  AppSearcher
//
//  Created by Doyoung on 2022/08/07.
//

import Foundation

protocol AppDetailPresentationLogic {
    func presentSearched(_ app: SearchedApp.Response)
}

final class AppDetailPresenter: AppDetailPresentationLogic {
    weak var viewController: AppDetailDisplayLogicProtocol?
    
    func presentSearched(_ app: SearchedApp.Response) {
        self.viewController?.displaySearchedApp()
    }
}
