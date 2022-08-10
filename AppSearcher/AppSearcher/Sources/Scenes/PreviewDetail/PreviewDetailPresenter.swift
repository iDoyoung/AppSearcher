//
//  PreviewDetailPresenter.swift
//  AppSearcher
//
//  Created by Doyoung on 2022/08/10.
//

import Foundation

protocol PreviewDetailPresentationLogic {
    func presentPreviewImages(with urls: [String])
}

final class PreviewDetailPresenter: PreviewDetailPresentationLogic {
    weak var viewController: PreviewDetailDisplayLogicProtocol?
    
    func presentPreviewImages(with urls: [String]) {
        viewController?.displayPreviews(with: urls)
    }
}
