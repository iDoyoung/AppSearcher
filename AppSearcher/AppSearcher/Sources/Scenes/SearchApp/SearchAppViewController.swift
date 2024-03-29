//
//  ViewController.swift
//  AppSearcher
//
//  Created by Doyoung on 2022/08/04.
//

import UIKit

protocol SearchAppDisplayLogic: AnyObject {
    func displaySuccessSearching()
    func displayFailedSearching()
    func displayUnexpectedNetworkError()
}

final class SearchAppViewController: UIViewController {
    var interactor: (SearchAppBussinessLogic&SearchAppDataStore)?
    var router: SearchAppRoutingLogic?
    //MARK: - UI components property
    var searchController = UISearchController()
    
    //MARK: - Life cyle
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
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        setupUIComponents()
    }
    //MARK: - Setups
    func setupViewController() {
        let networkConfiguration = NetworkConfiguration(baseURL: URL(string: "http://itunes.apple.com/")!)
        let networkService = NetworkService(configuration: networkConfiguration)
        let worker = SearchedAppWorker(networkService: networkService)
        let interactor = SearchAppInteractor()
        let presenter = SearchAppPresenter()
        interactor.searchedAppWorker = worker
        interactor.presenter = presenter
        presenter.viewController = self
        let router = SearchAppRouter()
        router.viewController = self
        router.dataStore = interactor
        self.interactor = interactor
        self.router = router
    }
    private func setupUIComponents() {
        navigationController?.navigationBar.tintColor = .systemOrange
        setupSearchController()
        setupLayoutConstraint()
    }
    private func setupLayoutConstraint() {
        NSLayoutConstraint.activate([
        ])
    }
    private func setupSearchController() {
        searchController.searchBar.placeholder = "ex) 872469884 = 아이디어스"
    }
}

extension SearchAppViewController: SearchAppDisplayLogic {
    func displaySuccessSearching() {
        DispatchQueue.main.async { [weak self] in
            self?.router?.routeToAppDetail()
        }
    }
    func displayFailedSearching() {
        DispatchQueue.main.async { [weak self] in
            self?.router?.presentFailedSearchingAlert()
        }
    }
    func displayUnexpectedNetworkError() {
        DispatchQueue.main.async { [weak self] in
            self?.router?.presentUnexpectedNetworkErrorAlert()
        }
    }
}

extension SearchAppViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        Task {
            await interactor?.searchApp(with: searchBar.text!)
        }
    }
}
