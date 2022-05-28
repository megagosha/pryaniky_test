//
//  SelectorCell.swift
//  pryaniki
//
//  Created by George Tevosov on 26.05.2022.
//

import Foundation
import UIKit


class SelectorCell: UITableViewCell, CellInfo {
    
    func getInfo() -> String {
        return "Selector cell triggered. Selected id is \(selectedId)"
    }
    
    private var pickerData: [String]
    
    private var selector: Selector
    
    private var selectedId: Int
    
    private var picker: ToolbarPickerView = {
        let picker = ToolbarPickerView()
        return picker
    }()
    
    
    public var pickerTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isUserInteractionEnabled = true
        textField.textAlignment = .center
        textField.autocorrectionType = .no
        textField.allowsEditingTextAttributes = false
        return textField
    }()
    
    private func setPicker() {
        picker.delegate = self
        picker.dataSource = self
        picker.center = self.center
        picker.toolbarDelegate = self
        pickerTextField.delegate = self
        pickerTextField.text = selector.getTextById(id: selectedId)
        pickerTextField.inputAccessoryView = picker.toolbar
        pickerTextField.isUserInteractionEnabled = true
        pickerTextField.textAlignment = .center
        pickerTextField.autocorrectionType = .no
        pickerTextField.inputView = picker
        pickerTextField.borderStyle = .roundedRect
    }
    
    private func setConstraints() {
        var constraints : [NSLayoutConstraint] = []
        constraints.append(pickerTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor))
        constraints.append(pickerTextField.centerYAnchor.constraint(equalTo: self.centerYAnchor))
        constraints.append(pickerTextField.widthAnchor.constraint(equalToConstant: 150))
        constraints.append(pickerTextField.heightAnchor.constraint(equalToConstant: 60))
        NSLayoutConstraint.activate(constraints)
        
    }
    
    init(data: Selector) {
        self.selector = data
        self.selectedId = data.selectedId
        
        pickerData = data.variants.map{ $0.text }
        super.init(style: .default, reuseIdentifier: "SelectorCell")
        setPicker()
        contentView.addSubview(pickerTextField)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SelectorCell: UIPickerViewDelegate, UIPickerViewDataSource, ToolbarPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    
    func didTapDone() {
        self.selectedId = selector.variants[self.picker.selectedRow(inComponent: 0)].id
        pickerTextField.text = self.selector.getTextById(id: selectedId)
        self.pickerTextField.resignFirstResponder()
    }
    
    func didTapCancel() {
        self.pickerTextField.resignFirstResponder()
    }
}

extension SelectorCell: UITextFieldDelegate {
    override func canPerformAction(_ action: ObjectiveC.Selector, withSender sender: Any?) -> Bool {
        return false
    }
}
