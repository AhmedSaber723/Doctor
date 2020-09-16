//
//  Expand.swift
//  Doctor
//
//  Created by TECH VALLEY on 3/14/19.
//  Copyright © 2019 belal.saber. All rights reserved.
//

import UIKit

protocol HeaderDelegat {
    func CellHeader(idx: Int)
}
class HeaderView: UIView {
    var delegat: HeaderDelegat?
    var secIndex: Int?
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        self.addSubview(btn)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("Error")
    }
    lazy var btn: UIButton = {
        let btn = UIButton(frame: CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.width, height: self.frame.height))
        btn.backgroundColor = #colorLiteral(red: 0.254067603, green: 0.2553074867, blue: 0.2533522999, alpha: 1)
        btn.titleLabel?.textColor = UIColor.yellow
        btn.addTarget(self, action: #selector(onClickHeaderView), for: .touchUpInside)
        return btn
    }()
    @objc func onClickHeaderView() {
        if let idx = secIndex{
            delegat?.CellHeader(idx: idx)
        }
    }
}
