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
        let viewModel = SearchedApp.ViewModel.DisplayedAppDetail(screenshotUrls: app.screenshotUrls,
                                                                 ipadScreenshotUrls: app.ipadScreenshotUrls,
                                                                 appletvScreenshotUrls: app.appletvScreenshotUrls,
                                                                 description: app.description)
        self.viewController?.displaySearchedApp(viewModel: viewModel)
    }
}
