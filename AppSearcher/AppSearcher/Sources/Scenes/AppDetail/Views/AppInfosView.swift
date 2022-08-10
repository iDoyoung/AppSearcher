//
//  AppInfosView.swift
//  AppSearcher
//
//  Created by Doyoung on 2022/08/09.
//

import UIKit

final class AppInfosView: UIView {
    //MARK: - UI Components
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [userRatingInfoView,
                                                      advisoryRatingInfoView,
                                                      languageInfoView,
                                                      fileSizeInfoView])
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.backgroundColor = .secondarySystemBackground
        stackView.spacing = 1
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private let userRatingInfoView: InfoView = {
        let infoView = InfoView()
        infoView.titleLabel.text = "사용자 평가"
        infoView.subContentLabel.text = "점"
        return infoView
    }()
    private let advisoryRatingInfoView: InfoView = {
        let infoView = InfoView()
        infoView.titleLabel.text = "연령"
        infoView.subContentLabel.text = "세"
        return infoView
    }()
    private let languageInfoView: InfoView = {
        let infoView = InfoView()
        infoView.titleLabel.text = "언어"
        return infoView
    }()
    private let fileSizeInfoView: InfoView = {
        let infoView = InfoView()
        infoView.titleLabel.text = "크기"
        infoView.subContentLabel.text = "MB"
        return infoView
    }()
    
    func configureUI(with viewModel: SearchedApp.ViewModel.DisplayedAppDetail) {
        userRatingInfoView.contentLabel.text = viewModel.averageUserRating
        advisoryRatingInfoView.contentLabel.text = viewModel.contentAdvisoryRating
        languageInfoView.contentLabel.text = viewModel.languageCode
        languageInfoView.subContentLabel.text = viewModel.countOfLanguageCode
        fileSizeInfoView.contentLabel.text = viewModel.fileSizeMagabytes
    }
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUIComponents()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUIComponents()
    }
    //MARK: - Setup
    private func setupUIComponents() {
        addSubview(scrollView)
        scrollView.addSubview(contentStackView)
        setupLayoutConstraint()
    }
    private func setupLayoutConstraint() {
        NSLayoutConstraint.activate([
            scrollView.heightAnchor.constraint(equalToConstant: 94),
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentStackView.heightAnchor.constraint(equalTo: scrollView.frameLayoutGuide.heightAnchor),
            contentStackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor)
        ])
    }
}

private class InfoView: UIView {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let contentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .black)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let subContentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUIComponents()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUIComponents()
    }
    private func setupUIComponents() {
        addSubview(titleLabel)
        addSubview(contentLabel)
        addSubview(subContentLabel)
        backgroundColor = .systemBackground
        setupLayoutConstraint()
    }
    private func setupLayoutConstraint() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            contentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            contentLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            subContentLabel.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 8),
            subContentLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            subContentLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            subContentLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 94),
            subContentLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            subContentLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
