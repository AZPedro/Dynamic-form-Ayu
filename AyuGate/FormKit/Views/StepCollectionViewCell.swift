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
    
    func setup(maskField: MaskField) {
        let stepCollectionViewCellContentController = StepCollectionViewCellContentController(maskField: maskField)
        contentView.add(view: stepCollectionViewCellContentController.view)
    }
}
