//
//  Detail.swift
//  TestTask
//
//  Created by Oksana Kovalchuk on 7/3/18.
//  Copyright © 2018 Oksana Kovalchuk. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class DetailVC: UIViewController {
    
    let imageView = UIImageView()
    var photoURLString: String?
    
    init(photoURLString: String) {
        self.photoURLString = photoURLString
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        imageView.setImage(urlString: photoURLString, placeholderImage: UIImage.init(named: "placeholder"))
    }
}
