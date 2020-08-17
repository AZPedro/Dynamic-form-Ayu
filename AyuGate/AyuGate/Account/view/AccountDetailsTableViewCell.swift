//
//  AccountDetailsTableViewCell.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 11/05/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit

class AccountDetailsTableViewCell: UITableViewCell {
    static let identifier = "AccountDetailsTableViewCellIdentier"
    
    lazy var content: AYUDetailInfoView = {
        let view = AYUDetailInfoView()
        view.verticalBarIndicator.isHidden = true
        view.titleLabel.textColor = .black
        view.valueLabel.textColor = .black
        view.valueLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        view.titleLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildUI() {
        contentView.addSubview(content)
        backgroundColor = .white
        selectionStyle = .none
        content.translatesAutoresizingMaskIntoConstraints = false
        content.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        content.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        content.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -6).isActive = true
        content.heightAnchor.constraint(equalToConstant: 37).isActive = true
    }
}
