

import UIKit

struct DataModel {
    let name : String
    var isExpandable : Bool
    init(isExpandable: Bool, name: String) {
        self.isExpandable = isExpandable
        self.name = name
    }
}
 var pationdat = [DataModel]()


 var pationId = 0

class PatianData: UIViewController, UITableViewDelegate, UITableViewDataSource, ExpandableHeaderViewDelegate, TableViewHistory{
    func OnClickCell(index: Int) {
        pationId = RevealID[index]
    }
    
   

    
    @IBAction func Back(_ sender: UIBarButtonItem) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "goToNextVC")
        vc?.modalPresentationStyle = .fullScreen
        self.present(vc!, animated: true)
        
    }
    
    @IBOutlet weak var LaName: UILabel!
    @IBOutlet weak var LaPhone: UILabel!
    
    @IBOutlet var TabelView: UITableView!
    var PatientID = [Int]()
    var RevealData = [String]()
    var Visit_StatusName = [String]()
    var RevealTotalPiad = [Int]()
    var RevealStatusint = [String]()
    var RevealID = [Int]()
    var PatientName = [String]()
    var PatientPhone = [String]()
    var PatientGUID = [String]()
    var IsOpen = [Bool]()
    var depend = false
    let loadingView = UIView()
    
    let spinner = UIActivityIndicatorView()
   
    @objc func handleExpand() {
        print("Hallo")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
    TabelView.tableFooterView = UIView()
    self.setLoadingScreen()
   downloadJsonWithURL()
    
    }
    func downloadJsonWithURL() {

        let urlString = "http://doctor.promit2030.com/api/Values/ApiRevealsHistory?userid=2&PatientGUID=\(myindex)"
  
        let url = NSURL(string: urlString)
        URLSession.shared.dataTask(with: (url as URL?)!, completionHandler: {(data, response, error) -> Void in
            
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                
                if let actorArray = jsonObj!.value(forKey: "Padata") as? NSArray {
                   
                    for actor in actorArray{
                        if let actorDict = actor as? NSDictionary {
                            if let Name = actorDict.value(forKey: "PatientName"){
                                self.PatientName.append(Name as! String)
                                
                            }
                            if let actorDict = actor as? NSDictionary {
                                if let Name = actorDict.value(forKey: "PatientPhone"){
                                    self.PatientPhone.append(Name as! String)
                                    
                                }
                                
                            }
                            
                        }
                       
                    }
                    
                }
                
                
                if let actorArray = jsonObj!.value(forKey: "dataddata") as? NSArray {
                   
                    for actor in actorArray{
                        if let actorDict = actor as? NSDictionary {
                            if let Name = actorDict.value(forKey: "Visit_StatusName"){
                                self.Visit_StatusName.append(Name as! String)
                               
                            }
                           
                            if let Name = actorDict.value(forKey: "IsOpen"){
                                self.IsOpen.append(Name as! Bool)
                                
                            }
                          
                            if let Name = actorDict.value(forKey: "RevealData"){
                                self.RevealData.append(Name as! String)
                            }
                            if let Name = actorDict.value(forKey: "RevealStatusint"){
                                self.RevealStatusint.append(Name as! String)
                            }
                            if let Name = actorDict.value(forKey: "RevealTotalPiad"){
                                self.RevealTotalPiad.append(Name as! Int)
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
                    self.TabelView.reloadData()
                    self.RemoveLoadingScreen()
                })
            }
        }).resume()
    }

 

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     return 1
      
    }
    func numberOfSections(in tableView: UITableView) -> Int {
       
        return Visit_StatusName.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
  
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let header = ExpandableHeaderView()
        
      pationdat = [DataModel(isExpandable: true, name: "\(Visit_StatusName[section])        \(RevealData[section])" )]
        
        let title = "\(Visit_StatusName[section])        \(RevealData[section])"
      header.customInit(title: "\(title)", section: section, delegate: self)
        return header
    }
 
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        LaPhone.text = "\(PatientPhone[indexPath.startIndex])"
        LaName.text = "\(PatientName[indexPath.startIndex])"
      
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell") as! CellHistory
        
        
       cell.CellDeleget = self
        cell.index = indexPath
       
        
        
        
        cell.LaStutas.text = "\(RevealStatusint[indexPath.section])"
        cell.LaAmount.text = "\(RevealTotalPiad[indexPath.section])"
       
        
        return cell
    
    }
  
    
    func toggleSection(header: ExpandableHeaderView, section: Int) {
       
       IsOpen[section] = !IsOpen[section]
        TabelView.beginUpdates()
        for i in 0 ..< RevealStatusint.count{
            TabelView.reloadRows(at: [IndexPath(row: i-1, section: section)], with: .automatic)
        }
        TabelView.endUpdates()
    }
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
     if (IsOpen[indexPath.section]){
     return 186
        
     }else{
     return 0
     }
     }
    
    
    private func setLoadingScreen(){
        
        self.spinner.style = UIActivityIndicatorView.Style.white
        spinner.center = self.TabelView.center
        self.spinner.startAnimating()
        loadingView.addSubview(self.spinner)
        self.TabelView.addSubview(loadingView)
        
        
        
    }
    
    private func RemoveLoadingScreen() {
        spinner.isHidden = true
        self.spinner.stopAnimating()
    }
    

    @IBAction func DetelsCome(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetelsCome")
        self.present(vc!, animated: true)
    }
    
}
