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
        fetch()
    }
    
    private let profile = SessionManager.shared.getAccount()
    
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
        let name = profile?.name ?? ""
        label.text = "Olá, \(name)"
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
        let cardView = HomeCardView()
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
    
    private func fetch() {
        let request = AYURoute.init(path: .payRoll).resquest
        NetworkManager.shared.makeRequest(request: request) { (result: Handler<Invoice>?, validation) in
            DispatchQueue.main.async {
                guard let invoice = result?.response else { return }
                self.cardView.model = HomeCardViewModel(from: invoice)
            }
        }
    }
}
