//
//  UserService.swift
//  Restaurant DiscoveryPin
//
//  Created by Mohamed Salah Zidane on 10/4/18.
//  Copyright © 2018 Mohamed Salah Zidane. All rights reserved.
//

import Foundation
import Firebase

class UserService {
    
    static var currentUserProfile:UserProfile?
    
    static func observeUserProfile(_ uid:String, completion: @escaping ((_ userProfile:UserProfile?)->())) {
        let userRef = Database.database().reference().child("users/profile/\(uid)")
        userRef.observe(.value, with: { snapshot in
            var userProfile:UserProfile?
               print("in observe")
            if let dict = snapshot.value as? [String:Any],
                let username = dict["username"] as? String,
                let photoURL = dict["photoURL"] as? String,
                let url = URL(string:photoURL) {
                print(username  )
                userProfile = UserProfile(uid: snapshot.key, username: username, photoURL: url)
            }
            
            completion(userProfile)
        })
    }
    
}
