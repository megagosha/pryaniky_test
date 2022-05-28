//
//  ResponseModel.swift
//  pryaniki
//
//  Created by George Tevosov on 26.05.2022.
//

import Foundation

struct ApiResult: Decodable {
    let data: [DataType]
    let view: [ViewType]
    
    enum ViewType: String, Decodable {
        case hz, selector, picture
//       case unknown(value: String)
    }
    
    func getPicture()->DataType? {
        for el in data {
            if case .picture(_) = el {
                return el
            }
        }
        return nil
    }
    
    func getSelector()->DataType? {
        for el in data {
            if case .selector(_) = el {
                return el
            }
        }
        return nil
    }
    
    func getHz()->DataType? {
        for el in data {
            if case .hz(_) = el {
                return el
            }
        }
        return nil
    }
}


enum DataType: Decodable, Equatable {
    case hz(Hz)
    case picture(Picture)
    case selector(Selector)
    case unsupported
    
    static func ==(lhs: DataType, rhs: DataType) -> Bool {
        switch (lhs, rhs) {
        case (let .hz(a1), let .hz(a2)):
            return a1.text == a2.text
        case (let .picture(a1), let .picture(a2)):
            return a1.url == a2.url
        case (let .selector(a1), let .selector(a2)):
            return a1.selectedId == a2.selectedId && a1.variants == a2.variants
        default:
            return false
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case name
        case data
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let name = try container.decode(String.self, forKey: .name)
        switch name {
        case "picture":
            let data = try? container.decode(Picture.self, forKey: .data)
            self = data.map({.picture($0)}) ?? .unsupported
        case "selector":
            let data = try? container.decode(Selector.self, forKey: .data)
            self = data.map({.selector($0)}) ?? .unsupported
        case "hz":
            let data = try? container.decode(Hz.self, forKey: .data)
            self = data.map({.hz($0)}) ?? .unsupported
        default:
            self = .unsupported
        }
    }
}
