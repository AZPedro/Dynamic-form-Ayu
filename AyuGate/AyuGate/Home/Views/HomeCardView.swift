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
    
    var model: HomeCardViewModel? {
        didSet {
            updateUI()
        }
    }
    
    var actionHandler: (()-> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildUI()
    }
    
    private lazy var monthTitle: UILabel = {
        let label = UILabel()
        label.alpha = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = model?.month
        label.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.alpha = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 35, weight: .bold)
        label.textColor = .white
        label.text = "R$ 1.800,00"
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.alpha = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 11, weight: .bold)
        label.textColor = UIColor.whitePlaceholder
        label.text = "Terça, 01/04, 2019"
        return label
    }()
    
    private lazy var iconImageView: UIImageView = {
        let i = UIImageView()
        i.alpha = 0
        i.translatesAutoresizingMaskIntoConstraints = false
        i.heightAnchor.constraint(equalToConstant: 23).isActive = true
        i.widthAnchor.constraint(equalToConstant: 33).isActive = true
        i.image = UIImage(named: "invoiceListIcon")
        return i
    }()
    
    private lazy var invoiceDiscountBar: AYUInvoiceDiscountBar = {
        let v = AYUInvoiceDiscountBar()
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
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapActionHandler)))
    }
    
    @objc private func didTapActionHandler(){
        actionHandler?()
    }
    
    private func animate() {
        UIView.animate(withDuration: 1.0, animations: {
            self.monthTitle.alpha = 1
            self.priceLabel.alpha = 1
            self.dateLabel.alpha = 1
            self.iconImageView.alpha = 1
        }, completion: nil)
    }
    
    func updateUI() {
        guard let model = self.model else { return }
        priceLabel.text = "\(model.price)"
        monthTitle.text = model.month
        animate()
        invoiceDiscountBar.model = InvoiceDiscountBarViewModel(model: model.barModel)
        
//        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
//            self.invoiceDiscountBar.animate()
//        }
    }
}

struct HomeCardViewModel {
    let month: String
    let price: Double
    let date: String
    let barModel: [InvoiceDiscountBarModel]
}

extension HomeCardViewModel {
    init(from invoice: Invoice) {
        self.barModel = invoice.percentage.compactMap({ InvoiceDiscountBarModel(type: $0.type, percentage: $0.percentage )})
        self.price = invoice.payroll.first?.amount ?? 0
        self.date = ""
        self.month = ""
    }
}
