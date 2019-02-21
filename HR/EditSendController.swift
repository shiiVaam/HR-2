//
//  Edit&SendController.swift
//  HR
//
//  Created by sandeep@nettechnocrats on 05/10/18.
//  Copyright © 2018 sandeep@nettechnocrats. All rights reserved.
//

import UIKit
import MessageUI

class EditSendController: Global ,MFMailComposeViewControllerDelegate{
    
    var textsub:String = ""
    var textbody:String = ""

    @IBOutlet weak var emailReciever: UIView!
    @IBOutlet weak var mailTxt: UITextView!
    @IBOutlet weak var mailTxtbody: UITextView!
    
    @IBOutlet weak var sendEmailtxtfield: UITextField!
    @IBOutlet weak var mainView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mailTxt.text = textsub
        mailTxtbody.text = textbody
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onClickConfirm(_ sender: UIButton) {
        
        
//        let abc = self.storyboard?.instantiateViewController(withIdentifier: "SignInController") as! SignInController
          let xy = User.shared
//        abc.xyz = xy.emailAdd
        
    
        let mailVC = MFMailComposeViewController()
        mailVC.mailComposeDelegate = self as MFMailComposeViewControllerDelegate
        mailVC.setToRecipients([])
        mailVC.setPreferredSendingEmailAddress(xy.emailAdd)
        mailVC.setSubject(textsub)
        mailVC.setMessageBody(textbody, isHTML: true)
        
        present(mailVC, animated: true, completion: nil)
        
       
    }
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    @IBAction func onClickBackBtn(_ sender: Any) {
        self.popViewController()
    }
    

    
    
}
    
   


