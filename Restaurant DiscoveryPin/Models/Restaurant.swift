//
//  File.swift
//  ZidaneFood
//
//  Created by Mohamed Salah Zidane on 8/31/18.
//  Copyright © 2018 Mohamed Salah Zidane. All rights reserved.
//

import Foundation
class Restaurant {
    var id :String
    var author : UserProfile
    var name = ""
    var location = ""
    var type = ""
    var image = ""
    var imageURL:URL!
    var phone = ""
    var isVisited = false
    var rating = ""
    var createdAt :Date
//    init(name:String ,type:String, location:String  , phone:String,image:String, isVisited:Bool) {
//        self.name = name
//        self.location = location
//        self.type = type
//        self.image = image
//        self.phone = phone
//        self.isVisited = isVisited
//    }
    init(id:String,author:UserProfile,name:String ,type:String, location:String  , phone:String,imageURL:URL, isVisited:Bool,timestamp:Double) {
        self.id = id
        self.name = name
        self.location = location
        self.type = type
        self.phone = phone
        self.imageURL = imageURL
        self.isVisited = isVisited
        self.author = author
        self.createdAt = Date(timeIntervalSince1970: timestamp / 1000)
        
    }
}
