//
//  CellHistory.swift
//  Doctor
//
//  Created by TECH VALLEY on 3/9/19.
//  Copyright © 2019 belal.saber. All rights reserved.
//

import UIKit
protocol TableViewHistory {
    func OnClickCell(index: Int)
}
class CellHistory: UITableViewCell {
    var CellDeleget: TableViewHistory?
    var index: IndexPath?
    @IBOutlet weak var LaAmount: UILabel!
    @IBOutlet weak var LaStutas: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    var button1 : UIButton {
        let button1 = UIButton(type: .system)
        button1.setTitle("ملخص الزياره", for: .normal)
        button1.setTitleColor(.black, for: .normal)
        button1.backgroundColor = .yellow
        
        button1.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button1.addTarget(self, action: #selector(handleExpand), for: .touchUpInside)
        return button1
    }
    @objc func handleExpand() {
        print("Hallo")
    }
    
    @IBAction func DedelsCome(_ sender: Any) {
        CellDeleget?.OnClickCell(index: (index?.row)!)
       
    }
}
