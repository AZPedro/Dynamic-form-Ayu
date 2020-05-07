//
//  AYUMonthsPickerView.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 05/05/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit

class AYUMonthsPickerView: UIView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var titleLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let picker = UIPickerView()
    
    var monthPickViews: [MonthPickView] {
        let months = Calendar.current.shortMonthSymbols
        var views = [MonthPickView]()
        
        months.forEach { month in
            let monthView = MonthPickView()
            monthView.transform = CGAffineTransform(rotationAngle: 90 * (.pi / 180))
            monthView.titleLabel.text = month
            views.append(monthView)
        }
        
        return views
    }
    
    var currentSelectedMonth: Int = 0 {
        didSet {
            picker.selectRow(currentSelectedMonth, inComponent: 0, animated: true)
        }
    }
    
    private func buildUI() {
        backgroundColor = UIColor.whiteSecondary
        picker.showsSelectionIndicator = true
        picker.transform = CGAffineTransform(rotationAngle: -90 * (.pi / 180))
        addSubview(picker)
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.widthAnchor.constraint(equalToConstant: 30).isActive = true
        picker.heightAnchor.constraint(equalToConstant: 172).isActive = true
        picker.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        picker.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        picker.delegate =  self
        picker.dataSource = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 12
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let monthView = monthPickViews[row]
        return monthView
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let view = pickerView.view(forRow: row, forComponent: component) as? MonthPickView else { return }
        view.isSelected = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        for i in [1, 2] {
            picker.subviews[i].isHidden = true
        }
    }
    
}

class MonthPickView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = UIColor.blackTerciary
        l.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return l
    }()
    
    var contentView = UIView()
    
    private func buildUI() {
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -3).isActive = true
        contentView.topAnchor.constraint(equalTo: topAnchor, constant: 3).isActive = true
        contentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 3).isActive = true
        contentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -3).isActive = true
        contentView.layer.borderWidth = 0
        contentView.layer.borderColor = UIColor.blackTerciary.cgColor
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 8
        
        addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    var isSelected: Bool = false {
        didSet {
            contentView.layer.borderWidth = isSelected ? 1 : 0
        }
    }
}
