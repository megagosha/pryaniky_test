//
//  Selector.swift
//  pryaniki
//
//  Created by George Tevosov on 26.05.2022.
//

import Foundation

struct Selector: Codable, Equatable {
    let selectedId: Int
    var variants: [SelectorVariant]
    
    func getTextById(id: Int)->String? {
        for el in variants {
            if (el.id == id) {
                return el.text
            }
        }
        return nil
    }
}


struct SelectorVariant: Codable, Equatable {
    let id: Int
    let text: String
}
