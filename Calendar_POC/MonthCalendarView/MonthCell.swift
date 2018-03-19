//
//  MonthCell.swift
//  Calendar_POC
//
//  Created by aanchal on 15/03/18.
//  Copyright © 2018 aanchal. All rights reserved.
//

import UIKit

class MonthCell: UICollectionViewCell {
    
    var imageViewCircle: UIImageView?
    var labelDay: UILabel?
    var arrayButtons: [UIButton] = []
    var day: Date?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initLayout() {
        if !(imageViewCircle != nil) {
            imageViewCircle = UIImageView(frame: CGRect(x: frame.size.width - 32.0 - 3.0, y: 3.0, width: 32.0, height: 32.0))
            imageViewCircle?.autoresizingMask = [.flexibleLeftMargin, .flexibleBottomMargin]
            addSubview(imageViewCircle!)
            
            labelDay = UILabel(frame: CGRect(x: ((imageViewCircle?.frame.size.width)! - 20.0) / 2.0, y: ((imageViewCircle?.frame.size.height)! - 20.0) / 2.0, width: 20.0, height: 20.0))
            labelDay?.autoresizingMask = [.flexibleLeftMargin, .flexibleBottomMargin]
            labelDay?.textAlignment = .center
            labelDay?.font = UIFont.systemFont(ofSize: 13)
            imageViewCircle?.addSubview(labelDay!)
        }
        backgroundColor = UIColor.white
        labelDay?.text = ""
        labelDay?.textColor = UIColor.black
        
        imageViewCircle?.image = nil
        for button: UIButton in arrayButtons {
            button.removeFromSuperview()
        }
    }
    
    func markAsCurrentDay() {
        labelDay?.textColor = UIColor.white
        imageViewCircle?.image = UIImage(named: "redCircle")
    }
    
    func markAsWeekend() {
        labelDay?.textColor = UIColor.gray
//        backgroundColor = UIColor.lightGray
    }
    
    func setDay(aDay: Date?) {
        day = aDay
        if day != nil {
            var components: DateComponents? = Date.componentsOf(date: day!)
            labelDay?.text = String(describing: (components?.day)!)
            labelDay?.font = UIFont.systemFont(ofSize: 13)
            if Date.isTheSameDateTheCompA(components!, compB: Date.componentsOfCurrentDate()) {
                markAsCurrentDay()
            }
        }
    }
}
