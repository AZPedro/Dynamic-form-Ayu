//
//  OnboardingStepCollectionViewCellContentController.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 28/08/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit
import FormKit
import AyuKit

public class OnboardingStepCollectionViewCellContentController: AYUActionButtonViewController, BackgroundAnimatedImage {
    
    public var section: FormSection
    public var initialImageFrame: CGRect = .zero
    
    public lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: section.sectionImage)
        imageView.image = section.sectionImage

        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var messageLabel: UILabel = {
        let messageLabel = UILabel().font(.systemFont(ofSize: 20, weight: .bold))
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.textColor = UIColor.white
        messageLabel.text = (section as? OnboardingFormSection)?.messageText ?? ""
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .left
        messageLabel.widthAnchor.constraint(equalToConstant: 263).isActive = true

        return messageLabel
    }()
    
    public init(section: OnboardingFormSection) {
        self.section = section
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        buildUI()
    }
    
    private func buildUI() {
        view.addSubview(imageView)
        view.addSubview(messageLabel)
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            messageLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 100),
            messageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ])
        
        switch section.imagePosition {
        case .right:
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35).isActive = true
        default:
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        }
        let buttonTitle: String = (self.section as? OnboardingFormSection)?.buttonTitle ?? ""
        actionButton.setTitle(buttonTitle, for: .normal)
        actionButton.isHidden = true
        actionButton.status = .enabled
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.animateBackgroundImage()
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.prepare()
    }
}
