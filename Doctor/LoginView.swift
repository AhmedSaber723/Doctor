

import UIKit




class ViewController: UIViewController,UITextFieldDelegate {
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mycolor: UIColor = UIColor.white
        UserNumber.layer.borderWidth = 0.5
        UserNumber.layer.borderColor = mycolor.cgColor
        UserPassword.layer.borderWidth = 0.5
        UserPassword.layer.borderColor = mycolor.cgColor
     
UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "Backgro")?.draw(in: self.view.bounds)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)
    }
    
   override func viewDidAppear(_ animated: Bool) {
    let user = UserDefaults.standard.bool(forKey: "isUserLoggen")
        if user {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "goToNextVC")
            vc?.modalPresentationStyle = .fullScreen
            self.present(vc!, animated: false)
           
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == UserNumber {
            UserPassword.becomeFirstResponder()
        }else{
            BuLogIn(becomeFirstResponder())
          // UserPassword.resignFirstResponder()
        }
        return true
    }
    

    @IBOutlet var UserPassword: UITextField!
    @IBOutlet var UserNumber: UITextField!
    
    @IBAction func BuLogIn(_ sender: Any) {
        let number = UserNumber.text!
        let password = UserPassword.text!
        let numberStored =  UserDefaults.standard.string(forKey: "UserNumber")
        let passwordStored = UserDefaults.standard.string(forKey: "UserPassword")
       // let nameStored = UserDefaults.standard.string(forKey: "UserName")

        if number == numberStored && password == passwordStored {
            // login sucecful
            UserDefaults.standard.set(true, forKey: "isUserLoggen")
            UserDefaults.standard.synchronize()
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "goToNextVC")
            vc?.modalPresentationStyle = .fullScreen
            self.present(vc!, animated: true,completion: nil)
            
            
        }
        
         if number != numberStored {
                display(massage: "Incorrect Number")
         
            }
        if   password != passwordStored{
                           
               display(massage: "Incorrect Password")
                           
                            
            }
         
       
        
        
       
    }
    
    func display (massage:String){
        let aletcon = UIAlertController(title: "Alert", message:massage, preferredStyle: .alert)
        aletcon.addAction(UIAlertAction(title: NSLocalizedString("ok", comment: "Defult action"), style: .default, handler: {_ in NSLog("The \"ok\" alert test")}))
        
        self.present(aletcon, animated: true, completion: nil)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
    
    
    
    /*
     let alert = UIAlertController(title: "Alert", message:"login is suncessful. Thank you!", preferredStyle: .alert)
     let okAction = UIAlertAction(title: "ok", style: .default){ action in
     
     self.dismiss(animated: true, completion: nil)}
     
     alert.addAction(okAction)
     self.present( alert, animated: true, completion: nil)
     */
    
}





