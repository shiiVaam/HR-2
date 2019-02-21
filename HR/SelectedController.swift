//
//  SelectedController.swift
//  HR
//
//  Created by sandeep@nettechnocrats on 05/10/18.
//  Copyright © 2018 sandeep@nettechnocrats. All rights reserved.
//

import UIKit


class SelectedController: Global,UITableViewDataSource,UITableViewDelegate {
//    var arra:[String] = []
      var subjectDATA:String!
      var bodyDATA: String!
       var DATA :String!
      var dataMode: [DataLeave] = []
      var datM:DataLeave?
//       var dataMode: [DataLeave] = []
//       var datM:DataLeave?
//     var arab:[String] = []
//     var arre:[String] = []
    @IBOutlet weak var selectTableview: UITableView!
    
        override func viewDidLoad() {

    super.viewDidLoad()

            
//        arra = ["abc","def","ghi","jkl"]
//        arab = ["abc","def","ghi","jkl"]
//        arre = ["abc","def","ghi","jkl"]
//
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
   
    func tableView(_ tableView: UITableView, numberOfSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataMode.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "textselected", for: indexPath)

        let subjectdata:UILabel = cell.viewWithTag(1) as! UILabel
        let bodydata:UILabel = cell.viewWithTag(2) as! UILabel
        let btnSelect:UIButton = cell.viewWithTag(3) as! UIButton
        btnSelect.addTarget(self, action: #selector(onClickSelectbtn(_:)), for: UIControl.Event.touchUpInside)
        let xyz = dataMode[indexPath.row]
         bodydata.text = xyz.body
        subjectdata.text = xyz.subject
        
        
//         let abc = DataLeave.shared
//        bodydata.text = abc.body
//        subjectdata.text = abc.subject
        
        return cell
    } 
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
        
    }
    
    @IBAction func onClickBackbtn(_ sender: Any) {
    self.popViewController()
    }
    
    @IBAction func onClickSelectbtn(_ sender:AnyObject)
    {
        
        let buttonPosition:CGPoint = sender.convert!(CGPoint.zero, to: self.selectTableview)
        let indexPath = self.selectTableview.indexPathForRow(at: buttonPosition)
        
        let edit = self.storyboard?.instantiateViewController(withIdentifier: "EditSendController") as! EditSendController
        
        let xyz = dataMode[(indexPath?.row)!]
        edit.textbody = xyz.body
        edit.textsub  = xyz.subject
        
        self.navigationController?.pushViewController(edit, animated: true)
        
    }
}
