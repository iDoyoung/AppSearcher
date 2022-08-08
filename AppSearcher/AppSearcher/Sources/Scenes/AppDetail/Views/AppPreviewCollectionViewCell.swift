//
//  AppPreviewCollectionViewCell.swift
//  AppSearcher
//
//  Created by Doyoung on 2022/08/08.
//

import UIKit

class AppPreviewCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "AppPreviewCollectionViewCellReuseIdentifier"
    
    let screenShotImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUIComponents()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUIComponents()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        screenShotImageView.image = nil
    }
    private func setupUIComponents() {
        addSubview(screenShotImageView)
        setupLayoutConstraint()
    }
    private func setupLayoutConstraint() {
        NSLayoutConstraint.activate([
            screenShotImageView.widthAnchor.constraint(equalToConstant: 227),
            screenShotImageView.heightAnchor.constraint(equalToConstant: 400),
            screenShotImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            screenShotImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            screenShotImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            screenShotImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}
