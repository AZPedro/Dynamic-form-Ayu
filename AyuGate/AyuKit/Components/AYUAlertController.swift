//
//  AYUAlertController.swift
//  AyuKit
//
//  Created by Pedro Azevedo on 19/09/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit

public class AyuAlertController: UIViewController {
    
    let alertContent = AyuAlertContentView()
    public var yesActionHandler: (() -> Void)?
    public var noActionHandler: (() -> Void)?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private var alertBottomConstraint: NSLayoutConstraint?
    
    public func present(from: UIViewController) {
        from.installChild(self)
    }
    
    public func dismiss() {
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
    
    private func setup() {
        view.addSubview(alertContent)
        NSLayoutConstraint.activate([
            alertContent.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            alertContent.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        alertBottomConstraint = alertContent.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 336)
        alertBottomConstraint?.isActive = true
        
        animateBackground()
        
        alertContent.yesButton.actionHandler = { [weak self] in
            self?.yesActionHandler?()
        }
        
        alertContent.noButton.actionHandler = { [weak self] in
            self?.noActionHandler?()
        }
    }
    
    private func animateBackground() {
        view.setNeedsLayout()
        alertContent.iconImage.alpha = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        }) { finished in
            UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut, animations: {
                self.alertBottomConstraint?.constant = 36
                self.view.layoutIfNeeded()
            }, completion: { finished in
                UIView.animate(withDuration: 0.3) {
                    self.alertContent.iconImage.alpha = 1
                }
            })
        }
    }
}

class AyuAlertContentView: UIView {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 21, weight: .bold)
        label.textColor = UIColor.yellowPrimary
        label.text = "Está certo disso ?"
        return label
    }()
    
    lazy var iconImage: UIImageView = {
        let imageView = UIImageView().set(width: 48, height: 56)
        imageView.image = UIImage(named: "moneyIcon")
        return imageView
    }()
    
    private lazy var messageContentStack: UIStackView = {
        let stack = UIStackView().horizontal(5)
        stack.alignment = .top
        stack.add([
            messageLabel,
            iconImage
        ])
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var messageLabel: UILabel = {
       let messageLabel = UILabel()
        messageLabel.text = "Você sabia que quando você se torna um MEI, você está isento de recolhimento dos impostos aplicados no modelo RPA(INSS, ISS, e IRRF). Você está certo que não quer ser MEI ?"
        messageLabel.textColor = .white
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        messageLabel.numberOfLines = 0
        return messageLabel
    }()
    
    lazy var yesButton: AYUActionButton = {
        let button = AYUActionButton()
        button.setTitle("Sim", for: .normal)
        button.status = .enabled
        return button
    }()
    
    lazy var noButton: AYUActionButton = {
        let button = AYUActionButton()
        button.backgroundColor = .white
        button.setTitleColor(UIColor.formBackgroundColor, for: .normal)
        button.setTitle("Não", for: .normal)
        button.status = .enabled
        return button
    }()
    
    private lazy var actionButtonStacks: UIStackView = {
        let stack = UIStackView().horizontal(20)
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.add([
            noButton,
            yesButton
        ])
        return stack
    }()
    
    private lazy var stackContent: UIStackView = {
        let stack = UIStackView().vertical(40)
        
        stack.add([
            messageContentStack,
            actionButtonStacks
        ])
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildUI()
    }
    
    private func buildUI() {
        addSubview(titleLabel)
        addSubview(stackContent)
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 26
        clipsToBounds = true
        backgroundColor = UIColor.formBackgroundColor
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            stackContent.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21),
            stackContent.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -21),
            stackContent.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 25),
            stackContent.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -56)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
