//
//  PreviewDetailInteractor.swift
//  AppSearcher
//
//  Created by Doyoung on 2022/08/10.
//

import Foundation

protocol PreviewDetailBussinessLogic {
    func getPreviewURLs()
}

protocol PreviewDetailDataStore {
    var previewURLs: [String] { get set }
}

final class PreviewDetailInteractor: PreviewDetailBussinessLogic, PreviewDetailDataStore {
    var previewURLs = [String]()
    var presenter: PreviewDetailPresentationLogic?
    
    func getPreviewURLs() {
        presenter?.presentPreviewImages(with: previewURLs)
    }
}
