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
    func presentFailedSearchingAlert()
    func presentUnexpectedNetworkErrorAlert()
}

final class SearchAppRouter: SearchAppDataPassing, SearchAppRoutingLogic {
    weak var viewController: SearchAppViewController?
    var dataStore: SearchAppDataStore?
    
    func routeToAppDetail() {
        let destinationViewController = AppDetailViewController()
        guard let dataStore = dataStore,
              var destinationDataStore = destinationViewController.router?.dataStore else {
            return
        }
        passDataToAppDetail(source: dataStore, &destinationDataStore)
        navigateTo(destinationViewController)
    }
    func presentFailedSearchingAlert() {
        let alert = UIAlertController(title: "검색 결과가 없습니다.",
                                      message: "올바른 id 값으로 검색해주세요.",
                                      preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "확인", style: .cancel)
        alert.addAction(okayAction)
        viewController?.present(alert, animated: true)
    }
    func presentUnexpectedNetworkErrorAlert() {
        let alert = UIAlertController(title: "네트워크 오류",
                                      message: "예기치 못한 네트워크 오류로 검색에 실패했습니다.",
                                      preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "확인", style: .cancel)
        alert.addAction(okayAction)
        viewController?.present(alert, animated: true)
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
