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
        label.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 35, weight: .bold)
        label.textColor = .white
        label.text = "R$ 1.800,00"
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 11, weight: .bold)
        label.textColor = UIColor.white.withAlphaComponent(0.38)
        label.text = "Terça, 01/04, 2019"
        return label
    }()
    
    private lazy var iconImageView: UIImageView = {
        let i = UIImageView()
        i.translatesAutoresizingMaskIntoConstraints = false
        i.heightAnchor.constraint(equalToConstant: 23).isActive = true
        i.widthAnchor.constraint(equalToConstant: 33).isActive = true
        i.image = UIImage(named: "invoiceListIcon")
        return i
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
        
        addSubview(priceLabel)
        priceLabel.leadingAnchor.constraint(equalTo: monthTitle.leadingAnchor).isActive = true
        priceLabel.topAnchor.constraint(equalTo: monthTitle.bottomAnchor, constant: 6).isActive = true
        
        addSubview(dateLabel)
        dateLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: priceLabel.leadingAnchor).isActive = true
        
        addSubview(iconImageView)
        iconImageView.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -10).isActive = true
        iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10).isActive = true
        
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
