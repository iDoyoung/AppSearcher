//
//  PreviewDetailViewController.swift
//  AppSearcher
//
//  Created by Doyoung on 2022/08/10.
//

import UIKit

protocol PreviewDetailDisplayLogicProtocol: AnyObject {
    func displayPreviews(with urls: [String])
}

class PreviewDetailViewController: UIViewController {
    var interactor: PreviewDetailBussinessLogic?
    var router: (PreviewDetailRoutingLogic&PreviewDetailDataPassing)?
    
    //MARK: - UI Components
    private let previewColletionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(AppPreviewCollectionViewCell.self, forCellWithReuseIdentifier: AppPreviewCollectionViewCell.reuseIdentifier)
        collectionView.showsHorizontalScrollIndicator = false
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
        interactor?.getPreviewURLs()
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
        setupNavigationBar()
        view.addSubview(previewColletionView)
        setupLayoutConstraint()
        setupCollectionView()
    }
    private func setupLayoutConstraint() {
        NSLayoutConstraint.activate([
            previewColletionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            previewColletionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            previewColletionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            previewColletionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    private func setupCollectionView() {
        previewColletionView.dataSource = self
        previewColletionView.delegate = self
    }
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(dismissViewController))
    }
    //MARK: - Actions
    @objc
    func dismissViewController() {
        dismiss(animated: true)
    }
    //MARK: - Fetcehd
    var previewURLs = [String]()
}

extension PreviewDetailViewController: PreviewDetailDisplayLogicProtocol {
    func displayPreviews(with urls: [String]) {
        previewURLs = urls
        previewColletionView.reloadData()
    }
}

extension PreviewDetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        previewURLs.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppPreviewCollectionViewCell.reuseIdentifier, for: indexPath) as? AppPreviewCollectionViewCell else {
            fatalError()
        }
        cell.screenShotImageView.loadImage(url: previewURLs[indexPath.item])
        return cell
    }
    //Flow layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - 40
        let height = collectionView.bounds.height
        return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
