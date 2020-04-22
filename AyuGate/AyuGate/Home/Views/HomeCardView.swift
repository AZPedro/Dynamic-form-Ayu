//
//  HomeCardView.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 21/04/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit

class HomeCardView: UIView {
    
    struct Constants {
        static let cardHeight: CGFloat = 235
    }
    
    let model: HomeCardViewModel
    
    init(model: HomeCardViewModel) {
        self.model = model
        super.init(frame: .zero)
        buildUI()
    }
    
    private lazy var monthTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = model.month
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
    private lazy var invoiceDiscountBar: AYUInvoiceDiscountBar = {
        let v = AYUInvoiceDiscountBar(model: InvoiceDiscountBarViewModel(model: model.barModel))
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildUI() {
        clipsToBounds = true
        layer.cornerRadius = 10
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .black
        heightAnchor.constraint(equalToConstant: Constants.cardHeight).isActive = true
        
        addSubview(invoiceDiscountBar)

        addSubview(invoiceDiscountBar)
        invoiceDiscountBar.translatesAutoresizingMaskIntoConstraints = false
        invoiceDiscountBar.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        invoiceDiscountBar.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        invoiceDiscountBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        
        addSubview(monthTitle)
        monthTitle.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        monthTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            self.invoiceDiscountBar.animate()
        }
    }
}

struct HomeCardViewModel {
    let month: String
    let price: Double
    let date: String
    let barModel: InvoiceDiscountBarModel
}
