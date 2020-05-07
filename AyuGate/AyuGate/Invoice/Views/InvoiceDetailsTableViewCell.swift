//
//  InvoiceDetailsTableViewCell.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 06/05/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit

class InvoiceDetailsTableViewCell: UITableViewCell {
    static let identifier = "InvoiceDetailsTableViewCellIdentifier"
    
    lazy var content: AYUInvoiceDetailsView = {
        let view = AYUInvoiceDetailsView()
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
        selectionStyle = .none
        content.translatesAutoresizingMaskIntoConstraints = false
        content.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        content.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        content.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -6).isActive = true
        content.heightAnchor.constraint(equalToConstant: 37).isActive = true
    }
}
