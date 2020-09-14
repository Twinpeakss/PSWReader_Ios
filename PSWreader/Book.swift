import Foundation
import UIKit

struct Book: Decodable {
    let name: String
    let author: String
    let published: Int
    let cover: String
    let desc: String
    let type: String
    let lang: String
    let availability: Bool
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
