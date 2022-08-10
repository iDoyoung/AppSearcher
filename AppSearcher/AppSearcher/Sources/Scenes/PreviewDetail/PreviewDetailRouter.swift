//
//  PreviewDetailRouter.swift
//  AppSearcher
//
//  Created by Doyoung on 2022/08/10.
//

import Foundation

protocol PreviewDetailDataPassing {
    var dataStore: PreviewDetailDataStore? { get }
}

protocol PreviewDetailRoutingLogic {
}

final class PreviewDetailRouter: PreviewDetailDataPassing, PreviewDetailRoutingLogic {
    weak var viewController: PreviewDetailViewController?
    var dataStore: PreviewDetailDataStore?
}
