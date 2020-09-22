//
//  StepCollectionViewCell.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 03/08/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit

public protocol StepCollectionViewCell: UICollectionViewCell {
    func setup(section: FormSection, navigation: UINavigationController?)
    func dismissForm()
    static var identifier: String { get }
    var sectionValidationHandler: ((FormSection) -> Void)? { get set }
}

extension StepCollectionViewCell {
    public var sectionValidationHandler: ((FormSection) -> Void)? {
        get {
            return nil
        }
        set {
            
        }
    }
}

public class FormStepCollectionViewCell: UICollectionViewCell, StepCollectionViewCell {
    
    public static var identifier: String = "StepCollectionViewCellIdentifier"
    
    public var sectionValidationHandler: ((FormSection) -> Void)?
    var navigationController: UINavigationController?
    var stepCollectionViewCellContentController: SectionController?

    public func setup(section: FormSection, navigation: UINavigationController?) {
        navigationController = navigation
        
        let isUpload = !section.masks.filter({ $0.fieldType == .upload }).isEmpty
        
        if isUpload {
            stepCollectionViewCellContentController = StepFormCollectionViewCellUploadContentController(section: section)
        } else {
          stepCollectionViewCellContentController = StepFormCollectionViewCellContentController(section: section)
        }
        
        guard let contentController = stepCollectionViewCellContentController else { return }
        contentController.delegate = self
        contentView.add(view: contentController.view)
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        stepCollectionViewCellContentController?.view.removeFromSuperview()
    }
    
    public func dismissForm() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
}
