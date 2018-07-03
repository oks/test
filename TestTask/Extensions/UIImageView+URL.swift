//
//  UIImageView+URL.swift
//  TestTask
//
//  Created by Oksana Kovalchuk on 7/3/18.
//  Copyright © 2018 Oksana Kovalchuk. All rights reserved.
//

import Foundation
import Kingfisher

// MARK: - Better to wrap all possible third parties, as tomorrow it can became unsupported and we will require 'hot swap' on another one
extension UIImageView {
    
    func setImage(urlString: String?,
                  placeholderImage: UIImage? = nil) {
        
        self.kf.setImage(with: URL(string: urlString ?? ""),
                         placeholder: placeholderImage,
                         options: [.transition(.fade(0.3))]) { (_, _, _, _) in
        }
    }
}
