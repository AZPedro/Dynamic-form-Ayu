//
//  InvoiceDetailViewController.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 05/05/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit
import AyuKit

class InvoiceDetailViewController: AYUViewController {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        buildUI()
    }
    
    var invoiceModel: [InvoicedetailsViewModel]? {
        didSet {
            updateWeekPickerView()
        }
    }
    
    var selectedInvoice: InvoicedetailsViewModel? {
        didSet {
            guard let selectedInvoice = selectedInvoice else { return }
            updateInvoice(with: selectedInvoice)
        }
    }
    
    let accountInfo = SessionManager.shared.getAccount()
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    struct Constants {
        static let headerHeight = UIScreen.main.bounds.height / 2.8
    }
    
    let loadingView = AyuActivityView()

    private lazy var descripitionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        label.textColor = .white
        label.text = "Bruto"
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
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var weekPickerView: AYUWeekPickerView = {
        let view = AYUWeekPickerView()
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var invoiceListDetailsViewController: InvoiceListDetailsViewController = {
        let controller = InvoiceListDetailsViewController()
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        
        return controller
    }()

    
    private func buildUI() {
        view.backgroundColor = .white
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
        
        view.addSubview(weekPickerView)
        weekPickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        weekPickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        weekPickerView.topAnchor.constraint(equalTo: monthsPickerView.bottomAnchor, constant: 10).isActive = true
        weekPickerView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        installChild(invoiceListDetailsViewController)
        invoiceListDetailsViewController.view.topAnchor.constraint(equalTo: weekPickerView.bottomAnchor, constant: 5).isActive = true
        invoiceListDetailsViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        invoiceListDetailsViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        invoiceListDetailsViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        view.add(view: loadingView)
        loadingView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        
//        let currentMonth = Calendar.current.component(.month, from: Date())
        var currentMonth: Int
        
        if accountInfo?.cpf == "07988032151" {
            currentMonth = 8
        } else {
           currentMonth = 9
        }
        
        monthsPickerView.currentSelectedMonth = currentMonth-1
        let monthFormatted = currentMonth <= 9 ? "0\(currentMonth)" : "\(currentMonth)"
        fetchPayRoll(month: "2020-\(monthFormatted)")
    }
    
    private func fetchPayRoll(month: String) {
        loadingView.state = .start
        let request = AYURequest(route: .init(path: .payRoll(month: month)), .get, body: nil)
        
        NetworkManager.shared.makeRequest(request: request) { (result: Invoices?, validation: Validation?) in
            self.loadingView.state = .stop
            self.invoiceModel = result?.response.compactMap({ invoice in
                InvoicedetailsViewModel(currentAmount: invoice.grossAmount, companyName: invoice.company.name, customerRole: invoice.employee.role, week: invoice.description, month: invoice.month, roll: invoice.events)
            })

            DispatchQueue.main.async {
                if let lastItem = self.invoiceModel?.last {
                    self.invoiceListDetailsViewController.view.isHidden = false
                    self.updateInvoice(with: lastItem)
                } else {
                    self.invoiceListDetailsViewController.view.isHidden = true
                }
            }
        }
    }
    
    private func updateWeekPickerView() {
        guard let invoiceModel = self.invoiceModel else { return }
        DispatchQueue.main.async {
            self.weekPickerView.currentSelectedMonth = invoiceModel.count - 1
            self.weekPickerView.weeks = invoiceModel.compactMap({ $0.week })
        }
    }
    
    private func updateInvoice(with invoiceModel: InvoicedetailsViewModel) {
        valueLabel.text = invoiceModel.formattedCurrentAmount
        profileCardView.cpfLabel.text = accountInfo?.cpf ?? ""
        profileCardView.profileNameLabel.text = accountInfo?.name.components(separatedBy: " ").prefix(2).joined(separator: " ")
        profileCardView.officeLabel.text = invoiceModel.customerRole
        invoiceListDetailsViewController.model = InvoiceListDetailsViewModel(company: invoiceModel.companyName, details: invoiceModel.roll.map({ AYUInvoiceDetailsViewModel(roll: $0) }))
    }
}

extension InvoiceDetailViewController: AYUMonthsPickerViewDelegate, AYUWeekPickerViewDelegate {
    func didSelectMonth(pickedView: AYUPickView) {
        let currentMonth = pickedView.selectedValue
        let monthFormatted = currentMonth <= 9 ? "0\(currentMonth)" : "\(currentMonth)"
        fetchPayRoll(month: "2020-\(monthFormatted)")
    }
    
    func didSelectWeek(pickedView: AYUPickView) {
        selectedInvoice = self.invoiceModel?[pickedView.selectedValue]
    }
}
