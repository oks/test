//
//  Contributor.swift
//  TestTask
//
//  Created by Oksana Kovalchuk on 7/3/18.
//  Copyright © 2018 Oksana Kovalchuk. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Contributor: JSONAbleType {
    
    var username: String?
    var photoURLString = ""
    
    static func fromJSON(_ data: Any) -> Contributor {
        let json = JSON(data)
        
        var model = Contributor()
        
        model.username = json["login"].string
        model.photoURLString = json["avatar_url"].stringValue
        
        return model
    }
}
