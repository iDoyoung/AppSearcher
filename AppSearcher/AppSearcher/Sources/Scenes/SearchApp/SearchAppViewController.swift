//
//  ViewController.swift
//  AppSearcher
//
//  Created by Doyoung on 2022/08/04.
//

import UIKit

protocol SearchAppDisplayLogic: AnyObject {
    func displaySuccessSearching()
}

class SearchAppViewController: UIViewController {
    var interactor: (SearchAppBussinessLogic&SearchAppDataStore)?
    //MARK: - UI components property
    var searchController = UISearchController()
    
    //MARK: - Life cyle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupVC()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupVC()
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
    //TODO: - DI 구현시 setupVC() 제거
    func setupVC() {
        let networkConfiguration = NetworkConfiguration(baseURL: URL(string: "http://itunes.apple.com/")!)
        let networkService = NetworkService(configuration: networkConfiguration)
        let worker = SearchedAppWorker(networkService: networkService)
        let presenter = SearchAppPresenter(self)
        let interactor = SearchAppInteractor(searchedAppWorker: worker, presenter: presenter)
        self.interactor = interactor
    }
    private func setupUIComponents() {
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
        print("Success Searcing")
    }
}

extension SearchAppViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        interactor?.searchApp(with: searchBar.text!)
    }
}
