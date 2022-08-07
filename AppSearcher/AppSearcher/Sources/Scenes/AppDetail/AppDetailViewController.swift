//
//  AppDetailViewController.swift
//  AppSearcher
//
//  Created by Doyoung on 2022/08/07.
//

import UIKit

protocol AppDetailDisplayLogicProtocol: AnyObject {
    func displaySearchedApp()
}

final class AppDetailViewController: UIViewController {
    var interactor: AppDetailInteractor?
    //MARK: - Life cycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupViewController()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViewController()
    }
    override func loadView() {
        super.loadView()
        view.backgroundColor = .systemBackground
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //MARK: - Setups
    func setupViewController() {
        let interactor = AppDetailInteractor()
        let presenter = AppDetailPresenter()
        presenter.viewController = self
        interactor.presenter = presenter
        self.interactor = interactor
    }
    private func setupUIComponents() {
        setupLayoutConstraint()
    }
    private func setupLayoutConstraint() {
        NSLayoutConstraint.activate([
        ])
    }
}

extension AppDetailViewController: AppDetailDisplayLogicProtocol {
    func displaySearchedApp() {
        DispatchQueue.main.async {
        }
    }
}
