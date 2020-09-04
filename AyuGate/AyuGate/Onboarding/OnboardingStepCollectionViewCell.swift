//
//  OnboardingStepCollectionViewCell.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 28/08/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit
import FormKit

public class OnboardingStepCollectionViewCell: UICollectionViewCell, StepCollectionViewCell {

    public static var identifier: String = "OnboardingStepCollectionViewCellIdentifier"
    
    var onboardingStepCollectionViewCellContentController: OnboardingStepCollectionViewCellContentController?
    var loginFlowController = LoginFlowController()

    public func setup(section: FormSection) {
        if let onboardingSection = section as? OnboardingFormSection {
            onboardingStepCollectionViewCellContentController = OnboardingStepCollectionViewCellContentController(section: onboardingSection)
            guard let contentController = onboardingStepCollectionViewCellContentController else { return }
            
            contentView.add(view: contentController.view)
        } else if let _ = section as? LoginFormSection {
            contentView.add(view: loginFlowController.view)
        }
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        onboardingStepCollectionViewCellContentController?.view.removeFromSuperview()
        loginFlowController.view.removeFromSuperview()
    }
    
}
