//
//  UploadProvider.swift
//  FormKit
//
//  Created by Pedro Azevedo on 04/09/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit

protocol UploadProviderProtocol {
    var section: FormSection { get set }
    var delegate: Delegate { get set }
    var imagePicker: UIImagePickerController { get set }
    func openSelector()
}

extension UploadProviderProtocol {
    
    public typealias Delegate = UIViewController & UIImagePickerControllerDelegate & UINavigationControllerDelegate
    
    func setup() {
        self.imagePicker.delegate = delegate
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = false
    }
}

public class UploadProvider: UploadProviderProtocol {
    
    internal var section: FormSection
    internal var imagePicker = UIImagePickerController()
    internal var delegate: Delegate
    
    init(section: FormSection, delegate: Delegate) {
        self.section = section
        self.delegate = delegate
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc public func openSelector() {
        delegate.present(imagePicker, animated: true, completion: nil)
    }
}
