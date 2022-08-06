//
//  FetchSearchedApps.swift
//  AppSearcher
//
//  Created by Doyoung on 2022/08/06.
//

import Foundation

enum FetchSearchedApps {
    struct Response: Decodable {
        var results: [SearchedApp]
    }
}
