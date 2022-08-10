//
//  PreviewDetailInteractor.swift
//  AppSearcher
//
//  Created by Doyoung on 2022/08/10.
//

import Foundation

protocol PreviewDetailBussinessLogic {
    
}

protocol PreviewDetailDataStore {
    var previewURL: [String] { get set }
}

final class PreviewDetailInteractor: PreviewDetailBussinessLogic, PreviewDetailDataStore {
    var previewURL = [String]()
    var presenter: PreviewDetailPresentationLogic?
}
