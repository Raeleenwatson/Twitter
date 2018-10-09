//
//  User.swift
//  twitter_alamofire_demo
//
//  Created by Raeleen Watson on 10/7/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import Foundation

class User {
    
    static var current: User?
    var name: String?
    var screenName: String?
    
    init(dictionary: [String: Any]) {
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
        // Initialize any other properties
    }
    
    
}
