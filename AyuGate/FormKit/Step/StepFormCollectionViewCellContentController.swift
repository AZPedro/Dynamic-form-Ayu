//
//  StepCollectionViewCellContentController.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 12/08/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit
import AyuKit

protocol SectionController: UIViewController {
    var imageView: UIImageView { get set }
    func parseImage(urlString: String?, completion: ((UIImage?) -> ())?)
}

extension SectionController {
    func parseImage(urlString: String?, completion: ((UIImage?) -> ())?) {
        let urlSession = URLSession.shared
        guard let urlString = urlString, let url = URL(string: urlString) else { return }
        
        urlSession.dataTask(with: url) { (data, response, error) in
            guard let data = data, let image = UIImage(data: data) else {
                completion?(nil)
                return
            }
            
            DispatchQueue.main.async {
                self.imageView.image = image
            }
            
            completion?(image)
        }.resume()
    }
}

public class StepFormCollectionViewCellContentController: AYUActionButtonViewController, AYUActionButtonViewControllerDelegate, SectionController {
    
    public var section: FormSection
    
    public var controllerUpConstant: CGFloat? = 100
    
    private lazy var scrollContentView: UIScrollView = {
        let scrollContentView = UIScrollView()
        scrollContentView.translatesAutoresizingMaskIntoConstraints = false
        return scrollContentView
    }()
    
    public var initialImageFrame: CGRect = .zero
    
    public lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var mainStackContent: UIStackView = {
        let stackView = UIStackView().vertical(50)
        switch section.imagePosition {
        
        case .trailing:
            stackView.alignment = .trailing
        default:
            stackView.alignment = .leading
        }
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var stackFieldsContent: UIStackView = {
        let stackView = UIStackView().vertical(20)
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    public init(section: FormSection) {
        self.section = section
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        buildUI()
    }
    
    private func buildUI() {
        view.addSubview(scrollContentView)

        scrollContentView.addSubview(mainStackContent)
        
        mainStackContent.add([
            imageView,
            stackFieldsContent
        ])
    
        NSLayoutConstraint.activate([
            scrollContentView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollContentView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),
            scrollContentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollContentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
       
            mainStackContent.topAnchor.constraint(equalTo: scrollContentView.topAnchor, constant: 50),
            mainStackContent.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainStackContent.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width-44),
            mainStackContent.bottomAnchor.constraint(lessThanOrEqualTo: scrollContentView.bottomAnchor, constant: -30)
        ])
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
        actionButton.isHidden = true
        actionButtonViewControllerDelegate = self
        
        setupFields()
        
        parseImage(urlString: section.sectionImageURL, completion: nil)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func setupFields() {
        var fields = section.masks.compactMap { mask -> FormFieldContent? in
            let formField = FormFieldContent(maskField: mask)
            formField.model = mask.formModel
            return formField
        }
        
        if fields.count > 1 {
            fields = fields.map({
                $0.setCustonTitleSpace(10)
            })
        }
        
        stackFieldsContent.add(fields)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.section.layout?.shouldShowNextStepButton = true
            self.section.layout?.delegate?.updateLayout(for: self.section.layout!)
        }
    }
    
    public override func keyboardWillHide(notification: Notification) {
        super.keyboardWillHide(notification: notification)
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollContentView.contentSize.height -= keyboardSize.height / 2
        }
    }
    
    public override func keyboardWillShow(notification: Notification) {
        super.keyboardWillShow(notification: notification)
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollContentView.contentSize.height += keyboardSize.height / 2
        }
    }
}
