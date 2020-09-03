//
//  SectionImageContentView.swift
//  FormKit
//
//  Created by Pedro Azevedo on 03/09/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit

public class SectionImageContentView: UIView {
    
    var image: UIImage?
    var aligment: NSTextAlignment
    var imageBorderSpace: CGFloat
    
    public lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    public init(aligment: NSTextAlignment, image: UIImage?, imageBorderSpace: CGFloat) {
        self.aligment = aligment
        self.image = image
        self.imageBorderSpace = imageBorderSpace
        super.init(frame: .zero)
        builUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func builUI() {
        addSubview(imageView)
        
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        imageView.topAnchor.constraint(equalTo: topAnchor)
        
        switch aligment {
        case .right:
            imageView.rightAnchor.constraint(equalTo: rightAnchor, constant: imageBorderSpace).isActive = true
        default:
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: imageBorderSpace).isActive = true
        }
    }
}
