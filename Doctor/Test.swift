
import UIKit

struct Course2 {
    
    let ProvincesID: Any
    let ProvincesName: Any
    let ProvincesNameCustom: Int?
    
    init(ProvincesID: Any, ProvincesName: Any, ProvincesNameCustom: Int? ) {
        
        self.ProvincesID = ProvincesID
        self.ProvincesName = ProvincesName
        self.ProvincesNameCustom = ProvincesNameCustom
    }
    
}

class Test: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    
    let loadingView = UIView()
    
    
    @IBOutlet var Loading: UIActivityIndicatorView!
    
    
    
    @IBOutlet var Tabelview: UITableView!
    

    
    var actors = Array <Course2>()
    
    final  let jsonUrlString = URL(string:"http://smusers.promit2030.com/Service1.svc/GetProvincesReg")
    //"http://smusers.promit2030.com/Service1.svc/GetProvincesReg"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setLoadingScreen()
        
        Download()
    }
    
    
    
    //"https://jsonplaceholder.typicode.com/users"
    func Download () {
        guard let url = jsonUrlString else
        {return}
        URLSession.shared.dataTask(with: url) { data, urlResponse, error in
            guard let data = data else {return print("belal")}
            
            do{
                
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                let dicArray = json as! [[String:Any]]
                for dic in dicArray{
                    
                    self.actors.append(Course2(ProvincesID: dic["ProvincesID"]! as! Any, ProvincesName: dic["ProvincesName"]! as! Any, ProvincesNameCustom: (dic["ProvincesNameCustom"]! as? Int)))
                }
                
                
                DispatchQueue.main.async {
                    self.Tabelview.reloadData()
                    self.RemoveLoadingScreen()
                }
                
                
            }
                
                
                
                
            catch let jsonErr {
                print("item")
            }
            
            
            
            }.resume()
        
        
        
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell:Cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! Cell else {
            return UITableViewCell()
        }
        
      
        return cell
    }
    
    
    private func setLoadingScreen(){
        
        self.Loading.style = UIActivityIndicatorView.Style.gray
        self.Loading.startAnimating()
        loadingView.addSubview(self.Loading)
        self.Tabelview.addSubview(loadingView)
        
        
        
    }
    
    private func RemoveLoadingScreen() {
        Loading.isHidden = true
        self.Loading.stopAnimating()
    }
    
}






//self.view.backgroundColor = UIColor(patternImage: UIImage(named: "techdrlogo")!)

/*  UIGraphicsBeginImageContext(self.view.frame.size)
 UIImage(named: "techdrlogo")?.draw(in: self.view.bounds)
 let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
 UIGraphicsEndImageContext()
 self.view.backgroundColor = UIColor(patternImage: image)
 
 
 guard let urlString =  URL( string : "http://smusers.promit2030.com/Service1.svc/GetProvincesReg") else {return}
 var urrrl = URLRequest(url: urlString)
 
 
 
 urrrl.httpMethod = "GET"
 
 URLSession.shared.dataTask(with: urrrl){(data, response, err) in guard let data = data  else { return
 print("items")}
 
 
 
 do {
 
 guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any]else{return}               //let courses = try JSONDecoder().decode([course].self, from: data)
 let course = Course(json: json)
 
 
 
 
 
 //Label.text = "\(course.ProvincesName)"
 print(course.ProvincesName)
 
 }
 catch let JosErr {
 
 print("Error serializing json",JosErr)
 }
 
 }.resume()
 
 
 
 /*
 
 let paramaters = ["username":"@kolo", "tweet":"halloworld"]
 
 
 guard let url  = URL( string: "http://smusers.promit2030.com/Service1.svc/GetProvincesReg?fbclid=IwAR2l92x4sNiv-1IuuEomHvhh3UHN2F5n7Zidqjf7EinG5xKL17dxYTtgr4E") else{return}
 
 var request = URLRequest(url: url)
 
 request.httpMethod = "GET"
 request.addValue("application/json", forHTTPHeaderField: "Content-Type")
 guard  let httpBody = try? JSONSerialization.data(withJSONObject: paramaters , options: []) else {return}
 request.httpBody = httpBody
 
 
 
 let session = URLSession.shared
 session.dataTask(with: request) {(data, response, error ) in
 if let response = response {
 print(response)
 }
 if let data = data {
 
 
 do {
 let json = try JSONSerialization.jsonObject(with: data, options:[])
 print(json)
 }catch{
 
 print(error)
 }
 }
 }.resume() */
 }
 
 }
 
 /* var outputStr = ""
 guard let url = URL(string: "http://smusers.promit2030.com/Service1.svc/GetProvincesReg?fbclid=IwAR2l92x4sNiv-1IuuEomHvhh3UHN2F5n7Zidqjf7EinG5xKL17dxYTtgr4E")else{return}
 
 let session = URLSession.shared
 session.dataTask(with: url) { (data, response, error) in
 if let response = response {
 print(response)
 }
 if let data = data {
 print(data)
 do {
 let json = try JSONSerialization.jsonObject(with: data, options: [])
 print(json)
 }catch{
 print(error)
 }
 }
 
 }.resume()
 
 /*  guard let url = URL(string: urlstring) else {return}
 URLSession.shared.dataTask(with: url){(data, responds, err) in
 guard let data = data else {return}
 
 
 
 do {
 let docoder = JSONDecoder()
 let courses = try docoder.decode([course].self, from: data)
 
 
 // outputStr += "Id: \(courses.id) "
 //  outputStr += "name: " + courses.name + "\n"
 //   outputStr += "nameCustom: " + courses.nameCustom + "\n"
 outputStr = courses.description
 print(courses)
 
 
 DispatchQueue.main.sync {
 self.Laout!.text = outputStr
 }
 
 
 
 }catch let Err {
 print("Error \(Err)")
 }
 
 }//.resume()
 */
 
 
 //   self.dismiss(animated: true, completion: nil)
 
 
 
 
 /* var url : String = "http://smusers.promit2030.com/Service1.svc/GetProvincesReg?fbclid=IwAR2l92x4sNiv-1IuuEomHvhh3UHN2F5n7Zidqjf7EinG5xKL17dxYTtgr4E"
 var request : NSMutableURLRequest = NSMutableURLRequest()
 request.url = NSURL(string: url)! as URL
 request.httpMethod = "GET"
 
 NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue(), completionHandler:{ (response:URLResponse!, data: NSData!, error: NSError!) -> Void in
 var error: AutoreleasingUnsafeMutablePointer<NSError?> = nil
 let jsonResult: NSDictionary! = NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.MutableContainers, error: error) as? NSDictionary
 
 if (jsonResult != nil) {
 // process jsonResult
 } else {
 // couldn't load JSON, look at error
 }
 
 
 }) */
 */
 */

