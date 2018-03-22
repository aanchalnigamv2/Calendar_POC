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
    var weekdayOfFirstDay: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: - Custom Methods
    
    func addWeekLabels(withSizeOfCells sizeOfCells: CGSize) {
        if !(labelTitle != nil) {
            let layout = MonthCollectionViewFlowLayout()
            let height: CGFloat = frame.size.height / 4.0
            labelTitle = UILabel(frame: CGRect(x: CGFloat(weekdayOfFirstDay!) * (layout.itemSize.width), y: 0.0, width: frame.size.width, height: 3 * height))
            labelTitle?.textColor = UIColor.red
            labelTitle?.font = UIFont.boldSystemFont(ofSize: 15)
            addSubview(labelTitle!)
        }

        labelTitle?.text = arrayMonthNameAbrev[(date?.componentsOfDate().month)! - 1].uppercased()
    }
    
}
