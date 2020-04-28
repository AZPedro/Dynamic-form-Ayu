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
    
    private lazy var accountImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "MockedIconProfile")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 37).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 37).isActive = true
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 37 / 2
        return imageView
    }()

    private lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 38, weight: .light)
        label.textColor = .black
        label.text = "Olá, Vanessa!"
        return label
    }()
    
    private lazy var footerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.textColor = .black
        label.text = "All you need is us!"
        return label
    }()
    
    private lazy var cardView: HomeCardView = {
        let cardView = HomeCardView(model: HomeCardViewModel(month: "Abril", price: 1800, date: "Terça, 01/04, 2019", barModel: InvoiceDiscountBarModel(discount: 130, input: 1000, netValue: 870)))
        return cardView
    }()
    
    private func buildUI() {
        view.backgroundColor = .white
        view.addSubview(cardView)
        view.addSubview(welcomeLabel)
        view.addSubview(footerLabel)
        view.addSubview(accountImageView)
        
        accountImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        accountImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        
        cardView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 11).isActive = true
        cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -11).isActive = true
        
        welcomeLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor).isActive = true
        welcomeLabel.bottomAnchor.constraint(equalTo: cardView.topAnchor, constant: -15).isActive = true
        
        footerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        footerLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -6).isActive = true
    }
}
