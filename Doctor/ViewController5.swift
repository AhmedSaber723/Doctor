
import UIKit

@IBDesignable extension UIButton {
 
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
   
    
    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
   
}



struct Courses: Decodable {
    let ResultList:[Course]
}

struct Course: Decodable {
    
   let Visit_StatusName: String
    let PatientName: String
    let PatientPhone: String
    let RevealData: String
    let StillAmount: Int
    let RevealStatusString: String
    let RevealID: Int
 
}
struct home {
    
   let Visit_StatusName: String?
    let PatientName: String?
    let PatientPhone: String?
    let RevealData: String?
    let StillAmount: Int?
    let RevealStatusString: String?
    let RevealID: Int?
    let PatientGUID: String?
    init(Visit_StatusName: String,PatientName: String ,PatientPhone: String,RevealData: String,StillAmount: Int,RevealStatusString: String,RevealID: Int,PatientGUID: String ) {
        self.Visit_StatusName = Visit_StatusName
        self.PatientName = PatientName
        self.PatientPhone = PatientPhone
        self.RevealData = RevealData
        self.StillAmount = StillAmount
        self.RevealStatusString = RevealStatusString
        self.RevealID = RevealID
        self.PatientGUID = PatientGUID
    }
}


var myindex = ""

class ViewController5: UITableViewController,TableViewHome {
  
 
    func OnClickCell(index: Int) {
      //  myindex = PatientGUID[index]
        myindex = homePage[index].PatientGUID!
        print(myindex)
    }
   
    
    @IBAction func SpeakUs(_ sender: UIBarButtonItem) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetelsCome")
         vc?.modalPresentationStyle = .fullScreen
        self.present(vc!, animated: true)
        
    }
    @IBAction func CallUs(_ sender: UIBarButtonItem) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Testing")
         vc?.modalPresentationStyle = .fullScreen
        self.present(vc!, animated: true)
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    var Visit_StatusName = [String]()
    var PatientName = [String]()
    var PatientPhone = [String]()
    var RevealData = [String]()
    var StillAmount = [Int]()
    var RevealStatusString = [String]()
    var RevealID = [Int]()
    var PatientGUID = [String]()
    
   let loadingView = UIView()
    
    
    
    let spinner = UIActivityIndicatorView()
    
    
    @IBOutlet var Tabelview: UITableView!

    
    var actor = Array<Courses>()
    var homePage = Array<home>()
    final let urlString = "http://doctor.promit2030.com/api/Values/ApiGetReveals?userid=2"
  //  http://doctor.promit2030.com/api/Values/ApiLogin
   // http://doctor.promit2030.com/api/Values/CheckToken
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    self.setLoadingScreen()
        
      //  downloadJsonWithURL()
        getData()
  
    }
    
    func getData () {
        
        let path = Bundle.main.path(forResource: "PatientID", ofType: "plist")!
        let url = URL(fileURLWithPath: path)
        let data = try! Data(contentsOf: url)
        let plist = try! PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil)
        let dicAray = plist as! [[String:Any]]
        for dic in dicAray {
            
            homePage.append(home(Visit_StatusName: dic["Visit_StatusName"] as! String, PatientName: dic["PatientName"]as! String, PatientPhone: dic["PatientPhone"]as! String, RevealData: dic["RevealData"]as! String, StillAmount: dic["StillAmount"]as! Int, RevealStatusString: dic["RevealStatusString"]as! String, RevealID: dic["RevealID"]as! Int, PatientGUID: dic["PatientGUID"]as! String))
            
        }
        
        OperationQueue.main.addOperation({
                          self.tableView.reloadData()
                          self.RemoveLoadingScreen()
                      })
        
        
    }
    
    func downloadJsonWithURL() {
        let url = NSURL(string: urlString)
        URLSession.shared.dataTask(with: (url as URL?)!, completionHandler: {(data, response, error) -> Void in
            
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
               
                
                if let actorArray = jsonObj!.value(forKey: "ResultList") as? NSArray {
                    for actor in actorArray{
                        if let actorDict = actor as? NSDictionary {
                            if let Name = actorDict.value(forKey: "Visit_StatusName"){
                                self.Visit_StatusName.append(Name as! String)
                            }
                            if let Name = actorDict.value(forKey: "PatientName"){
                                self.PatientName.append(Name as! String)
                                
                            }
                            if let Name = actorDict.value(forKey: "PatientPhone"){
                                self.PatientPhone.append(Name as! String)
                            }
                            if let Name = actorDict.value(forKey: "RevealDataStr"){
                                self.RevealData.append(Name as! String)
                            }
                            if let Name = actorDict.value(forKey: "RevealStatusString"){
                                self.RevealStatusString.append(Name as! String)
                            }
                            if let Name = actorDict.value(forKey: "StillAmount"){
                                self.StillAmount.append(Name as! Int)
                            }
                            if let Name = actorDict.value(forKey: "RevealID"){
                                self.RevealID.append(Name as! Int)
                            }
                            if let Name = actorDict.value(forKey: "PatientGUID"){
                                self.PatientGUID.append(Name as! String)
                            }
                            
                        }
                    }
                }
                
                OperationQueue.main.addOperation({
                    self.tableView.reloadData()
                    self.RemoveLoadingScreen()
                })
            }
        }).resume()
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // return PatientName.count
        return homePage.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell:Cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! Cell 
