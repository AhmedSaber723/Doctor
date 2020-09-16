

import Foundation
import UIKit


class WelcomeViewController: UITabBarController {
    
 
    @IBOutlet var TableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

}
/*let button = UIButton(type: .custom)
let image = UIImage(named: "User")?.withRenderingMode(.alwaysTemplate)
button.setImage(image, for: .normal)
button.tintColor = UIColor.red
*/
