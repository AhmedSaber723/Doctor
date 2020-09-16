

import UIKit

struct label {
    
   let  name:String
    let number: Int
    let password: Any
}

class _ViewController: UIViewController {
    
   

    @IBOutlet var LaName: UILabel!
    
    @IBOutlet var LaPassword: UILabel!
    @IBOutlet var Lanumber: UILabel!
   
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LaName.text = "Name:  \(UserDefaults.standard.value(forKey: "UserName") as! String)"
        LaPassword.text = "Password:  \(UserDefaults.standard.value(forKey: "UserPassword") as! String)"
                
        Lanumber.text = "Number:  \(UserDefaults.standard.value(forKey: "UserNumber") as! String)"
        
    }

    @IBAction func BuLogout(_ sender: Any) {
        
        UserDefaults.standard.set(false, forKey: "isUserLoggen")
        UserDefaults.standard.synchronize()
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
}
