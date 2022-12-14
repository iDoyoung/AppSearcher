//
//  APIEndpoints.swift
//  AppSearcher
//
//  Created by Doyoung on 2022/08/06.
//

import Foundation

struct APIEndpoints {
    static func getSearchedApp(with id: String) -> Endpoint<FetchSearchedApps.Response> {
        return Endpoint(path: "lookup", queryParameters: ["id": id])
    }
}
