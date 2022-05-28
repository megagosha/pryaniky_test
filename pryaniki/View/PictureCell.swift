//
//  PictureCell.swift
//  pryaniki
//
//  Created by George Tevosov on 26.05.2022.
//

import Foundation
import UIKit

class PictureCell: UITableViewCell, CellInfo {
    
    let url: URL
    
    var img: UIImage?
    
    var imgView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    func getInfo() -> String {
        return "Picture cell tapped. URL: \(self.url.absoluteURL)"
    }
    
    private func appendImage() {
        imgView.image = img
        self.contentView.addSubview(imgView)
        setConstraints()
    }
    
    private func setConstraints() {
        var constraints : [NSLayoutConstraint] = []
        constraints.append(imgView.centerXAnchor.constraint(equalTo: self.centerXAnchor))
        constraints.append(imgView.centerYAnchor.constraint(equalTo: self.centerYAnchor))
        constraints.append(imgView.widthAnchor.constraint(equalToConstant: 150))
        constraints.append(imgView.heightAnchor.constraint(equalToConstant: 150))
        
        NSLayoutConstraint.activate(constraints)
    }
    
    init(data: Picture) {
        self.url = data.url
        self.img = nil
        super.init(style: .default, reuseIdentifier: "PictureCell")
        data.load(completion: {[weak self] image in
            if image == nil {
                return
            }
            self!.img = image
            self!.appendImage()
            return
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
