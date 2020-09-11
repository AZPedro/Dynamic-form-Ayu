//
//  InvoiceListDetailsViewController.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 06/05/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit

class InvoiceListDetailsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildUI()
    }
    
    var model: InvoiceListDetailsViewModel? {
        didSet {
            updateUI()
        }
    }
    
    private lazy var companyNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var branchNameLabel: UILabel = {
        let label = UILabel()
        label.text = "LTDA"
        label.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        label.textColor = UIColor.blackSecondary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(InvoiceDetailsTableViewCell.self, forCellReuseIdentifier: InvoiceDetailsTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private func buildUI() {
        view.backgroundColor = .white
        view.addSubview(companyNameLabel)
        companyNameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        companyNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 23).isActive = true
        
        view.addSubview(branchNameLabel)
        branchNameLabel.topAnchor.constraint(equalTo: companyNameLabel.bottomAnchor, constant: 2).isActive = true
        branchNameLabel.leadingAnchor.constraint(equalTo: companyNameLabel.leadingAnchor).isActive = true
        
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: branchNameLabel.bottomAnchor, constant: 10).isActive = true
        tableView.leadingAnchor.constraint(equalTo: branchNameLabel.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -23).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

    private func updateUI() {
        companyNameLabel.text = model?.company
        tableView.reloadData()
    }
}

struct InvoiceListDetailsViewModel {
    let company: String
    let details: [AYUInvoiceDetailsViewModel]
}

extension InvoiceListDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.details.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: InvoiceDetailsTableViewCell.identifier, for: indexPath) as? InvoiceDetailsTableViewCell else { return InvoiceDetailsTableViewCell() }
        cell.content.model = model?.details[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
