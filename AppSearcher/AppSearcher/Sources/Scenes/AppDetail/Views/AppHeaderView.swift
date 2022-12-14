//
//  AppHeaderView.swift
//  AppSearcher
//
//  Created by Doyoung on 2022/08/09.
//

import UIKit

final class AppHeaderView: UIView {
    private let appIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private let appNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let appCategoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func configureUI(with viewModel: SearchedApp.ViewModel.DisplayedAppDetail) {
        appIconImageView.loadImage(url: viewModel.appIconURL)
        appNameLabel.text = viewModel.appName
        artistNameLabel.text = viewModel.artistName
        appCategoryLabel.text = viewModel.category
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
        addSubview(appIconImageView)
        addSubview(appNameLabel)
        addSubview(artistNameLabel)
        addSubview(appCategoryLabel)
        setupLayoutConstraint()
    }
    private func setupLayoutConstraint() {
        NSLayoutConstraint.activate([
            appIconImageView.heightAnchor.constraint(equalToConstant: 118),
            appIconImageView.widthAnchor.constraint(equalToConstant: 118),
            appIconImageView.topAnchor.constraint(equalTo: topAnchor),
            appIconImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            appIconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            appNameLabel.leadingAnchor.constraint(equalTo: appIconImageView.trailingAnchor, constant: 16),
            appNameLabel.topAnchor.constraint(equalTo: topAnchor),
            appNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            artistNameLabel.topAnchor.constraint(equalTo: appNameLabel.bottomAnchor),
            artistNameLabel.leadingAnchor.constraint(equalTo: appIconImageView.trailingAnchor, constant: 16),
            artistNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            appCategoryLabel.topAnchor.constraint(equalTo: artistNameLabel.bottomAnchor),
            appCategoryLabel.leadingAnchor.constraint(equalTo: appIconImageView.trailingAnchor, constant: 16),
            appCategoryLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
}
