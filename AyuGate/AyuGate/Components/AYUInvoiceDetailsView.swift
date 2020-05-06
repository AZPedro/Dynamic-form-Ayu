//
//  AYUInvoiceDetailsView.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 04/05/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit

class AYUInvoiceDetailsView: UIView {
    
    var model: AYUInvoiceDetailsViewModel? {
        didSet {
            updateUI()
        }
    }
    
    private lazy var verticalBarIndicator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 20).isActive = true
        view.widthAnchor.constraint(equalToConstant: 4).isActive = true
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        l.textAlignment = .left
        l.textColor = UIColor.blackTerciary
        return l
    }()
    
    private lazy var valueLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        l.textAlignment = .left
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildUI() {
        addSubview(verticalBarIndicator)
        addSubview(titleLabel)
        addSubview(valueLabel)
        
        backgroundColor = .white
        layer.setupShadow(opacity: 0.5)
        layer.cornerRadius = 5
        
        verticalBarIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        verticalBarIndicator.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: verticalBarIndicator.trailingAnchor, constant: 6).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: valueLabel.leadingAnchor, constant: -20).isActive = true
        
        valueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -6).isActive = true
        valueLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    private func updateUI() {
        guard let model = model else { return }
        
        switch model.type {
        case .directDiscount:
            verticalBarIndicator.backgroundColor = UIColor.redSecondary
            valueLabel.textColor = UIColor.redSecondary
            
        case .discount:
            verticalBarIndicator.backgroundColor = UIColor.yellowTerciary
            valueLabel.textColor = UIColor.yellowTerciary
        case .input:
            verticalBarIndicator.backgroundColor = UIColor.greenPrimary
            valueLabel.textColor = UIColor.greenPrimary
        }
        
        titleLabel.text = model.description
        valueLabel.text = model.formattedValue
    }
}

struct AYUInvoiceDetailsViewModel {
    let value: Double
    let type: `Type`
    let description: String
    
    public enum `Type` {
        case input, discount, directDiscount
    }
    
    var formattedValue: String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        let formattedCurrency = formatter.string(from: NSNumber(value: value)) ?? "R$ 0,00"
        if type == .directDiscount {
            return "-\(formattedCurrency)"
        }
        return formattedCurrency
    }
}
