//
//  SignupController.swift
//  HR
//
//  Created by sandeep@nettechnocrats on 04/10/18.
//  Copyright © 2018 sandeep@nettechnocrats. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class SignupController: UIViewController ,UITextFieldDelegate{
    @IBOutlet weak var gradSignUp: UIView!
    var ismailError :Bool = false
    var ispassError :Bool = false
    var isrepassError :Bool = false
    var isNil :Bool = false
    var ref:DatabaseReference?
    var key:String = ""
    
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var confirmPassView: UIView!
    
    @IBOutlet weak var nameSignup: UITextField!
    @IBOutlet weak var emailSignup: UITextField!
    @IBOutlet weak var passwordSignup: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gradient()
        nameSignup.delegate = self
        emailSignup.delegate = self
        passwordSignup.delegate = self
        confirmPassword.delegate  = self
//        nameSignup.layer.borderColor = UIColor.black.cgColor
//        nameSignup.layer.borderWidth = 0.3
//        emailSignup.layer.borderColor = UIColor.black.cgColor
//        emailSignup.layer.borderWidth = 0.3
//        passwordSignup.layer.borderColor = UIColor.black.cgColor
//        passwordSignup.layer.borderWidth = 0.3
//        confirmPassword.layer.borderColor = UIColor.black.cgColor
//        confirmPassword.layer.borderWidth = 0.3
        
        
        
        ref = Database.database().reference().child("user")
        
        nameSignup.attributedPlaceholder = NSAttributedString(string: "Name",
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        emailSignup.attributedPlaceholder = NSAttributedString(string: "Email Address",
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        
        passwordSignup.attributedPlaceholder = NSAttributedString(string: "Password",
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
       confirmPassword.attributedPlaceholder = NSAttributedString(string: "Confirm Password",
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        borderColor()
        
    }
    
    func borderColor(){
        
        self.nameView.layer.cornerRadius = 15
        self.nameView.layer.borderWidth = 1
        self.nameView.layer.borderColor = UIColor.white.cgColor
        
        self.emailView.layer.cornerRadius = 15
        self.emailView.layer.borderWidth = 1
        self.emailView.layer.borderColor = UIColor.white.cgColor
        
        self.passwordView.layer.cornerRadius = 15
        self.passwordView.layer.borderWidth = 1
        self.passwordView.layer.borderColor = UIColor.white.cgColor
        
        self.confirmPassView.layer.cornerRadius = 15
        self.confirmPassView.layer.borderWidth = 1
        self.confirmPassView.layer.borderColor = UIColor.white.cgColor
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
  
        switch (textField) {
            
        case emailSignup:
         if( emailSignup.text?.isValidEmail(email: emailSignup.text!)) == false{
                emailSignup.layer.borderColor = UIColor.red.cgColor
                emailSignup.layer.borderWidth = 0.5
            ismailError = true
         }else{
           
                emailSignup.layer.borderColor = UIColor.black.cgColor
                emailSignup.layer.borderWidth = 0.3
                ismailError = false
         }
            break
            
        case passwordSignup:
            if( passwordSignup.text?.isValidPassword(password: passwordSignup.text!)) == false
            {
                passwordSignup.layer.borderColor = UIColor.red.cgColor
                passwordSignup.layer.borderWidth = 0.5
                ispassError = true
            }else
            {
               
                passwordSignup.layer.borderColor = UIColor.black.cgColor
                passwordSignup.layer.borderWidth = 0.3
                 ispassError = false
                
            }
            break
            
        case confirmPassword:
            if (passwordSignup.text != confirmPassword.text){
                confirmPassword.layer.borderColor = UIColor.red.cgColor
                isrepassError = true
            }else{
              
                confirmPassword.layer.borderColor = UIColor.black.cgColor
                confirmPassword.layer.borderWidth = 0.3
                  isrepassError = false
            }
            break
 
         default:
            break
            
        }

    }
    func nilField (){
        if( ((emailSignup.text)?.isEmpty)! || ((passwordSignup.text)?.isEmpty)! || ((nameSignup.text)?.isEmpty)! || ((confirmPassword.text)?.isEmpty)! ){
             isNil = true
    }
    else{
             isNil = false
        }
    }
    
    @IBAction func onClickSignup(_ sender: Any) {
        
        if(ismailError || ispassError || isrepassError || (nameSignup.text?.isEmpty)! ){
            let alert = UIAlertController(title: "Error", message: "please enter again ", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction.init(title: "dismiss", style: UIAlertAction.Style.default, handler: { (action) in
                print("asdfmaklsdddjfaklsjdfsatt")
            }))
            
            self.present(alert, animated: true, completion: nil)
            
        }else if( isNil){
            
            let alert = UIAlertController(title: "Empty Field", message: "please enter again", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction.init(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
                
                 print("asdfmaklsdddjfaklsjdfsats")
            }))
            self.present(alert, animated: true, completion: nil)
             nilField()
        }else{
            
           
            Auth.auth().createUser(withEmail: emailSignup.text!, password:passwordSignup.text!) { (user, error) in
                self.key = (Auth.auth().currentUser?.uid)!
           
                self.addUser()
                
                let alert = UIAlertController(title: "success", message: "please wait", preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction.init(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
                    
                    let xc = self.storyboard?.instantiateViewController(withIdentifier: "LeaveController")as! LeaveController
                    
                    self.navigationController?.pushViewController(xc, animated: true)
                    
                }))
                self.present(alert, animated: true, completion: nil)
                
            }
          

//            let user = User.shared
////            user.username = nameSignup.text!
////            user.password = passwordSignup.text!
////            user.emailAddress = emailSignup.text!
//            ref?.child("user").childByAutoId().setValue(user)
//
        }
            
 
        
     }
    func addUser(){
       
        let user = ["Uid":key,
                      "username": nameSignup.text! as String,
                      "emailAdd": emailSignup.text! as String,
                      "password": passwordSignup.text! as String
        ]
        
        //adding the artist inside the generated unique key
        ref?.child(key).setValue(user)
    }
    func gradient(){
        
        let layer = CAGradientLayer()
        layer.frame = gradSignUp.bounds
        layer.colors = [UIColor.red.cgColor,UIColor.blue.cgColor]
        layer.startPoint = CGPoint(x:0,y:0)
        layer.endPoint = CGPoint (x:1,y:1)
        gradSignUp.layer.addSublayer(layer)
    }
    
    
    @IBAction func onClickLoginBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
