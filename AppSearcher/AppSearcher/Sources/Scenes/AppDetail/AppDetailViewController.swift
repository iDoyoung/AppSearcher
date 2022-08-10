//
//  AppDetailViewController.swift
//  AppSearcher
//
//  Created by Doyoung on 2022/08/07.
//

import UIKit

protocol AppDetailDisplayLogicProtocol: AnyObject {
    func displaySearchedApp(viewModel: SearchedApp.ViewModel.DisplayedAppDetail)
}

final class AppDetailViewController: UIViewController {
    var interactor: AppDetailBussinessLogic?
    var router: (AppDetailRoutingLogice&AppDetailDataPassing)?
    
    //MARK: - UI compenents property
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    private let scrollContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var appContentsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [appHeaderView, appInfosView, appPreviewCollectionView, appDescriptionView])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private let appHeaderView = AppHeaderView()
    private let appInfosView = AppInfosView()
    private let appDescriptionView = AppDescriptionView()
    let appPreviewCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(AppPreviewCollectionViewCell.self, forCellWithReuseIdentifier: AppPreviewCollectionViewCell.reuseIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
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
        setupUIComponents()
        interactor?.getSearchedApp()
    }
    //MARK: - Setups
    func setupViewController() {
        let interactor = AppDetailInteractor()
        let presenter = AppDetailPresenter()
        let router = AppDetailRouter()
        presenter.viewController = self
        interactor.presenter = presenter
        self.interactor = interactor
        self.router = router
        router.viewController = self
        router.dataStore = interactor
    }
    private func setupUIComponents() {
        view.addSubview(scrollView)
        scrollView.addSubview(scrollContentView)
        scrollContentView.addSubview(appContentsStackView)
        setupLayoutConstraint()
        setupCollectionView()
    }
    private func setupLayoutConstraint() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollContentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            scrollContentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            scrollContentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            scrollContentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            scrollContentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            appPreviewCollectionView.heightAnchor.constraint(equalToConstant: 400),
            appContentsStackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            appContentsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            appContentsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            appContentsStackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor)
        ])
    }
    private func setupCollectionView() {
        appPreviewCollectionView.dataSource = self
        appPreviewCollectionView.delegate = self
    }
    //MARK: - Fetched
    var displayedApp: SearchedApp.ViewModel.DisplayedAppDetail?
}

extension AppDetailViewController: AppDetailDisplayLogicProtocol {
    func displaySearchedApp(viewModel: SearchedApp.ViewModel.DisplayedAppDetail) {
        DispatchQueue.main.async { [weak self] in
            self?.displayedApp = viewModel
            self?.appHeaderView.configureUI(with: viewModel)
            self?.appInfosView.configureUI(with: viewModel)
            self?.appDescriptionView.descriptionLabel.text = viewModel.description
            self?.appPreviewCollectionView.reloadData()
        }
    }
}

extension AppDetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    //Data source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let displayedApp = displayedApp else { return 0 }
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            return displayedApp.screenshotUrls.count
        case .tv:
            return displayedApp.appletvScreenshotUrls.count
        default:
            return displayedApp.ipadScreenshotUrls.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppPreviewCollectionViewCell.reuseIdentifier, for: indexPath) as? AppPreviewCollectionViewCell else {
            fatalError()
        }
        var screenShotURL: String
        if let displayedApp = displayedApp {
            switch UIDevice.current.userInterfaceIdiom {
            case .phone:
                screenShotURL = displayedApp.screenshotUrls[indexPath.item]
            case .tv:
                screenShotURL = displayedApp.appletvScreenshotUrls[indexPath.item]
            default:
                screenShotURL = displayedApp.ipadScreenshotUrls[indexPath.item]
            }
            cell.screenShotImageView.loadImage(url: screenShotURL)
        }
        return cell
    }
    //Flow layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 227, height: 400)
    }
    //Others
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        router?.routeToPreviewDetail()
    }
}

