//
//  ForgotController.swift
//  HR
//
//  Created by sandeep@nettechnocrats on 04/10/18.
//  Copyright © 2018 sandeep@nettechnocrats. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class ForgotController: Global,UITextFieldDelegate {
    @IBOutlet weak var gradView: UIView!
    
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailADDreset: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
       gradient()
        
        emailADDreset.attributedPlaceholder = NSAttributedString(string: "Email Address",
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
                borderColor()
        
    }
    func borderColor(){
   
        
        self.emailView.layer.cornerRadius = 15
        self.emailView.layer.borderWidth = 1
        self.emailView.layer.borderColor = UIColor.white.cgColor
       
    }
    @IBAction func onClickSubmit(_ sender: Any) {
        Auth.auth().sendPasswordReset(withEmail: emailADDreset.text!) { (error) in
            if(error != nil){
                let alert = UIAlertController(title: "error", message: "resend verification mail to email", preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction.init(title: "dismiss", style: UIAlertAction.Style.default, handler: { (alert) in
                    
                }))
                self.present(alert,animated: true,completion: nil)
            }else{
                let alert = UIAlertController(title: "email verified", message: "verification is successfully sent to mail id", preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction.init(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
                    
                }))
                self.present(alert,animated: true,completion: nil)
            }
        }
        
    }
    @IBAction func onClickBackBtn(_ sender: Any) {
    self.popViewController()
    }
    
    func gradient(){
        
        let layer = CAGradientLayer()
        layer.frame = self.gradView.bounds
        layer.colors = [UIColor.red.cgColor,UIColor.blue.cgColor]
        layer.startPoint = CGPoint(x:0,y:0)
        layer.endPoint = CGPoint (x:1,y:1)
        gradView.layer.addSublayer(layer)
    }
    
}
