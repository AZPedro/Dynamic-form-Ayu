//
//  HomeViewController.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 21/04/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit

class HomeViewController: AYUViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        buildUI()
    }

    private lazy var cardView: HomeCardView = {
        let cardView = HomeCardView(model: HomeCardViewModel(month: "Abril", price: 1800, date: "Terça, 01/04, 2019", barModel: InvoiceDiscountBarModel(discount: 130, input: 1000, netValue: 870)))
        return cardView
    }()
    
    private func buildUI() {
        view.backgroundColor = .white
        view.addSubview(cardView)
        cardView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 11).isActive = true
        cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -11).isActive = true
    }
}
