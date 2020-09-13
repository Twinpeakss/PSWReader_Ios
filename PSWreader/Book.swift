//
//  Book.swift
//  PSWreader
//
//  Created by projekt sz on 13.09.2020.
//  Copyright © 2020 dima. All rights reserved.
//

import Foundation
import UIKit

struct Book: Decodable {
    let name: String
    let author: String
    let published: String
    let cover: String
    let desc: String
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
