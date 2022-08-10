//
//  PreviewDetailViewController.swift
//  AppSearcher
//
//  Created by Doyoung on 2022/08/10.
//

import UIKit

protocol PreviewDetailDisplayLogicProtocol: AnyObject {
    
}

class PreviewDetailViewController: UIViewController {
    var interactor: PreviewDetailBussinessLogic?
    var router: (PreviewDetailRoutingLogic&PreviewDetailDataPassing)?
    //MARK: - Life cycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupViewController()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViewController()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    //MARK: - Setup
    func setupViewController() {
        let interactor = PreviewDetailInteractor()
        let presenter = PreviewDetailPresenter()
        let router = PreviewDetailRouter()
        presenter.viewController = self
        interactor.presenter = presenter
        self.interactor = interactor
        self.router = router
        router.viewController = self
        router.dataStore = interactor
    }
    private func setupUIComponents() {
        setupLayoutConstraint()
    }
    private func setupLayoutConstraint() {
        NSLayoutConstraint.activate([
        ])
    }
}

extension PreviewDetailViewController: PreviewDetailDisplayLogicProtocol {
    
}
