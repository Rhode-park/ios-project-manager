//
//  ProjectManager - HeaderView.swift
//  Created by Rhode.
//  Copyright © yagom. All rights reserved.
//

import UIKit

final class HeaderView: UICollectionReusableView {
    private lazy var numberLabelWidthAnchor = numberLabel.widthAnchor.constraint(equalToConstant: 24) {
        didSet(currentWidthAnchor) {
            currentWidthAnchor.isActive = false
            numberLabelWidthAnchor.isActive = true
        }
    }
    
    private let contentStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.alignment = .center
        stackview.spacing = 10
        stackview.translatesAutoresizingMaskIntoConstraints = false
        
        return stackview
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        return label
    }()
    
    let numberLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .black
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = .white
        label.textAlignment = .center
        label.layer.cornerRadius = 12
        label.layer.masksToBounds = true
        
        return label
    }()
    
    private let emptyView: UIView = {
        let view = UIView()
        view.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureContentStackView()
        configureConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureContent(status: Status, number: String) {
        statusLabel.text = status.title
        numberLabel.text = number
        
        configureWidthAnchorConstraint(text: number)
    }
    
    private func configureUI() {
        backgroundColor = .systemGray6
    }
    
    private func configureContentStackView() {
        self.addSubview(contentStackView)
        contentStackView.addArrangedSubview(statusLabel)
        contentStackView.addArrangedSubview(numberLabel)
        contentStackView.addArrangedSubview(emptyView)
    }
    
    private func configureConstraint() {
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            contentStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            contentStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            contentStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            numberLabel.heightAnchor.constraint(equalToConstant: 24),
        ])
    }
    
    private func configureWidthAnchorConstraint(text: String) {
        switch text.count {
        case 2:
            numberLabelWidthAnchor = numberLabel.widthAnchor.constraint(equalToConstant: 30)
        case 3:
            numberLabelWidthAnchor = numberLabel.widthAnchor.constraint(equalToConstant: 36)
        default:
            numberLabelWidthAnchor = numberLabel.widthAnchor.constraint(equalToConstant: 24)
        }
    }
}
