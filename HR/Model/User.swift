//
//  User.swift
//  HR
//
//  Created by sandeep@nettechnocrats on 11/10/18.
//  Copyright © 2018 sandeep@nettechnocrats. All rights reserved.
//

import Foundation
import Firebase

class User{
    
    
    static let shared = User()
    
    private init() {}
    public var username :String = " "
    public var emailAdd :String = " "
    public var uid:String = " "
    public var password :String = " "
    
//    var abc : String{
//        get{
//            return username
//        }
//        set{
//            self.abc = newValue
//        }
//    }
//    var xyz : String{
//
//        get{
//            return emailAddress
//        }
//        set{
//           self.xyz = newValue
//        }
//    }
    
    func initUserWithParm(userName:String, emailAdd:String,uID:String,passWOrd:String) {
        self.username = userName
        self.emailAdd = emailAdd
        self.uid = uID
        self.password = passWOrd
    }
    
//    func getAllData() -> NSDictionary {
//        let dict = NSDictionary.init(objects: ["","",""], forKeys: ["","",""])
//
//    }
   
        
        
    
   }
