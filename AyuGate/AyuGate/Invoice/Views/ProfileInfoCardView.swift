//
//  ProfileInfoCardView.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 06/05/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit

class ProfileInfoCardView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var model: ProfileInfoCardViewModel? {
        didSet {
            updateUI()
        }
    }
    
    private lazy var imageview: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "MockedIconProfile")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.heightAnchor.constraint(equalToConstant: Constants.imageViewHeight).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: Constants.imageViewHeight).isActive = true
        
        imageView.layer.cornerRadius = Constants.imageViewHeight / 2
        return imageView
    }()
    
    struct Constants {
        static let viewHeight = InvoiceDetailViewController.Constants.headerHeight / 2.5
        static let imageContentHeight = Constants.viewHeight / 2
        static let imageBorderWidth: CGFloat = 8
        static let imageViewHeight = (Constants.viewHeight / 2) - Constants.imageBorderWidth
    }
    
    private lazy var userImageContenView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageview)
        view.clipsToBounds = true
        view.layer.cornerRadius = Constants.imageContentHeight / 2
        
        imageview.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageview.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        return view
    }()
    
    lazy var profileNameLabel: UILabel = {
        let label =  UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black

        return label
    }()
    
    lazy var officeLabel: UILabel = {
        let label =  UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.grayPrimary

        return label
    }()
    
    lazy var cpfLabel: UILabel = {
        let label =  UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black

        return label
    }()
    
    private func buildUI() {
        backgroundColor = .clear
        backgroundColor = .white
        layer.cornerRadius = 10
        layer.setupShadow()
        
        addSubview(userImageContenView)
        addSubview(profileNameLabel)
        addSubview(cpfLabel)
        addSubview(officeLabel)
        
        userImageContenView.centerYAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        userImageContenView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 15).isActive = true
        userImageContenView.heightAnchor.constraint(equalToConstant: Constants.viewHeight / 2).isActive = true
        userImageContenView.widthAnchor.constraint(equalToConstant: Constants.viewHeight / 2).isActive = true
        
        profileNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        profileNameLabel.bottomAnchor.constraint(equalTo: officeLabel.topAnchor, constant: -5).isActive = true
        
        officeLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        officeLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        cpfLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        cpfLabel.topAnchor.constraint(equalTo: officeLabel.bottomAnchor, constant: 9).isActive = true
    }
    
    private func updateUI() {
        guard let model = self.model else { return }
        imageview.image = model.profileImage
    }
}

struct ProfileInfoCardViewModel {
    let profileImage: UIImage
    let userName: String
    let office: String
    let cpf: String
}
