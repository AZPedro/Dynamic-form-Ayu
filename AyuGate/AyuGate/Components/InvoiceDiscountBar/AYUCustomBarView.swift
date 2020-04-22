//
//  AYUInvoiceDiscountBar.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 15/04/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit

class AYUInvoiceDiscountBar: UIView {

    private var model: InvoiceDiscountBarViewModel
    
    public init(model: InvoiceDiscountBarViewModel) {
        self.model = model
        super.init(frame: .zero)
        buildUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    struct Constants {
        static let fullHeight: Double = 219
    }
    
    private var inputBarBottomContraint: NSLayoutConstraint?
    
    var inputHeightConstant: CGFloat {
        return CGFloat(Constants.fullHeight * model.inputPercent / 100)
    }
    
    private var netValueBottomConstraint: NSLayoutConstraint?
    
    var netValueHeightConstant: CGFloat {
        return CGFloat(Constants.fullHeight * model.neValuePercent / 100)
    }
    
    private var discountBottomConstraint: NSLayoutConstraint?
    
    var discountHeightConstant: CGFloat {
        return CGFloat(Constants.fullHeight * model.discountPercent / 100)
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

        contentView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        contentView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true

        discountBarView.heightAnchor.constraint(equalToConstant: discountHeightConstant).isActive = true
        discountBarView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        discountBottomConstraint = discountBarView.bottomAnchor.constraint(equalTo: netValueBarView.bottomAnchor)
        discountBottomConstraint?.isActive = true
        discountBarView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        netValueBarView.heightAnchor.constraint(equalToConstant: netValueHeightConstant).isActive = true
        netValueBarView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        netValueBottomConstraint = netValueBarView.bottomAnchor.constraint(equalTo: inputBarView.bottomAnchor)
        netValueBottomConstraint?.isActive = true
        netValueBarView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        inputBarView.heightAnchor.constraint(equalToConstant: inputHeightConstant).isActive = true
        inputBarView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        inputBarBottomContraint = inputBarView.bottomAnchor.constraint(equalTo: contentView.topAnchor)
        inputBarBottomContraint?.isActive = true
        inputBarView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    }
    
    func animate() {
        firstAnimation()
        secondAnimation()
        thirdAnimation()
    }
    
    private func firstAnimation() {
        setNeedsLayout()
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut, animations: {
            self.inputBarBottomContraint?.constant = self.inputHeightConstant
            self.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func secondAnimation() {
        setNeedsLayout()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            UIView.animate(withDuration: 0.7, animations: {
                self.netValueBottomConstraint?.constant = self.netValueHeightConstant
                self.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    private func thirdAnimation() {
        setNeedsLayout()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            UIView.animate(withDuration: 10, animations: {
                self.discountBottomConstraint?.constant = self.discountHeightConstant
                self.layoutIfNeeded()
            }, completion: nil)
        }
    }
}
