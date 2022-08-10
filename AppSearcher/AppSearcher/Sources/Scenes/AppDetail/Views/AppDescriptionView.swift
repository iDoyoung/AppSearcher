//
//  AppDescriptionView.swift
//  AppSearcher
//
//  Created by Doyoung on 2022/08/08.
//

import UIKit

final class AppDescriptionView: UIView {
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var foldingDescriptionButton: UIButton = {
        let button = UIButton()
        button.setTitle("펼치기", for: .normal)
        button.setImage(UIImage(systemName: "arrowtriangle.down.fill"), for: .normal)
        button.setTitle("접기", for: .selected)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.setImage(UIImage(systemName: "arrowtriangle.up.fill"), for: .selected)
        button.setTitleColor(UIColor.systemBlue, for: .selected)
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
        addSubview(descriptionLabel)
        addSubview(foldingDescriptionButton)
        setupLayoutConstraint()
    }
    private func setupLayoutConstraint() {
        NSLayoutConstraint.activate([
            foldingDescriptionButton.topAnchor.constraint(equalTo: topAnchor),
            foldingDescriptionButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: foldingDescriptionButton.bottomAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
