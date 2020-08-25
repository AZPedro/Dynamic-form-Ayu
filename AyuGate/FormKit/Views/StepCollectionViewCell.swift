//
//  StepCollectionViewCell.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 03/08/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit

class StepCollectionViewCell: UICollectionViewCell {
    
    static var identifier = "StepCollectionViewCellIdentifier"
    
    var stepCollectionViewCellContentController: StepCollectionViewCellContentController?
    
    func setup(section: FormSection) {
        stepCollectionViewCellContentController = StepCollectionViewCellContentController(section: section)
        guard let contentController = stepCollectionViewCellContentController else { return }
        
        contentView.add(view: contentController.view)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        stepCollectionViewCellContentController?.view.removeFromSuperview()
    }
}
