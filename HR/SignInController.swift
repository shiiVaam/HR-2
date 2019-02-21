

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class SignInController: UIViewController,UITextFieldDelegate{
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var gradSign: UIView!
    @IBOutlet weak var passwordView: UIView!
    var ref:DatabaseReference?
    var isSignIn:Bool = true

    var xyz : String = ""
    var def : String = ""
  
    
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var passWord: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        gradient()
        
        emailAddress.delegate = self
        passWord.delegate = self
       
//        emailAddress.layer.borderColor = UIColor.black.cgColor
//        emailAddress.layer.borderWidth = 0.3
//
//        passWord.layer.borderColor = UIColor.black.cgColor
//        passWord.layer.borderWidth = 0.3
        
        loadDefaults()

        ref = Database.database().reference().child("user")
        
        let userM = User.shared
        userM.emailAdd = emailAddress.text!
        
        emailAddress.attributedPlaceholder = NSAttributedString(string: "Email Address",
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        passWord.attributedPlaceholder = NSAttributedString(string: "Password",
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
   
        
        
        
//       xyz = emailAddress.text!
       borderColor()
        
    }
    
    func borderColor(){
        
        self.emailView.layer.cornerRadius = 15
        self.emailView.layer.borderWidth = 1
        self.emailView.layer.borderColor = UIColor.white.cgColor
        
        self.passwordView.layer.cornerRadius = 15
        self.passwordView.layer.borderWidth = 1
        self.passwordView.layer.borderColor = UIColor.white.cgColor
        
    }
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func loadDefaults() {
        
        do {
        let defaults = UserDefaults.standard
        emailAddress.text = defaults.object(forKey: "emailAddress") as? String
        passWord.text = defaults.object(forKey: "password") as? String
         
        }
    }
        
    
    
//    func textFieldShouldReturn(emailAddress: UITextField) -> Bool {
//        self.view.endEditing(true)
//        return true
//    }
//    func textFieldShouldReturn(passWord: UITextField) -> Bool {
//        self.view.endEditing(true)
//        return true
//    }
    
   
    @IBAction func onClickRem(_ sender: UIButton) {
        sender.isSelected =  !sender.isSelected

        if (sender.isSelected){
            let defaults = UserDefaults.standard
            
            defaults.set(emailAddress.text, forKey: "emailAddress")
            defaults.set(passWord.text, forKey: "password")
            defaults.synchronize()
          
        }
    
//        if(emailAddress.text == ""){
//
//        }
//        else {
//            emailAddress.text = ""
//           passWord.text = ""
//
//        }
  
    }
    @IBAction func onClicklogin(_ sender: Any) {
        
      
//       if (emailAddress.text?.isValidEmail(email: emailAddress.text!)) == false || (passWord.text?.isValidPassword(password: passWord.text!)) == false
//        {
//            let alert = UIAlertController(title: "Error", message: "Email id or password is not correct.Please try again", preferredStyle: UIAlertControllerStyle.alert)
//
//            alert.addAction(UIAlertAction.init(title: "dismiss", style: UIAlertActionStyle.default, handler: { (action) in
//                print("asdfmaklsdjfaklsjdfsa")
//            }))
//
//
//            self.present(alert, animated: true, completion: nil)
//
//        } else
        
        if (emailAddress.text?.isValidEmail(email: emailAddress.text!)) == false  {
            let alertemail = UIAlertController(title: "Error", message: "Email id is not correct.Please enter again", preferredStyle: UIAlertController.Style.alert)
            
            alertemail.addAction(UIAlertAction.init(title: "dismiss", style: UIAlertAction.Style.default, handler: { (action) in
                print("asdfmaklsdddjfaklsjdfsarr")
            }))
        self.present(alertemail, animated: true, completion: nil)
            
        }else if
             (passWord.text?.isValidPassword(password: passWord.text!)) == false {
                let alertpassword = UIAlertController(title: "Error", message: "password is not correct.Please enter again", preferredStyle: UIAlertController.Style.alert)
                
                alertpassword.addAction(UIAlertAction.init(title: "dismiss", style: UIAlertAction.Style.default, handler: { (action) in
                    print("asdfmaklsdddjfaklsjdfsatt")
                }))
        self.present(alertpassword, animated: true, completion: nil)}
        else  {
            
        Auth.auth().signIn(withEmail: self.emailAddress.text!, password: self.passWord.text!)
            { (user, error) in
                if (error == nil)
            {
                self.ref?.child((Auth.auth().currentUser?.uid)!).observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
                 
                    print("abcd")
  
                    let leave = self.storyboard?.instantiateViewController(withIdentifier: "LeaveController") as! LeaveController
                    
                    self.navigationController?.pushViewController(leave, animated: true)
                    
            })
              
                    }else{
                        let alert = UIAlertController(title:"User not found", message: "please Sign up", preferredStyle: UIAlertController.Style.alert)
                            
                        alert.addAction(UIAlertAction.init(title: "dismiss", style: UIAlertAction.Style.default, handler: { (action) in
                            
                        }))
                    self.present(alert, animated: true,completion: nil)
                    }

                    }
           
            }
//            else{
//
//         let alert = UIAlertController(title: "USER NOT FOUND", message: "please signup ", preferredStyle: UIAlertControllerStyle.alert)
//
//                alert.addAction(UIAlertAction.init(title: "dismiss", style: UIAlertActionStyle.default, handler: { (action) in
//
//                }))
//                self.present(alert,animated: true ,completion: nil)
//            }
//        }
    
    }
    
    @IBAction func onClickcreateAccnt(_ sender: Any) {
        
        let _signup = self.storyboard?.instantiateViewController(withIdentifier: "SignupController") as! SignupController
        
        self.navigationController?.pushViewController(_signup, animated: true)
        }
    
    @IBAction func onClickFogt(_ sender: Any) {
        let forgot = self.storyboard?.instantiateViewController(withIdentifier: "ForgotController") as! ForgotController
        
        self.navigationController?.pushViewController(forgot, animated: true)
        
        
    }
    
    func gradient(){
        
        let layer = CAGradientLayer()
        layer.frame = gradSign.bounds
        layer.colors = [UIColor.red.cgColor,UIColor.blue.cgColor]
        layer.startPoint = CGPoint(x:0,y:0)
        layer.endPoint = CGPoint (x:1,y:1)
        gradSign.layer.addSublayer(layer)
    }
    
    
 
    

}

extension String
{
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: email)
        return result
    }
    
        
    func isValidPassword(password: String) -> Bool {
        let passwordRegEx = "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{6,16}"
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        let result = passwordTest.evaluate(with: password)
        return result
     }
    
    
}





