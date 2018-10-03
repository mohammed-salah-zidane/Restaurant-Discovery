//
//  File.swift
//  ZidaneFood
//
//  Created by Mohamed Salah Zidane on 8/31/18.
//  Copyright © 2018 Mohamed Salah Zidane. All rights reserved.
//

import Foundation
class Restaurant {
    var name = ""
    var location = ""
    var type = ""
    var image = ""
    var phone = ""
    var isVisited = false
    var rating = ""
    init(name:String ,type:String, location:String  , phone:String,image:String, isVisited:Bool) {
        self.name = name
        self.location = location
        self.type = type
        self.image = image
        self.phone = phone
        self.isVisited = isVisited
    }
}
