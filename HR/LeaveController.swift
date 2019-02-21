//
//  LeaveController.swift
//  HR
//
//  Created by sandeep@nettechnocrats on 05/10/18.
//  Copyright © 2018 sandeep@nettechnocrats. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class LeaveController: Global,UITableViewDelegate,UITableViewDataSource{
    var ref:DatabaseReference?
    var leaveModel :Leave?
    public var leaves:[Leave] = []
    
    var dataModel: [DataLeave] = []
    var dataM:DataLeave?
    
    var dataDict : [String:Any] = [:]
    var leaveDict : [String:Any] = [:]
    var keyArray:[String] = []
    var valueArray:NSMutableArray = []
    
   
    var keydata : [String] = []
    var valuedata : NSMutableArray = []
    
    
    @IBOutlet var tableview:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference().child("leave")
        
          self.addleave()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
//
//    func fetchDataFromFirebase() {
//        ref?.observeSingleEvent(of: .value, with: { snapshot in
//
//            if !snapshot.exists() {
//                //error
//
//                return }
//            self.leaveDict = snapshot.value as! Dictionary
//            let lazyMapCollection = self.leaveDict.keys
//            self.keyArray = Array(lazyMapCollection)
//
//            for str in self.keyArray
//            {
//                if (self.leaveDict[str] != nil) {
//                    let dict = self.leaveDict[str] as? [String:Any]
//                    let keyStr = str+" desc"
//                    let substr = dict![keyStr]
//                    self.valueArray.add(substr!)
//                }
//            }
//            self.tableview.reloadData()
//        })
//    }
//
//
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return keyArray.count ;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) 
        let leavelbl:UILabel = cell.viewWithTag(1) as! UILabel
        let leaveDesc:UILabel = cell.viewWithTag(2) as! UILabel
//        var img:UIImageView = cell.viewWithTag(3) as! UIImageView
        
        let leaveSing:Leave = leaves[indexPath.row]
        leaveDesc.text = leaveSing.description
        leavelbl.text = leaveSing.title

        
        return cell
    
    }
    

    func tableView(_ tableView: UITableView,heightForRowAt indexPath:IndexPath) -> CGFloat
    {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 200
    }
 
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    
    {
        let selectcontrol = self.storyboard?.instantiateViewController(withIdentifier: "SelectedController") as! SelectedController

        let leavevalue = leaves[indexPath.row]
         selectcontrol.dataMode = leavevalue.data
        
            
            
            
//        let xyz = DataLeave.shared
//        xyz.body = (dataM?.body)!
//        xyz.subject = (dataM?.subject)!
        
//         self.leaveModel?.data = self.dataModel
    
      
        self.navigationController?.pushViewController(selectcontrol, animated: true)
    }

    @IBAction func onClickLogout(_ sender: Any) {
       
        logout()
        
    }
    func addleave(){
        ref?.observeSingleEvent(of: .value, with: { snapshot in
        
        if !snapshot.exists() {
            
            return }
            print(snapshot)
            self.leaveDict = snapshot.value as! Dictionary
            let lazyMapCollection = self.leaveDict.keys
            self.keyArray = Array(lazyMapCollection)

            for  Str in self.keyArray{
                if(self.leaveDict[Str] != nil){
                    self.leaveModel = Leave.init()
                    self.dataModel = []

                    let dict = self.leaveDict[Str] as? [String:Any]
                    let keyStr = Str+" desc"
                    self.leaveModel?.description = dict![keyStr] as! String
                    self.leaveModel?.title = Str
                    
                     self.dataDict = dict!["data"] as! [String:Any]
                    let lazyMap = self.dataDict.keys
                    self.keydata = Array(lazyMap)
                    
                
                    for data in self.keydata
                    {
                        if(self.dataDict[data] != nil){
                            self.dataM = DataLeave.init()
                            let dictdata = self.dataDict[data] as! [String:Any]
                         
                            self.dataM?.subject = dictdata["subject"] as! String
                            self.dataM?.body = dictdata["body"] as! String
                            self.dataModel.append(self.dataM!)
                        }
                    }
                    self.leaveModel?.data = self.dataModel
                    self.leaves.append(self.leaveModel!)

                }
            }
            self.tableview.reloadData()
        })
    }
    func logout(){
        try!  Auth.auth().signOut()
        self.popViewController()
    }
}


