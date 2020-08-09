//
//  AYUInvoiceDiscountBar.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 15/04/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit

class AYUInvoiceDiscountBar: UIView {

    var model: InvoiceDiscountBarViewModel? {
        didSet {
            animate()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    struct Constants {
        static let fullHeight: Double = 219
    }
    
    private var inputBarHeightContraint: NSLayoutConstraint?
    
    var inputHeightConstant: CGFloat {
        guard let model = model else { return 0 }
        return CGFloat(Constants.fullHeight * model.liquidPercent + 4)
    }
    
    private var netValueBottomConstraint: NSLayoutConstraint?
    
    var netValueHeightConstant: CGFloat {
           guard let model = model else { return 0 }
        return CGFloat(Constants.fullHeight * model.discountPercent + 4)
    }
    
    private var discountBottomConstraint: NSLayoutConstraint?
    
    var discountHeightConstant: CGFloat {
        guard let model = model else { return 0 }
        return CGFloat(Constants.fullHeight * model.fixedDiscountPercent + 4)
    }
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: CGFloat(Constants.fullHeight)).isActive = true
        view.widthAnchor.constraint(equalToConstant: 7).isActive = true
        view.layer.cornerRadius = 3
        view.clipsToBounds = true
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var inputBarView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 7).isActive = true

        view.layer.cornerRadius = 3
        view.clipsToBounds = true
        view.backgroundColor = .greenPrimary
        return view
    }()
    
    private lazy var netValueBarView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 7).isActive = true

        view.layer.cornerRadius = 3
        view.clipsToBounds = true
        view.backgroundColor = .yellowTerciary
        return view
    }()
    
    private lazy var discountBarView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 7).isActive = true

        view.layer.cornerRadius = 3
        view.clipsToBounds = true
        view.backgroundColor = .redSecondary
        return view
    }()
    
    private func buildUI() {
        addSubview(contentView)
        contentView.addSubview(discountBarView)
        contentView.addSubview(netValueBarView)
        contentView.addSubview(inputBarView)
        contentView.isHidden = true
        contentView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        contentView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true

        inputBarView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -4).isActive = true
        inputBarView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        inputBarHeightContraint = inputBarView.heightAnchor.constraint(equalToConstant: inputHeightConstant)
        inputBarHeightContraint?.isActive = true
        
        netValueBarView.topAnchor.constraint(equalTo: inputBarView.bottomAnchor, constant: -4).isActive = true
        netValueBarView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        netValueBottomConstraint = netValueBarView.heightAnchor.constraint(equalToConstant: netValueHeightConstant)
        netValueBottomConstraint?.isActive = true
        
        discountBarView.topAnchor.constraint(equalTo: netValueBarView.bottomAnchor, constant: -4).isActive = true
        discountBarView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        discountBottomConstraint = discountBarView.heightAnchor.constraint(equalToConstant: discountHeightConstant)
        discountBottomConstraint?.isActive = true
    }
        
    func animate() {
        inputBarHeightContraint?.constant = inputHeightConstant
        netValueBottomConstraint?.constant = netValueHeightConstant
        discountBottomConstraint?.constant = discountHeightConstant
        
        contentView.alpha = 0
        UIView.animate(withDuration: 0.5) {
            self.contentView.isHidden = false
            self.contentView.alpha = 1
        }
    }
}
