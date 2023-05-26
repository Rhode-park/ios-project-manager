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
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        
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
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureView()
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
    
    private func configureView() {
        self.addSubview(statusLabel)
        self.addSubview(numberLabel)
    }
    
    private func configureConstraint() {
        NSLayoutConstraint.activate([
            statusLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            statusLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            numberLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            numberLabel.leadingAnchor.constraint(equalTo: statusLabel.trailingAnchor, constant: 8),
            numberLabel.heightAnchor.constraint(equalToConstant: 24)
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
