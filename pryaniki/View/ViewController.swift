//
//  ViewController.swift
//  pryaniki
//
//  Created by George Tevosov on 26.05.2022.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    private var tvm: TableViewModel = TableViewModel()
    
    private var table: ApiTableView
    
    private var label: UILabel = {
        
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    required init() {
        self.table = ApiTableView(model: tvm, info: label)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = table.backgroundColor
        label.backgroundColor = table.backgroundColor
        view.addSubview(table)
        view.addSubview(label)
        setConstraints()
        tvm.getData(completion: {_ in
            self.tvm.getData(completion: {[weak self] res in
                self?.proccessData(res: res)
            })
        })
    }
    
    func setConstraints() {
        var constraints : [NSLayoutConstraint] = []
    
        constraints.append(table.topAnchor.constraint(equalTo: view.topAnchor))
        constraints.append(table.leadingAnchor.constraint(equalTo: view.leadingAnchor))
        constraints.append(table.trailingAnchor.constraint(equalTo: view.trailingAnchor))
        constraints.append(table.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100))
        
        constraints.append(label.heightAnchor.constraint(equalToConstant: 100))
        constraints.append(label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20))
        constraints.append(label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
        constraints.append(label.bottomAnchor.constraint(equalTo: view.bottomAnchor))
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func showAlertTapped() {
        let alert = UIAlertController(title: "Error", message: "Failed to download resource", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Retry", style: UIAlertAction.Style.default, handler: {_ in
            self.tvm.getData(completion: {[weak self] res in
                self?.proccessData(res: res)
            })
        }))
         self.present(alert, animated: true, completion: nil)
    }
    
    func proccessData(res: ApiResult?) {
        guard res != nil
        else {
            showAlertTapped()
            return
        }
        table.reloadData()
    }
}

