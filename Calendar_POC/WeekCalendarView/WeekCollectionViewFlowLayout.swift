//
//  WeekCollectionViewFlowLayout.swift
//  Calendar_POC
//
//  Created by aanchal on 26/03/18.
//  Copyright © 2018 aanchal. All rights reserved.
//

import UIKit

class WeekCollectionViewFlowLayout: UICollectionViewFlowLayout {

    override init() {
        super.init()
        self.scrollDirection = .horizontal
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var yearCollectionViewContentSize: CGSize {
        return CGSize(width: (CGFloat((DateManager.shared().currentDate?.numberOfWeekInMonthCount())!) + 2) * (collectionView?.frame.size.width)!, height: collectionView?.frame.size.height ?? 0.0)
    }
}
