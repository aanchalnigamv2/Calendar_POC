//
//  MonthCollectionViewFlowLayout.swift
//  Calendar_POC
//
//  Created by aanchal on 15/03/18.
//  Copyright © 2018 aanchal. All rights reserved.
//

import UIKit

class MonthCollectionViewFlowLayout: UICollectionViewFlowLayout {

    var yearCollectionViewContentSize: CGSize {
        return CGSize(width: (collectionView?.frame.size.width)!, height: 3*(collectionView?.frame.size.height)!)
    }
    
}
