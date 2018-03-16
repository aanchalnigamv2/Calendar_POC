//
//  MonthHeaderView.swift
//  Calendar_POC
//
//  Created by aanchal on 16/03/18.
//  Copyright © 2018 aanchal. All rights reserved.
//

import UIKit

class MonthHeaderView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        var arrayColor: [UIColor?] = [UIColor.gray, UIColor.black, UIColor.black, UIColor.black, UIColor.black, UIColor.black, UIColor.gray]
        let width = CGFloat(((frame.size.width - 6 * 2) / 7.0))
        
        for i in 0..<arrayWeekAbrev.count {
            let label = UILabel(frame: CGRect(x: CGFloat(i) * (width + 2), y: 0.0, width: width - 5.0, height: frame.size.height))
            label.textAlignment = .right
            label.text = arrayWeekAbrev[i]
            if let aI = arrayColor[i] {
                label.textColor = aI
            }
            label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize)
            label.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin, .flexibleWidth]
            addSubview(label)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
