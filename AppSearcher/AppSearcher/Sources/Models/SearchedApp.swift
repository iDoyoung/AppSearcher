//
//  AppStoreApp.swift
//  AppSearcher
//
//  Created by Doyoung on 2022/08/05.
//

import Foundation

enum SearchedApp {
    struct Response: Decodable {
        let artworkUrl60: String
        let artworkUrl512: String
        let artworkUrl100: String
        let artistViewUrl: String
        let screenshotUrls: [String]
        let ipadScreenshotUrls: [String]
        let appletvScreenshotUrls: [String]
        let features: [String]
        let supportedDevices: [String]
        let isGameCenterEnabled: Bool
        let kind: String
        let currency: String
        let trackViewUrl: String
        let trackContentRating: String
        let minimumOsVersion: String
        let trackCensoredName: String
        let languageCodesISO2A: [String]
        let fileSizeBytes: String
        let sellerUrl: String?
        let formattedPrice: String
        let contentAdvisoryRating: String
        let releaseNotes: String
        let description: String
        let sellerName: String
        let genreIds: [String]
        let primaryGenreName: String
        let trackId: Int
        let trackName: String
        let bundleId: String
        let version: String
        let wrapperType: String
        let isVppDeviceBasedLicensingEnabled: Bool
        let releaseDate: String
        let price: Double
        let artistId: Int
        let artistName: String
        let genres: [String]
        let userRatingCount: Int
        let averageUserRating: Double
    }
    struct ViewModel {
        struct DisplayedAppDetail {
            let appName: String
            let appIconURL: String
            let screenshotUrls: [String]
            let ipadScreenshotUrls: [String]
            let appletvScreenshotUrls: [String]
            let description: String
            let artistName: String
            let averageUserRating: String
            let contentAdvisoryRating: String
            let fileSizeMagabytes: String
            let languageCode: String
            let countOfLanguageCode: String
            let category: String
        }
        
    }
}
