//
//  HeaderMonthForYearCell.swift
//  Calendar
//
//  Created by Aanchal Nigam on 04/03/18.
//  Copyright © 2018 v2solutions. All rights reserved.
//

import UIKit

class HeaderMonthForYearCell: UICollectionReusableView {
    
    var date: Date?
    var labelTitle: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Initialization code
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Methods
    
    func addWeekLabels(withSizeOfCells sizeOfCells: CGSize) {
        if !(labelTitle != nil) {
            let height: CGFloat = frame.size.height / 4.0
            labelTitle = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: frame.size.width, height: 3 * height))
            labelTitle?.textColor = UIColor.red
            labelTitle?.font = UIFont.systemFont(ofSize: 13)
            addSubview(labelTitle!)
            for i in 0..<arrayWeekAbrev.count {
                let label = UILabel(frame: CGRect(x: CGFloat(i) * sizeOfCells.width, y: (labelTitle?.frame.size.height)!, width: sizeOfCells.width, height: height))
                label.textAlignment = .center
                label.text = arrayWeekAbrev[i]
                label.textColor = UIColor.black
                label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize - 10)
                addSubview(label)
            }
        }
        labelTitle?.text = arrayMonthName[(date?.componentsOfDate().month)! - 1].uppercased()
    }
}
