//
//  UIImageView+Extension.swift
//
//  Created by Luiz Felipe Aires Soares on 2022-03-31.
//

import Foundation
import UIKit

extension UIImageView {
    
    func downloadImage(_ url: URL, placeholder: UIImage? = nil, contentMode: UIView.ContentMode = .scaleAspectFit) {
        self.contentMode = contentMode
        if let placeholder = placeholder {
            self.image = placeholder
        }
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 30)
        DispatchQueue.global(qos: .userInitiated).async {
            URLSession.shared.dataTask(with: request) { data, urlResponse, error in
                guard let imageData = data, let downloadedImage = UIImage(data: imageData) else { return }
                DispatchQueue.main.async { [weak self] in
                    guard let strongSelf = self else { return }
                    strongSelf.image = downloadedImage
                }
            }.resume()
        }
    }
    
}
