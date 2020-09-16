//
//  ExpandableHeaderViewDelegate.swift
//  Doctor
//
//  Created by TECH VALLEY on 3/14/19.
//  Copyright © 2019 belal.saber. All rights reserved.
//

import UIKit
import ObjectiveC
protocol ExpandableHeaderViewDelegate {
    func toggleSection(header: ExpandableHeaderView, section: Int)
}

class ExpandableHeaderView: UITableViewHeaderFooterView {

    var delegate : ExpandableHeaderViewDelegate?
    var section: Int!
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectHeaderAction)))
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func selectHeaderAction(gestureRecognizer: UITapGestureRecognizer){
        let cell = gestureRecognizer.view as! ExpandableHeaderView
        delegate?.toggleSection(header: self, section: cell.section)
        
    }
    func customInit(title: String, section: Int, delegate: ExpandableHeaderViewDelegate) {
        self.textLabel?.text = title
        
        self.section = section
        self.delegate = delegate
    }
    let screen = UIScreen.main.bounds.size
    override func layoutSubviews() {
        super.layoutSubviews()
       self.textLabel?.textAlignment = .right
        self.textLabel?.textColor = #colorLiteral(red: 1, green: 0.8298398852, blue: 0.2543682456, alpha: 1)
        self.contentView.backgroundColor = #colorLiteral(red: 0.254067603, green: 0.2553074867, blue: 0.2533522999, alpha: 1)
        self.contentView.frame = CGRect(x: 15, y: 15, width: screen.width - 30 , height: 40)
        self.contentView.layer.cornerRadius = 10
        
        
    }
}
