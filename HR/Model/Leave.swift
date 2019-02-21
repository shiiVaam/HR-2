
//
//  Leave.swift
//  HR
//
//  Created by sandeep@nettechnocrats on 16/10/18.
//  Copyright © 2018 sandeep@nettechnocrats. All rights reserved.
//

import Foundation
import Firebase

class Leave{
    
    static let shared = Leave()
    
    init() { }
    
    public var Leaveid:String = ""
    public var description:String = ""
    public var title:String = ""
    public var data:[DataLeave] = []
    
    func initwithparam( Description:String, Title:String, Data:[DataLeave]){
        self.description = Description
        self.title = Title
        self.data = Data
        
    }
    
    
    
    
    
}



