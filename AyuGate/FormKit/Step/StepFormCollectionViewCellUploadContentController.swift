//
// StepFormCollectionViewCellUploadContentController.swift
// AyuGate
//
// Created by Pedro Azevedo on 12/08/20.
// Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit
import AyuKit

public class StepFormCollectionViewCellUploadContentController: UIViewController, SectionController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    public var section: FormSection
    var delegate: StepCollectionViewCell?
    
    private var selectedImage: UIImage? = nil {
        didSet {
            updateUI()
        }
    }
    
    private lazy var provider: UploadProviderProtocol = {
        let provider = UploadProvider(section: section, delegate: self)
        return provider
    }()
    
    public lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: section.sectionImage)
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
    
    init(section: FormSection) {
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

        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selecImageAction)))
    }
    
    private func updateUI() {
        applySelectedView()
        uploadImageView.isHidden = selectedImage != nil
    }
    
    private func applySelectedView() {
        imageView.alpha = 0.5
        let view = UIView(frame: imageView.frame)
        view.alpha = 1
        view.backgroundColor = .clear
        
        let checkMark = UIImageView(image: Images.checkMarck)
        checkMark.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(checkMark)
        
        NSLayoutConstraint.activate([
            checkMark.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            checkMark.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            checkMark.heightAnchor.constraint(equalToConstant: 55),
            checkMark.widthAnchor.constraint(equalToConstant: 55)
        ])
        
        self.view.addSubview(view)
    }
    
    @objc private func selecImageAction() {
        self.provider.openSelector()
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        selectedImage = image
    }
}
