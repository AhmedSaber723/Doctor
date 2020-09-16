
import UIKit

class ViewController2: UIViewController,UITextFieldDelegate {
    
    @IBOutlet var LaNumber: UITextField!
    @IBOutlet var LaName: UITextField!
    @IBOutlet var LaPassword: UITextField!
    @IBOutlet var LaRePassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let mycolor: UIColor = UIColor.white
        LaNumber.layer.borderWidth = 0.5
        LaNumber.layer.borderColor = mycolor.cgColor
        LaName.layer.borderWidth = 0.5
        LaName.layer.borderColor = mycolor.cgColor
        LaPassword.layer.borderWidth = 0.5
        LaPassword.layer.borderColor = mycolor.cgColor
        LaRePassword.layer.borderWidth = 0.5
        LaRePassword.layer.borderColor = mycolor.cgColor
        
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "Backgro")?.draw(in: self.view.bounds)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)
      
       
    }
    
   
    
    @IBAction func BuRegister(_ sender: Any) {
        let UserName = LaName.text!
        let UserNumber = LaNumber.text!
        let UserPassword = LaPassword.text!
        let UserRePasword = LaRePassword.text!
        
        if UserPassword != UserRePasword{
            return displayAlertMassage(UserMassage: "Password do not match")
        }
        
        if (UserName.isEmpty || UserNumber.isEmpty || UserPassword.isEmpty || UserRePasword.isEmpty){
            return displayAlertMassage(UserMassage: "All fields are required")
        }
        
        
        // Data user
    
    UserDefaults.standard.set(UserName, forKey:"UserName")
    UserDefaults.standard.set(UserNumber, forKey:"UserNumber")
    UserDefaults.standard.set(UserPassword, forKey:"UserPassword")
    UserDefaults.standard.synchronize()
    
        
        
        // display
        
        let alert = UIAlertController(title: "Info", message:"Registration is suncessful. Thank you!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ok", style: .default){ action in
            
            self.dismiss(animated: true, completion: nil)}
        
        alert.addAction(okAction)
        self.present( alert, animated: true, completion: nil)
        
        
        
    }
    
    func displayAlertMassage(UserMassage:String) {
        
        let aletcon = UIAlertController(title: "Alert", message:UserMassage, preferredStyle: .alert)
        aletcon.addAction(UIAlertAction(title: NSLocalizedString("ok", comment: "Defult action"), style: .default, handler: {_ in NSLog("The \"ok\" alert test")}))
        
        self.present(aletcon, animated: true, completion: nil)
        
    }
    
    func textFieldShouldReturn( _ textField: UITextField) -> Bool {
        
        if textField == LaName {
            
           LaNumber.becomeFirstResponder()
            
        }else if  textField == LaNumber {
            
            LaPassword.becomeFirstResponder()
        }else if textField == LaPassword {
            
            LaRePassword.becomeFirstResponder()
            
        }else{
            
            BuRegister(becomeFirstResponder())
            //LaRePassword.resignFirstResponder()
        }
        
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           self.view.endEditing(true)
       }
      
    
    @IBAction func LetMeLogin(_ sender: Any) {
      
        self.dismiss(animated: true, completion: nil)
    }
    
    
}


