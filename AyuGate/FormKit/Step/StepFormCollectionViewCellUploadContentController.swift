//
// StepFormCollectionViewCellUploadContentController.swift
// AyuGate
//
// Created by Pedro Azevedo on 12/08/20.
// Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit
import AyuKit

public class StepFormCollectionViewCellUploadContentController: UIViewController, SectionController {
    public var section: FormSection
    public lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
    
        return imageView
  
    }()
    
    public lazy var uploadImageView: UIImageView = {
        let imageView = UIImageView(image: Images.uploadIcon)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    public init(section: FormSection) {
        self.section = section
        super.init(nibName: nil, bundle: nil)
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
        view.addSubview(uploadImageView)
        
        NSLayoutConstraint.activate([
          imageView.heightAnchor.constraint(equalToConstant: 134),
          imageView.widthAnchor.constraint(equalToConstant: 218),
          imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
          imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
          uploadImageView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 15),
          uploadImageView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
          uploadImageView.heightAnchor.constraint(equalToConstant: 16),
          uploadImageView.widthAnchor.constraint(equalToConstant: 26)
        ])
        
        parseImage(urlString: section.sectionImageURL, completion: nil)
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selecImageAction)))
    }
    
    @objc private func selecImageAction() {
        
    }
}
