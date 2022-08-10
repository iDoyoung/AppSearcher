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
    
    func presentSearched(_ response: SearchedApp.Response) {
        let viewModel = SearchedApp.ViewModel.DisplayedAppDetail(appName: response.trackName,
                                                                 appIconURL: response.artworkUrl100,
                                                                 screenshotUrls: response.screenshotUrls,
                                                                 ipadScreenshotUrls: response.ipadScreenshotUrls,
                                                                 appletvScreenshotUrls: response.appletvScreenshotUrls,
                                                                 description: response.description,
                                                                 artistName: response.artistName,
                                                                 averageUserRating: String(format: "%.1f", response.averageUserRating),
                                                                 contentAdvisoryRating: response.contentAdvisoryRating,
                                                                 fileSizeMagabytes: getMegabyteSize(response.fileSizeBytes),
                                                                 languageCode: getCurrentLanguage(response.languageCodesISO2A),
                                                                 countOfLanguageCode: countOfAdditionalLanguage(response.languageCodesISO2A))
        self.viewController?.displaySearchedApp(viewModel: viewModel)
    }
    
    private func getCurrentLanguage(_ languages: [String]) -> String {
        let currentLanguage = Locale.current.languageCode?.uppercased() ?? ""
        return languages.contains(currentLanguage) ? currentLanguage : languages.first ?? ""
    }
    private func countOfAdditionalLanguage(_ languages: [String]) -> String {
        return "+ \(languages.count - 1)개 언어"
    }
    private func getMegabyteSize(_ byte: String) -> String {
        guard let byte = Double(byte) else { return "0" }
        let megabyte = byte / 1000000
        return String(format: "%.1f", megabyte)
    }
}
