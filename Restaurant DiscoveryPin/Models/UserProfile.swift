//
//  UserProfile.swift
//  Restaurant DiscoveryPin
//
//  Created by Mohamed Salah Zidane on 10/4/18.
//  Copyright © 2018 Mohamed Salah Zidane. All rights reserved.
//

import Foundation

class UserProfile {
    var uid:String
    var username:String
    var photoURL:URL
   
    init(uid:String, username:String,photoURL:URL) {
        self.uid = uid
        self.username = username
        self.photoURL = photoURL
    }
}