//        cell.PatianName.text = "\(PatientName[indexPath.row])"
//        cell.StillAmount.text = "\(StillAmount[indexPath.row])"
//        cell.PatianNumber.text = "\(PatientPhone[indexPath.row])"
//        cell.ReStutas.text = "\(RevealStatusString[indexPath.row])"
//        cell.PatianID.text = "\(RevealID[indexPath.row])"
//        cell.Data.text = "\(RevealData[indexPath.row])"
//        cell.Stutas.text = "\(Visit_StatusName[indexPath.row])"
//        cell.CellDeleget = self
//        cell.index = indexPath
//
//        if RevealStatusString[indexPath.row] == "كشف جديد"{
//            cell.ReStutas.backgroundColor = hexStringToUIColor(hex: "ffcc33")
//            cell.BackView.backgroundColor = hexStringToUIColor(hex: "ffcc33")
//        }
//        else if RevealStatusString[indexPath.row] == "قيد الكشف"{
//            cell.ReStutas.backgroundColor = hexStringToUIColor(hex: "336633")
//            cell.BackView.backgroundColor = hexStringToUIColor(hex: "336633")
//        }
//        else if RevealStatusString[indexPath.row] == "موجل"{
//            cell.ReStutas.backgroundColor = hexStringToUIColor(hex: "cc3333")
//            cell.BackView.backgroundColor = hexStringToUIColor(hex: "cc3333")
//        }
//        return cell
        
        cell.PatianName.text = "\(homePage[indexPath.row].PatientName ?? "")"
        cell.StillAmount.text = "\(homePage[indexPath.row].StillAmount!)"
        cell.PatianNumber.text = "\(homePage[indexPath.row].PatientPhone ?? "")"
        cell.ReStutas.text = "\(homePage[indexPath.row].Visit_StatusName ?? "")"
        cell.PatianID.text = "\(homePage[indexPath.row].RevealID! )"
        cell.Data.text = "\(homePage[indexPath.row].RevealData ?? "")"
        cell.Stutas.text = "\(homePage[indexPath.row].RevealStatusString ?? "")"
               cell.CellDeleget = self
               cell.index = indexPath
           
               if homePage[indexPath.row].Visit_StatusName == "كشف جديد"{
                   cell.ReStutas.backgroundColor = hexStringToUIColor(hex: "ffcc33")
                   cell.BackView.backgroundColor = hexStringToUIColor(hex: "ffcc33")
               }
               else if homePage[indexPath.row].Visit_StatusName == "قيد  الكشف "{
                   cell.ReStutas.backgroundColor = hexStringToUIColor(hex: "336633")
                   cell.BackView.backgroundColor = hexStringToUIColor(hex: "336633")
               }
               else if homePage[indexPath.row].Visit_StatusName == "موجل"{
                   cell.ReStutas.backgroundColor = hexStringToUIColor(hex: "cc3333")
                   cell.BackView.backgroundColor = hexStringToUIColor(hex: "cc3333")
               }
               return cell
        
    }
    
    
    private func setLoadingScreen(){
        
        self.spinner.style = UIActivityIndicatorView.Style.white
        spinner.center = self.Tabelview.center
        self.spinner.startAnimating()
        loadingView.addSubview(self.spinner)
        self.Tabelview.addSubview(loadingView)
        
        
        
    }
    
    private func RemoveLoadingScreen() {
        spinner.isHidden = true
        self.spinner.stopAnimating()
    }
    
   
        
    
        
        @IBAction func PatianDetels(_ sender: Any) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "Testing")
             vc?.modalPresentationStyle = .fullScreen
            self.present(vc!, animated: true)
            
                }
    
    @IBAction func PatianData(_ sender: Any) {
       let vc2 = self.storyboard?.instantiateViewController(withIdentifier: "Testing")
         vc2?.modalPresentationStyle = .fullScreen
        self.present(vc2!, animated: true)
        
    }
    
    @IBAction func CallPatian(_ sender: Any) {
    
   
        let vc2 = self.storyboard?.instantiateViewController(withIdentifier: "Testing")
         vc2?.modalPresentationStyle = .fullScreen
        self.present(vc2!, animated: true)
    
    
    
    }
    

}
