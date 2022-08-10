//
//  AppDetailRouter.swift
//  AppSearcher
//
//  Created by Doyoung on 2022/08/07.
//

import UIKit

protocol AppDetailDataPassing {
    var dataStore: AppDetailDataStore? { get }
}

protocol AppDetailRoutingLogice {
    func routeToSearchApp()
    func routeToPreviewDetail()
}

final class AppDetailRouter: AppDetailDataPassing, AppDetailRoutingLogice {
    weak var viewController: AppDetailViewController?
    var dataStore: AppDetailDataStore?
    
    func routeToSearchApp() {
        navigateToSearchApp()
    }
    func routeToPreviewDetail() {
        let destinationViewController = PreviewDetailViewController()
        guard let dataStore = dataStore,
              var destinationDataStore = destinationViewController.router?.dataStore else { return }
        passDataToPreviewDetail(source: dataStore, &destinationDataStore)
        showPreviewDetail(destinationViewController)
    }
    //MARK: - Navigation
    func navigateToSearchApp() {
        viewController?.navigationController?.popViewController(animated: false)
    }
    func showPreviewDetail(_ destination: UIViewController) {
        destination.modalPresentationStyle = .fullScreen
        viewController?.present(destination, animated: true)
    }
    //MARK: - Passing data
    func passDataToPreviewDetail(source: AppDetailDataStore, _ desination: inout PreviewDetailDataStore) {
        guard let searchedApp = source.searchedApp else { return }
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            desination.previewURL = searchedApp.screenshotUrls
        case .tv:
            desination.previewURL = searchedApp.appletvScreenshotUrls
        default:
            desination.previewURL = searchedApp.ipadScreenshotUrls
        }
    }
}
