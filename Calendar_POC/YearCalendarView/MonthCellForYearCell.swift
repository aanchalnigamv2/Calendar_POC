//
//  MonthCellForYearCell.swift
//  Calendar
//
//  Created by Aanchal Nigam on 24/02/18.
//  Copyright © 2018 v2solutions. All rights reserved.
//

import UIKit

class MonthCellForYearCell: UICollectionViewCell {
    
    var imageViewCircle: UIImageView?
    var labelDay: UILabel?
    var day: Date?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initLayout() {
        if !(labelDay != nil) {
            imageViewCircle = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: frame.size.width, height: frame.size.height))
            imageViewCircle?.contentMode = .scaleAspectFit
            addSubview(imageViewCircle!)
            labelDay = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: frame.size.width, height: frame.size.height))
            labelDay?.textAlignment = .center
            addSubview(labelDay!)
        }
        labelDay?.text = ""
        labelDay?.textColor = UIColor.black
        imageViewCircle?.image = nil
    }
    
    func setDate() {
        if day != nil {
            var components: DateComponents? = Date.componentsOf(date: day!)
            labelDay?.text = String(describing: (components?.day)!)
            labelDay?.font = UIFont.systemFont(ofSize: 10)
            if Date.isTheSameDateTheCompA(components!, compB: Date.componentsOfCurrentDate()) {
                markAsCurrentDay()
            }
        }
    }
    
    func markAsCurrentDay() {
        labelDay?.textColor = UIColor.white
        imageViewCircle?.image = UIImage(named: "redCircle")
    }
}
