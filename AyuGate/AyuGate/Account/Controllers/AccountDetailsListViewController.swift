//
//  AccountDetailsListViewController.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 11/05/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit

class AccountDetailsListViewController: UIViewController {
    
    struct Model {
        let title: String
        let value: String
    }
    
    var model: [Model] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildUI()
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AccountDetailsTableViewCell.self, forCellReuseIdentifier: AccountDetailsTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .none
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private func buildUI() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 5).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -14).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}


extension AccountDetailsListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AccountDetailsTableViewCell.identifier, for: indexPath) as? AccountDetailsTableViewCell else { return AccountDetailsTableViewCell() }
        let cellModel = model[indexPath.row]
        cell.content.titleLabel.text = cellModel.title
        cell.content.valueLabel.text = cellModel.value
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
