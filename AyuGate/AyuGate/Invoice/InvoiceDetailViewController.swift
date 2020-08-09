//
//  InvoiceDetailViewController.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 05/05/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit

class InvoiceDetailViewController: AYUViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildUI()
    }
    
    var invoiceModel: InvoicedetailsViewModel
    
    init(invoice: InvoicedetailsViewModel) {
        self.invoiceModel = invoice
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    struct Constants {
        static let headerHeight = UIScreen.main.bounds.height / 2.8
    }

    private lazy var descripitionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        label.textColor = .white
        label.text = "Líquido"
        return label
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 38, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 11, weight: .bold)
        label.textColor = UIColor.whitePlaceholder
        label.text = "Terça, 01/04, 2019"
        return label
    }()
    
    private lazy var headerContentView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .black
        v.clipsToBounds = false
        v.layer.cornerRadius = 26
        v.heightAnchor.constraint(equalToConstant: Constants.headerHeight).isActive = true
        
        let closeView = UIImageView()
        v.addSubview(closeView)
        
        closeView.translatesAutoresizingMaskIntoConstraints = false
        closeView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        closeView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        closeView.image = UIImage(named: "CloseButtonIcon")
        closeView.topAnchor.constraint(equalTo: v.topAnchor, constant: 31).isActive = true
        closeView.trailingAnchor.constraint(equalTo: v.trailingAnchor, constant: -5).isActive = true
        closeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissController)))
        closeView.isUserInteractionEnabled = true
        
        return v
    }()
    
    @objc private func dismissController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    private lazy var profileCardView: ProfileInfoCardView = {
        let view = ProfileInfoCardView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var monthsPickerView: AYUMonthsPickerView = {
        let view = AYUMonthsPickerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var invoiceListDetailsViewController: InvoiceListDetailsViewController = {
        let controller = InvoiceListDetailsViewController()
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        
        return controller
    }()

    
    private func buildUI() {
        view.addSubview(headerContentView)
        headerContentView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        headerContentView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        headerContentView.topAnchor.constraint(equalTo: view.topAnchor, constant: -26).isActive = true
        
        headerContentView.addSubview(descripitionLabel)
        descripitionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 27).isActive = true
        descripitionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        
        headerContentView.addSubview(valueLabel)
        valueLabel.leadingAnchor.constraint(equalTo: descripitionLabel.leadingAnchor).isActive = true
        valueLabel.topAnchor.constraint(equalTo: descripitionLabel.bottomAnchor, constant: 20).isActive = true
        
        headerContentView.addSubview(dateLabel)
        dateLabel.leadingAnchor.constraint(equalTo: descripitionLabel.leadingAnchor).isActive = true
        dateLabel.topAnchor.constraint(equalTo: valueLabel.bottomAnchor, constant: 5).isActive = true
        
        headerContentView.addSubview(profileCardView)
        profileCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 27).isActive = true
        profileCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -27).isActive = true
        profileCardView.heightAnchor.constraint(equalToConstant: Constants.headerHeight / 2.5).isActive = true
        profileCardView.centerYAnchor.constraint(equalTo: headerContentView.bottomAnchor, constant: 10).isActive = true
        
        view.addSubview(monthsPickerView)
        monthsPickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        monthsPickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        monthsPickerView.topAnchor.constraint(equalTo: profileCardView.bottomAnchor, constant: 22).isActive = true
        monthsPickerView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        monthsPickerView.currentSelectedMonth = 5
        
        installChild(invoiceListDetailsViewController)
        invoiceListDetailsViewController.view.topAnchor.constraint(equalTo: monthsPickerView.bottomAnchor, constant: 5).isActive = true
        invoiceListDetailsViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        invoiceListDetailsViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        invoiceListDetailsViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        valueLabel.text = invoiceModel.formattedCurrentAmount
        profileCardView.cpfLabel.text = invoiceModel.cpfValue
        profileCardView.profileNameLabel.text = invoiceModel.customerName
        profileCardView.officeLabel.text = invoiceModel.customerRole
        
        let details = invoiceModel.roll.compactMap({ AYUInvoiceDetailsViewModel(roll: $0) })
        invoiceListDetailsViewController.model = InvoiceListDetailsViewModel(company: invoiceModel.companyName, details: details)
    }
}
