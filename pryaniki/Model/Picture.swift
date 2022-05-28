//
//  Picture.swift
//  pryaniki
//
//  Created by George Tevosov on 26.05.2022.
//

import Foundation
import UIKit

struct Picture: Codable {
    let url: URL
    let text: String
    
    public func load(completion: @escaping  (UIImage?) -> Swift.Void) {
        URLSession(configuration: .default).dataTask(with: self.url as URL) { (data, response, error) in
            guard let responseData = data, let image = UIImage(data: responseData) else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            DispatchQueue.main.async {
                completion(image)
            }
            return
        }.resume()
    }
}
