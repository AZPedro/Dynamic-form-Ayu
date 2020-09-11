//
//  AyuActivityView.swift
//  AyuKit
//
//  Created by Pedro Azevedo on 04/09/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit

public final class AyuActivityView: UIView {
    
    private var activity = UIActivityIndicatorView()
    public var state: State = .stop {
        didSet {
            update()
        }
    }
    
    public enum State {
        case start
        case stop
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        buildUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildUI() {
        self.backgroundColor = UIColor.white.withAlphaComponent(0.7)
        add(view: activity)
        update()
    }

    private func update() {
        DispatchQueue.main.async {
            switch self.state {
            case .start:
                self.isHidden = false
                self.activity.startAnimating()
            case .stop:
                self.activity.stopAnimating()
                self.isHidden = true
            }
        }
    }
}
