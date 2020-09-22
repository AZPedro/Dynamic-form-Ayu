//
//  FormStatusFlowController.swift
//  FormKit
//
//  Created by Pedro Azevedo on 05/09/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit

public class FormStatusFLowController: UIViewController {
    
    public var imageURL: String?
    
    private lazy var statusController: StatusFormController = {
        let statusFormController = StatusFormController(imageURL: imageURL)
        return statusFormController
    }()
    
    public var actionButtonHandler: ((UIViewController) -> ())?
    
    private let backgroundController = BackgroundStepController(stepDependence: BackgroundDefaultDependence())
    
    public init(imageURL: String?){
        self.imageURL = imageURL
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
        installChild(backgroundController)
        installChild(statusController)
        
        statusController.actionButtonHandler = { [weak self] in
            guard let strongSelf = self else { return }
            self?.actionButtonHandler?(strongSelf)
        }
    }
}
