//
//  SearchAppRouter.swift
//  AppSearcher
//
//  Created by Doyoung on 2022/08/07.
//

import UIKit

protocol SearchAppDataPassing {
    var dataStore: SearchAppDataStore? { get }
}

protocol SearchAppRoutingLogic {
    func routeToAppDetail()
}

final class SearchAppRouter: SearchAppDataPassing, SearchAppRoutingLogic {
    weak var viewController: SearchAppViewController?
    var dataStore: SearchAppDataStore?
    
    func routeToAppDetail() {
        let destinationViewController = AppDetailViewController()
        navigateTo(destinationViewController)
    }
    
    func navigateTo(_ destination: UIViewController) {
        viewController?.show(destination, sender: nil)
    }
    
}
