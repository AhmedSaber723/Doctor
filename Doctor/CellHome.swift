//
//  Cell.swift
//  Doctor
//
//  Created by TECH VALLEY on 2/26/19.
//  Copyright © 2019 belal.saber. All rights reserved.
//

import UIKit


protocol TableViewHome {
    func OnClickCell(index: Int)
}

@IBDesignable extension UIView {

@IBInspectable var CornerRadius: CGFloat {
    set {
        layer.cornerRadius = newValue
    }
    get {
        return layer.cornerRadius
    }
  }   
}
class Cell: UITableViewCell {
   
    @IBOutlet weak var LaName: UILabel!
    var CellDeleget: TableViewHome?
    var index: IndexPath?
    @IBOutlet weak var LaPhone: UILabel!
    
    @IBOutlet var Stutas: UILabel!
    @IBOutlet var PatianID: UILabel!
    @IBOutlet var ReStutas: UILabel!
    
    @IBOutlet var PatianName: UILabel!
    @IBOutlet var PatianNumber: UILabel!
    @IBOutlet var Data: UILabel!
    @IBOutlet var StillAmount: UILabel!
    
    @IBOutlet var BackView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func CallPatian(_ sender: Any) {
        
    }
    @IBAction func Dataa(_ sender: Any) {
        
        
    }
    
    @IBAction func BuPatianData(_ sender: Any) {
        CellDeleget?.OnClickCell(index: (index?.row)!)
        
        
    }
}
