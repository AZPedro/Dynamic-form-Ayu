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
    
    private lazy var stepCollectionViewCellContentController: StepCollectionViewCellContentController = {
        let stepCollectionViewCellContentController = StepCollectionViewCellContentController()
        return stepCollectionViewCellContentController
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildUI() {
        contentView.add(view: stepCollectionViewCellContentController.view)
    }
}
