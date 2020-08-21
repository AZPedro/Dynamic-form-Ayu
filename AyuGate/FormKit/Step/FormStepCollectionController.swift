//
//  FormStepCollectionController.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 09/08/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit

class FormStepCollectionController: UIViewController, StepProtocolDelegate {
    
    internal var stepDependence: StepProtocol
    var items: [IndexPath] = []

    private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
    private static var collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = UIScreen.main.bounds.size
        flowLayout.scrollDirection = .horizontal
        return flowLayout
    }()
    
    weak var delegate: BackgroundStepViewProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildUI()
    }
    
    init(stepDependence: StepProtocol) {
        self.stepDependence = stepDependence
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func prepareCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = true
        collectionView.isPagingEnabled = true
        collectionView.isScrollEnabled = false
        collectionView.isUserInteractionEnabled = true
        collectionView.register(StepCollectionViewCell.self, forCellWithReuseIdentifier: StepCollectionViewCell.identifier)
    }
    
    private func buildUI() {
        prepareCollectionView()
        view.add(view: collectionView)
    }
    
    func moveToStep(at position: Int) {
        let indexPath = IndexPath(row: position, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}

extension FormStepCollectionController: UICollectionViewDelegate, UICollectionViewDataSource {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stepDependence.numberOfSteps+1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StepCollectionViewCell.identifier, for: indexPath) as? StepCollectionViewCell else { return UICollectionViewCell() }
        items.append(indexPath)
        
        return cell
    }
    
    func didNext() {
        
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(
           red:   .random(),
           green: .random(),
           blue:  .random(),
           alpha: 1.0
        )
    }
}
extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
