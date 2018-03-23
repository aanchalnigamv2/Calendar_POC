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
        
        var arrayColor: [Any] = ([UIColor.gray, UIColor.black, UIColor.black, UIColor.black, UIColor.black, UIColor.black, UIColor.gray])
        let width = CGFloat(((frame.size.width - 6 * 2) / 7.0))
        for i in 0..<arrayWeekAbrev.count {
            let label = UILabel(frame: CGRect(x: CGFloat(i) * (width + 2), y: 0.0, width: width - 5.0, height: frame.size.height - 5))
            label.textAlignment = .right
            label.text = arrayWeekAbrev[i]
            if let anI = arrayColor[i] as? UIColor {
                label.textColor = anI
            }
            label.font = UIFont(name: "Helvetica Neue", size: label.font.pointSize) //systemFont(ofSize: label.font.pointSize)
            label.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin, .flexibleWidth]
            addSubview(label)
        }
        
//        if !(labelTitle != nil) {
//            let layout = MonthCollectionViewFlowLayout()
//            let height: CGFloat = frame.size.height / 4.0
//            labelTitle = UILabel(frame: CGRect(x: CGFloat(weekdayOfFirstDay!) * (layout.itemSize.width), y: 0.0, width: frame.size.width, height: 3 * height))
//            labelTitle?.textColor = UIColor.red
//            labelTitle?.font = UIFont.boldSystemFont(ofSize: 15)
//            addSubview(labelTitle!)
//        }
//
//        labelTitle?.text = arrayMonthNameAbrev[(date?.componentsOfDate().month)! - 1].uppercased()
    }
    
}
