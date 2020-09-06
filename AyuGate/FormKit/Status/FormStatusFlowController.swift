//
//  FormStatusFlowController.swift
//  FormKit
//
//  Created by Pedro Azevedo on 05/09/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit

public class FormStatusFLowController: UIViewController {
    
    private let statusController = StatusFormController()
    private let backgroundController = BackgroundStepController(stepDependence: BackgroundDefaultDependence())
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        buildUI()
    }
    
    private func buildUI() {
        installChild(backgroundController)
        installChild(statusController)
    }
}
