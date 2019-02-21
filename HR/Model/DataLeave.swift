//
//  DataLeave.swift
//  HR
//
//  Created by sandeep@nettechnocrats on 16/10/18.
//  Copyright © 2018 sandeep@nettechnocrats. All rights reserved.
//

import Foundation
import Firebase


class DataLeave{

    static let shared = DataLeave()
    init() {}
    public var body:String = ""
    public var subject:String = ""
    
    func initwithparam( body:String, subject:String){
        self.body = body
        self.subject = subject
    }





}
