//
//  YearCollectionViewFlowLayout.swift
//  Calendar
//
//  Created by Aanchal Nigam on 04/03/18.
//  Copyright © 2018 v2solutions. All rights reserved.
//

import UIKit

class YearCollectionViewFlowLayout: UICollectionViewFlowLayout {

    var yearCollectionViewContentSize: CGSize {
        return CGSize(width: (collectionView?.frame.size.width)!, height: 3*(collectionView?.frame.size.height)!)
    }
}
