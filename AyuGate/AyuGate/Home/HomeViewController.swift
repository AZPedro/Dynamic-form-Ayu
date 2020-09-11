//
//  HomeViewController.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 21/04/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit
import AyuKit

class HomeViewController: AYUViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        buildUI()
        fetch()
    }
    
    var invoiceModel: Invoice?
    private let profile = SessionManager.shared.getAccount()
    
    private lazy var accountImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 37).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 37).isActive = true
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 37 / 2
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showAccountProfile)))
        return imageView
    }()

    private lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 38, weight: .light)
        label.textColor = .black
        let name = profile?.name ?? ""
        
        if let profileName = profile?.name.components(separatedBy: " ").prefix(2).joined(separator: " ") {
            label.text = "Olá, \(profileName)"
        }
        
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
        
        cardView.actionHandler = { [weak self] in
            let invoiceViewController = InvoiceDetailViewController()
            self?.present(invoiceViewController, animated: true, completion: nil)
        }
        
        self.profile?.avatarURL.parseImage(urlString: profile?.avatarURL , completion: { image in
            DispatchQueue.main.async {
                self.accountImageView.image = image
            }
        })
    }
    
    private func fetch() {
        let request = AYURoute.init(path: .currentPayrol).resquest
        NetworkManager.shared.makeRequest(request: request) { (result: Handler<Invoice>?, validation: Validation?) in
            DispatchQueue.main.async {
                guard let invoice = result?.response else { return }
                self.invoiceModel = invoice
                self.cardView.model = HomeCardViewModel(from: invoice)
            }
        }
    }
    
    @objc private func showAccountProfile() {
        let accountController = AccountViewController()
        self.present(accountController, animated: true, completion: nil)
    }
}
