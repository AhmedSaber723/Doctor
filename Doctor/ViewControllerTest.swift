
import UIKit

struct DataModel1 {
    let name : String
    var pationData: String
    var isExpandable : Bool
    init(isExpandable: Bool, name: String, pationData: String) {
        self.isExpandable = isExpandable
        self.name = name
        self.pationData = pationData
    }
}


class ViewControllerTest: UIViewController, UITableViewDelegate, UITableViewDataSource, ExpandableHeaderViewDelegate {
    
    var Sicktype = [String]()
    var Description = [String]()
    var Treat = [String]()
    var Analises = [String]()
    let loadingView = UIView()
    let spinner = UIActivityIndicatorView()
    
    
    var data1 = [ DataModel1(isExpandable: false, name: "الحاله المرضيه", pationData: ""), DataModel1(isExpandable: false, name: "التشخيص", pationData: ""), DataModel1(isExpandable: false, name: "العلاج", pationData: ""),DataModel1(isExpandable: false, name: "التحاليل المطلوبه", pationData: "")]
    

    @IBAction func Back(_ sender: UIBarButtonItem) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Testing")
        vc?.modalPresentationStyle = .fullScreen
        self.present(vc!, animated: true)
    }
    
    @IBOutlet weak var TabelView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        TabelView.tableFooterView = UIView()
        downloadJsonWithURL()
      self.setLoadingScreen()
        
    }
   
        
    
    func downloadJsonWithURL() {
      
        let urlString = "http://doctor.promit2030.com/api/Values/ApiRevealEnd?userid=2&RevealID=2"
        let url = NSURL(string: urlString)
        URLSession.shared.dataTask(with: (url as URL?)!, completionHandler: {(data, response, error) -> Void in
            
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                
              
                
                
                if let actorArray = jsonObj!.value(forKey: "EndReveal") as? NSArray
                {
                    for actor in actorArray{
                        if let actorDict = actor as? NSDictionary {
                            if let Name = actorDict.value(forKey: "Sicktype"){
                                self.Sicktype.append(Name as! String)
                                
                            }
                            
                            if let Name = actorDict.value(forKey: "Description"){
                                self.Description.append(Name as! String)
                                
                            }
                            if let Name = actorDict.value(forKey: "Treat"){
                                self.Treat.append(Name as! String)
                                
                            }
                         
                            if let Name = actorDict.value(forKey: "Analises"){
                                self.Analises.append(Name as! String)
                               
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
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ExpandableHeaderView()
        header.customInit(title: data1[section].name, section: section, delegate: self)
        
        return header
    }
  func numberOfSections(in tableView: UITableView) -> Int {
  
        return 4
    }
     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
     func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return Sicktype.count
        
        
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var StringData = ["\(Sicktype[indexPath.startIndex])","\(Description[indexPath.startIndex])","\(Treat[indexPath.startIndex])","\(Analises[indexPath.startIndex])"]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellData") as! CellHistory
       
       
        cell.textLabel?.text = StringData[indexPath.section]
        
        return cell
    }
    func toggleSection(header: ExpandableHeaderView, section: Int) {
        data1[section].isExpandable = !data1[section].isExpandable
        TabelView.beginUpdates()
        
        for i in 0 ..< Treat.count{
           
            TabelView.reloadRows(at: [IndexPath(row: i, section: section)], with: .automatic)
        }
        TabelView.endUpdates()
    }
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (data1[indexPath.section].isExpandable){
            return 44
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
}
