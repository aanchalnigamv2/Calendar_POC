//
//  MonthHeaderView.swift
//  Calendar_POC
//
//  Created by aanchal on 20/03/18.
//  Copyright © 2018 aanchal. All rights reserved.
//

import UIKit

class MonthHeaderView: UICollectionReusableView {

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        headerLabel.textColor = UIColor.black
    }
    
}
