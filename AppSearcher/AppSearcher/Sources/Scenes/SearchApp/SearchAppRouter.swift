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
        var destinationDataStore = destinationViewController.router!.dataStore!
        passDataToAppDetail(source: dataStore!, &destinationDataStore)
        navigateTo(destinationViewController)
    }
    //MARK: - Navigation
    func navigateTo(_ destination: UIViewController) {
        viewController?.navigationController?.pushViewController(destination, animated: true)
    }
    //MARK: = Passing data
    func passDataToAppDetail(source: SearchAppDataStore, _ destination: inout AppDetailDataStore) {
        destination.searchedApp = source.searchedApps.first
    }
}
