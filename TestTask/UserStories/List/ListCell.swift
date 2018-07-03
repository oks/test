//
//  ListCell.swift
//  TestTask
//
//  Created by Oksana Kovalchuk on 7/3/18.
//  Copyright © 2018 Oksana Kovalchuk. All rights reserved.
//

import Foundation
import AlisterSwift
import SnapKit
import Kingfisher

class ListCellVM: ViewModelInterface {
    
    var item: Contributor
    
    init(item: Contributor) {
        self.item = item
    }
    
    func username() -> String {
        return item.username ?? "Anonymous" // TODO: use localizable
    }
}



class ListCell: UITableViewCell, ReusableViewInterface {
    //we won't create a new image each time when cell is going to reuse
    static let placeholder = UIImage.init(named: "placeholder")
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        imageView?.layer.cornerRadius = 22
        imageView?.clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(_ model: ViewModelInterface) {
        
        guard let viewModel = model as? ListCellVM else { return }
        imageView?.setImage(urlString: viewModel.item.photoURLString,
                            placeholderImage: ListCell.placeholder)
        textLabel?.text = viewModel.username()
    }
}
