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
            updateSection()
            updateUI()
        }
    }
    
    private lazy var provider: UploadProviderProtocol = {
        let provider = UploadProvider(section: section, delegate: self)
        return provider
    }()
    
    private lazy var sectionTitleLabel: UILabel = {
        let l = UILabel()
        l.font(.systemFont(ofSize: 22, weight: .bold))
        l.textColour(UIColor.white)
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = provider.section.sectionTitle
        return l
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
        view.addSubview(sectionTitleLabel)
        view.addSubview(imageView)
        view.addSubview(uploadImageView)
        
        NSLayoutConstraint.activate([
            sectionTitleLabel.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            sectionTitleLabel.bottomAnchor.constraint(equalTo: imageView.topAnchor, constant: -50),
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
        updateUI()
    }
    
    private func updateUI() {
        guard !(section.masks[0].formModel.value?.isEmpty ?? false) else { return }
        applySelectedView()
        uploadImageView.isHidden = selectedImage != nil
    }
    
    private func updateSection() {
        section.masks[0].formModel.value = selectedImage?.toBase64()
        delegate?.sectionValidationHandler?(section)
    }
    
    private func applySelectedView() {
        imageView.alpha = 0.5
        let maskView = UIView()
        maskView.alpha = 1
        maskView.translatesAutoresizingMaskIntoConstraints = false
        maskView.backgroundColor = .clear
        
        let checkMark = UIImageView(image: Images.checkMarck)
        checkMark.translatesAutoresizingMaskIntoConstraints = false
        maskView.addSubview(checkMark)
        
        self.view.addSubview(maskView)
        
        NSLayoutConstraint.activate([
            maskView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            maskView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            maskView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            maskView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            
            checkMark.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            checkMark.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            checkMark.heightAnchor.constraint(equalToConstant: 55),
            checkMark.widthAnchor.constraint(equalToConstant: 55)
        ])
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
