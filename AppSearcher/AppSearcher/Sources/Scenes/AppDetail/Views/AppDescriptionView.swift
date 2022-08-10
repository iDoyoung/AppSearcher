//
//  AppDescriptionView.swift
//  AppSearcher
//
//  Created by Doyoung on 2022/08/08.
//

import UIKit

final class AppDescriptionView: UIView {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "앱 설명"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var foldingDescriptionButton: UIButton = {
        let button = UIButton()
        button.tintColor = .systemOrange
        button.setTitle("펼치기", for: .normal)
        button.setImage(UIImage(systemName: "arrowtriangle.down.fill"), for: .normal)
        button.setTitle("접기", for: .selected)
        button.setTitleColor(UIColor.systemOrange, for: .normal)
        button.setImage(UIImage(systemName: "arrowtriangle.up.fill"), for: .selected)
        button.setTitleColor(UIColor.systemOrange, for: .selected)
        button.addTarget(self, action: #selector(foldingDescription), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc
    func foldingDescription(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        descriptionLabel.numberOfLines = sender.isSelected ? 0 : 3
    }
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
        addSubview(descriptionLabel)
        addSubview(foldingDescriptionButton)
        setupLayoutConstraint()
    }
    private func setupLayoutConstraint() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            foldingDescriptionButton.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            foldingDescriptionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            descriptionLabel.topAnchor.constraint(equalTo: foldingDescriptionButton.bottomAnchor, constant: 8),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
}
