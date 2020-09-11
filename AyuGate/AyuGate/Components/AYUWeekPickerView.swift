//
//  AYUWeekPickerView.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 08/09/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit

protocol AYUWeekPickerViewDelegate {
    func didSelectWeek(pickedView: AYUPickView)
}

class AYUWeekPickerView: UIView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var weeks: [String] = [] {
        didSet {
            self.picker.reloadAllComponents()
        }
    }
    
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
    var delegate: AYUWeekPickerViewDelegate?
    
    var weekPickViews: [AYUPickView] {
        var views = [AYUPickView]()
        
        weeks.forEach { weak in
            let monthView = AYUPickView()
            monthView.transform = CGAffineTransform(rotationAngle: 90 * (.pi / 180))
            monthView.titleLabel.text = weak
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
        return weeks.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let monthView = weekPickViews[row]
        return monthView
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 80
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let view = pickerView.view(forRow: row, forComponent: component) as? AYUPickView else { return }
        view.isSelected = true
        view.selectedValue = row
        delegate?.didSelectWeek(pickedView: view)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        for i in [1, 2] {
            picker.subviews[i].isHidden = true
        }
    }
    
}
