//
//  SearchedAppWorker.swift
//  AppSearcher
//
//  Created by Doyoung on 2022/08/06.
//

import Foundation

class SearchedAppWorker {
    typealias CompletionHandler = (Result<[SearchedApp], NetworkError>) -> Void
    
    var networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchSearchedApps(with id: String, completion: @escaping CompletionHandler) {
        networkService.request(with: APIEndpoints.getSearchedApp(with: id), completion: completion)
    }
}
