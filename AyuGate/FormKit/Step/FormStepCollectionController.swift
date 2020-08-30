//
//  FormStepCollectionController.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 09/08/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit

public protocol StepProtocol {
    var numberOfSteps: Int { get set }
    var currentStep: Int { get set }
    var delegate: StepProtocolDelegate? { get set }
}

public protocol FormLayoutDelegate {
    func updateLayout(for sectionLayout: FormLayout)
}

public protocol FormLayout {
    var isScrollEnabled: Bool { get set }
    var shouldShowStepBottom: Bool { get set }
    var shouldShowPageControl: Bool { get set }
    var delegate: FormLayoutDelegate? { get set }
}

extension FormLayout {
    
    public var delegate: FormLayoutDelegate? {
        get {
            return nil
        }
        
        set {
            
        }
    }
    
    public var shouldShowPageControl: Bool {
        get {
            return true
        }
        set {
            
        }
    }
    
    public var shouldShowStepBottom: Bool {
        get {
            return true
        }
        
        set {
            
        }
    }
    
    public var isScrollEnabled: Bool {
        get {
            return true
        }
        
        set {
            
        }
    }
    
    
}

class FormStepCollectionController<T: StepCollectionViewCell>: UIViewController, StepProtocolDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    internal var stepDependence: StepProtocol
    internal var formCollectionLayout: FormLayout
    internal var formSectionDependence: [FormSection]
    var items: [IndexPath] = []

    public lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
    private var collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = UIScreen.main.bounds.size
        flowLayout.scrollDirection = .horizontal
        return flowLayout
    }()
    
    public var delegate: StepProtocolDelegate?
    
    private var shouldMoveToStep = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildUI()
    }
    
    init(stepDependence: StepProtocol, formSectionDependence: [FormSection], formCollectionLayoutDependence: FormLayout) {
        self.stepDependence = stepDependence
        self.formSectionDependence = formSectionDependence
        self.formCollectionLayout = formCollectionLayoutDependence
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func prepareCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.isScrollEnabled = formCollectionLayout.isScrollEnabled
        collectionView.isUserInteractionEnabled = true
        collectionView.register(T.self, forCellWithReuseIdentifier: T.identifier)
    }
    
    private func buildUI() {
        prepareCollectionView()
        view.add(view: collectionView)
    }
    
    func moveToStep(at position: Int) {
        guard formCollectionLayout.shouldShowStepBottom && !formCollectionLayout.isScrollEnabled else { return }
        let indexPath = IndexPath(row: position, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stepDependence.numberOfSteps+1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as? T else { return UICollectionViewCell() }
        items.append(indexPath)
        
        cell.setup(section: formSectionDependence[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        guard formCollectionLayout.isScrollEnabled else { return }
        if shouldMoveToStep {
            self.delegate?.moveToStep(at: indexPath.row)
            
            guard let sectionLayout = formSectionDependence[indexPath.row].layout else { return }
            sectionLayout.delegate?.updateLayout(for: sectionLayout)
            
        } else {
            shouldMoveToStep = true
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func didNext() {
        
    }
}
