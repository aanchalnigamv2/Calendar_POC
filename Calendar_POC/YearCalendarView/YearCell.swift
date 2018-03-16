//
//  YearCell.swift
//  Calendar
//
//  Created by Aanchal Nigam on 04/03/18.
//  Copyright © 2018 v2solutions. All rights reserved.
//

import UIKit

protocol YearCellProtocol: NSObjectProtocol {
    func showMonthCalendar()
}

class YearCell: UICollectionViewCell, MonthCollectionViewForYearCellProtocol {
    
    var date: Date?
    var yearCellProtocol: YearCellProtocol?
    var collectionView: MonthCollectionViewForYearCell?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initLayout() {
        if collectionView == nil {
            collectionView = MonthCollectionViewForYearCell(frame: CGRect(x: 0.0, y: 0.0, width: frame.size.width, height: frame.size.height), collectionViewLayout: UICollectionViewLayout())
            collectionView?.cellProtocol = self
            addSubview(collectionView!)
        }
    }
    
    func setDate(aDate: Date) {
        date = aDate
        collectionView?.date = aDate
        collectionView?.reloadData()
    }

    // MARK: - MonthCollectionViewForYearCell Protocol
    func showMonthCalendar() {
        if yearCellProtocol != nil  {
            yearCellProtocol?.showMonthCalendar()
        }
    }
    
    //&& (yearCellProtocol?.responds(to: Selector(("showMonthCalendar"))))!
}
