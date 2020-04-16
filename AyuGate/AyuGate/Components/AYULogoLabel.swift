//
//  AYULogoLabel.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 15/04/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit

class AYULogoLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var size: CGFloat = 30 {
        didSet {
            setup(size)
        }
    }
    
    private func setup(_ size: CGFloat = 30) {
        let boldText = "ayu"
        let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: size)]
        let attributedString = NSMutableAttributedString(string: boldText, attributes:attrs)

        let normalText = "gate"
        let normalAttrs = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: size - 3)]
        let normalString = NSMutableAttributedString(string:normalText, attributes: normalAttrs)

        attributedString.append(normalString)
        
        self.attributedText = attributedString
    }
}
