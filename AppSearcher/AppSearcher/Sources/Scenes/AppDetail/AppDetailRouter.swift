//
//  AppDetailRouter.swift
//  AppSearcher
//
//  Created by Doyoung on 2022/08/07.
//

import Foundation

protocol AppDetailDataPassing {
    var dataStore: AppDetailDataStore? { get }
}

protocol AppDetailRoutingLogice {
    func routeToSearchApp()
}

final class AppDetailRouter: AppDetailDataPassing, AppDetailRoutingLogice {
    weak var viewController: AppDetailViewController?
    var dataStore: AppDetailDataStore?
    
    func routeToSearchApp() {
        navigateToSearchApp()
    }
    //MARK: - Navigation
    func navigateToSearchApp() {
        viewController?.navigationController?.popViewController(animated: false)
    }
}
