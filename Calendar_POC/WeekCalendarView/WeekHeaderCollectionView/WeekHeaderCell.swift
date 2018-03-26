//
//  WeekHeaderCell.swift
//  Calendar_POC
//
//  Created by aanchal on 26/03/18.
//  Copyright © 2018 aanchal. All rights reserved.
//

import UIKit

class WeekHeaderCell: UICollectionViewCell {
    
    var label: UILabel?
    var imageView: UIImageView?
    var date: Date?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: frame.size.width, height: frame.size.height))
        imageView?.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin]
        imageView?.contentMode = .center
        addSubview(imageView!)
        
        label = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: frame.size.width, height: frame.size.height))
        label?.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin]
        label?.contentMode = .center
        addSubview(label!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cleanCell() {
        imageView = nil
        label?.text = ""
        label?.textColor = UIColor.black
        date = nil
    }
}
