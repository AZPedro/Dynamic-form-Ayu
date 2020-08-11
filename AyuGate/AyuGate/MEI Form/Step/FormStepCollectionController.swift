//
//  FormStepCollectionController.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 09/08/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit

class FormStepCollectionController: UIViewController, StepProtocol {
    var currentStep: Int
    var numberOfSteps: Int
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
    
    init(numberOfSteps: Int, currentStep: Int) {
        self.numberOfSteps = numberOfSteps
        self.currentStep = currentStep
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
        collectionView.isUserInteractionEnabled = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: StepCollectionViewCell.identifier)
    }
    
    private func buildUI() {
        prepareCollectionView()
        view.add(view: collectionView)
    }
    
    func moveToStep(at position: Int) {
        currentStep = position
        delegate?.moveToStep(at: position)
    }
}

extension FormStepCollectionController: UICollectionViewDelegate, UICollectionViewDataSource {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfSteps
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StepCollectionViewCell.identifier, for: indexPath)
        items.append(indexPath)
        cell.backgroundColor = .clear
        return cell
    }
    
    func didNext() {
        
    }
}
