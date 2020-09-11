//
//  FormStatusTitleMessageView.swift
//  FormKit
//
//  Created by Pedro Azevedo on 05/09/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit
import AyuKit

class FormStatusTitleMessageView: UIView {
    
    struct Model {
        let size: CGSize
        let status: Status
        let title: String
        let message: String
    }
    
    enum Status {
        case header(String?)
        case valid
        case invalid
        case validating
    }
    
    let model: Model
    
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView().horizontal(17)
    
        stack.alignment = .leading
        stack.distribution = .fillProportionally
    
        stack.add([
            imageLineStack,
//            UIView(),
            labelStack
        ])
        
        return stack
    }()
    
    private lazy var imageLineStack: UIStackView = {
        let stack = UIStackView().vertical(0)
    
        stack.alignment = .center
        
        switch model.status {
        case .header:
            stack.add([
                userImageContenView,
                lineView
            ])
        
        default:
            stack.add([
                imageview,
                lineView
            ])
        }
        
        return stack
    }()
    
    private lazy var labelStack: UIStackView = {
        let stack = UIStackView().vertical(10)

        stack.add([
            title,
            message
        ])
        return stack
    }()
    
    private lazy var imageview: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.heightAnchor.constraint(equalToConstant: model.size.height).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: model.size.width).isActive = true
        
        imageView.layer.cornerRadius = model.size.height / 2
        return imageView
    }()
    
    private lazy var userImageContenView: UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor.successGreen
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageview)
        view.clipsToBounds = true
        
        view.heightAnchor.constraint(equalToConstant: model.size.height + 5).isActive = true
        view.widthAnchor.constraint(equalToConstant: model.size.width + 5).isActive = true
        view.layer.cornerRadius = (model.size.width + 5) / 2
        
        imageview.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageview.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        return view
    }()
    
    private lazy var title: UILabel = {
        let l = UILabel()
        l.numberOfLines = 2
        l.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        l.textColor = .white
        return l
    }()
    
    private lazy var message: UILabel = {
        let l = UILabel()
        l.numberOfLines = 3
        l.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        l.textColor = .whiteDescription
        return l
    }()
    
    private var lineHeightContraint: NSLayoutConstraint?
    
    private lazy var lineView: UIView = {
        let v = UIView()
        v.backgroundColor = .successGreen
        v.translatesAutoresizingMaskIntoConstraints = false
        lineHeightContraint = v.heightAnchor.constraint(equalToConstant: 0)
        lineHeightContraint?.isActive = true
        v.widthAnchor.constraint(equalToConstant: 4).isActive = true
        return v
    }()
    
    public init(model: Model) {
        self.model = model
        super.init(frame: .zero)
        buildUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildUI() {
        add(view: mainStack)
        
        switch model.status {
        case .header(let imageURL):
            
            imageURL?.parseImage(urlString: imageURL, completion: { image in
                DispatchQueue.main.async {
                    self.imageview.image = image
                }
            })
            
            lineHeightContraint?.constant = 70
        case .invalid:
            imageview.image = Images.warningIcon
            lineHeightContraint?.constant = 40
            mainStack.setCustomSpacing(0, after: imageLineStack)
            mainStack.isLayoutMarginsRelativeArrangement = true
            mainStack.layoutMargins(.init(top: 0, left: 6, bottom: 0, right: 0))
        case .valid:
            imageview.image = Images.formStatusCheck
            lineHeightContraint?.constant = 40
            mainStack.setCustomSpacing(0, after: imageLineStack)
            mainStack.isLayoutMarginsRelativeArrangement = true
            // gambiarra pra arrumar layout
            mainStack.insertArrangedSubview(UIView(), at: 1)
            mainStack.layoutMargins(.init(top: 0, left: 12, bottom: 0, right: 0))
        case .validating:
            imageview.image = Images.validatingIcon
            lineHeightContraint?.constant = 25
            lineView.backgroundColor = UIColor.grayTerciary
            // gambiarra pra arrumar layout
            mainStack.insertArrangedSubview(UIView(), at: 1)
            mainStack.setCustomSpacing(0, after: imageLineStack)
            mainStack.isLayoutMarginsRelativeArrangement = true
            mainStack.layoutMargins(.init(top: 0, left: 12, bottom: 0, right: 0))
        }
        
        title.text = model.title
        message.text = model.message
    }
}
