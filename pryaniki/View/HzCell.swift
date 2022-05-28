//
//  BasicCell.swift
//  pryaniki
//
//  Created by George Tevosov on 26.05.2022.
//

import Foundation
import UIKit

class HzCell: UITableViewCell, CellInfo {
    var text: String
    func getInfo() -> String {
        return "Hz cell with text: \(self.text)"
    }
    
    init(data: Hz) {
        text = data.text
        super.init(style: .default, reuseIdentifier: "HzCell")
        self.textLabel?.text = data.text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
