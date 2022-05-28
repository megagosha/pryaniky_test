//
//  BasicCell.swift
//  pryaniki
//
//  Created by George Tevosov on 27.05.2022.
//

import Foundation
import UIKit


final class CellGenerator {
    static func create(type: DataType?)->CellInfo {
        switch type! {
        case .hz(let hz):
            return HzCell(data: hz)
        case .picture(let pic):
            return PictureCell(data: pic)
        case .selector(let select):
            return SelectorCell(data: select)
        case .unsupported:
            return HzCell(data: Hz(text: "unsupported"))
        }
    }
}

protocol CellInfo: UITableViewCell {
    
    func getInfo()->String
}

