//
//  TableView.swift
//  pryaniki
//
//  Created by George Tevosov on 26.05.2022.
//

import Foundation
import UIKit


class ApiTableView: UITableView {
    
    private var tvm: TableViewModel
    
    private var label: UILabel
    
    init(model: TableViewModel, info: UILabel) {
        self.tvm = model
        self.label = info
        super.init(frame: CGRect(), style: .plain)
        setTable()

    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTable() {
        translatesAutoresizingMaskIntoConstraints = false
        isScrollEnabled = true
        bounces = true
        separatorStyle = .singleLine
        delegate = self
        register(PictureCell.self, forCellReuseIdentifier: "PictureCell")
        register(SelectorCell.self, forCellReuseIdentifier: "SelectorCell")
        self.register(HzCell.self, forCellReuseIdentifier: "HzCell")
        dataSource = self
        rowHeight =  UITableView.automaticDimension
    }
}

extension ApiTableView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tvm.data?.view.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let res = tvm.getDataForRow(index: indexPath.row)
        {
            res.selectionStyle = .none
            return res
        }
      
        return CellGenerator.create(type: .unsupported)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tvm.data?.view[indexPath.row] == .picture {
            return 200
        }
        
        if tvm.data?.view[indexPath.row] == .selector {
            return 150
        }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? CellInfo
        self.label.text = cell?.getInfo()
    }
    
}

