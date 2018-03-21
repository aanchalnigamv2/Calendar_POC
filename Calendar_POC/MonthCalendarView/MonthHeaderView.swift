//
//  MonthHeaderView.swift
//  Calendar_POC
//
//  Created by aanchal on 20/03/18.
//  Copyright © 2018 aanchal. All rights reserved.
//

import UIKit

class MonthHeaderView: UICollectionReusableView {

    var labelTitle: UILabel?
    var date: Date?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: - Custom Methods
    
    func addWeekLabels(withSizeOfCells sizeOfCells: CGSize) {
        if !(labelTitle != nil) {
            let height: CGFloat = frame.size.height / 4.0
            labelTitle = UILabel(frame: CGRect(x: frame.size.width / 2, y: 0.0, width: frame.size.width, height: 3 * height))
            labelTitle?.textColor = UIColor.red
            labelTitle?.font = UIFont.systemFont(ofSize: 13)
            addSubview(labelTitle!)
        }
        labelTitle?.text = arrayMonthName[(date?.componentsOfDate().month)! - 1].uppercased()
    }
    
}
