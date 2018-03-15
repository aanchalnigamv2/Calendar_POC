//
//  MonthCollectionViewForYearCell.swift
//  Calendar
//
//  Created by Aanchal Nigam on 24/02/18.
//  Copyright © 2018 v2solutions. All rights reserved.
//

import UIKit

protocol MonthCollectionViewForYearCellProtocol: NSObjectProtocol {
    func showMonthCalendar()
}

class MonthCollectionViewForYearCell: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var date: Date?
    var cellProtocol: MonthCollectionViewForYearCellProtocol?
    var sizeOfCells = CGSize.zero
    var arrayDates: [Date?] = []
    var dateFirstDayOfMonth: Date?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: UICollectionViewFlowLayout())
        
        // Initialization code
        isUserInteractionEnabled = true
        dataSource = self
        delegate = self
        backgroundColor = UIColor.white
        isScrollEnabled = false
        register(MonthCellForYearCell.self, forCellWithReuseIdentifier: "monthCell")
        register(HeaderMonthForYearCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerCollection")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UICollectionView DataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if arrayDates.count > 0 {
            arrayDates.removeAll()
            
        }
        var compDateManeger: DateComponents? = Date.componentsOf(date: date!)
        
        dateFirstDayOfMonth = Date.dateWithYear(year: (compDateManeger?.year)!, month: (compDateManeger?.month)!, day: 1)
        
        var componentsFirstDayOfMonth: DateComponents? = Date.componentsOf(date: dateFirstDayOfMonth!)
        
        let lastDayMonth: Int = dateFirstDayOfMonth!.numberOfDaysInMonthCount()
        
        let numOfCellsInCollection: Int = dateFirstDayOfMonth!.numberOfWeekInMonthCount() * 7
        
        var i = 1 - ((componentsFirstDayOfMonth?.weekday)! - 1), j = numOfCellsInCollection - ((componentsFirstDayOfMonth?.weekday)! - 1)
        while i <= j {
            if (i >= 1 && i <= lastDayMonth) {
                let date = Date.dateWithYear(year: (compDateManeger?.year)!, month: (compDateManeger?.month)!, day: i)
                arrayDates.append(date)
            }else {
                arrayDates.append(nil)
            }
            i += 1
        }
        
        sizeOfCells = CGSize(width: frame.size.width / 7, height: (frame.size.height - 50) / 7)
        //(((frame.size.height - 50.0) / 6)))
        return arrayDates.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "monthCell", for: indexPath) as? MonthCellForYearCell
        cell?.initLayout()
        cell?.setDay(aDay: arrayDates[indexPath.row])
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var reusableview: UICollectionReusableView?
        if kind == UICollectionElementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerCollection", for: indexPath) as? HeaderMonthForYearCell
            headerView?.date = date
            headerView?.addWeekLabels(withSizeOfCells: sizeOfCells)
            reusableview = headerView
        }
        return reusableview!
    }
    
    // MARK: - UICollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let obj = arrayDates[indexPath.row]
        if obj != nil && cellProtocol != nil && cellProtocol!.responds(to: Selector(("showMonthCalendar"))) {
            DateManager.shared().currentDate = obj
            cellProtocol?.showMonthCalendar()
        }
    }

    // MARK: - UICollectionView Delegate FlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return sizeOfCells
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let headerViewSize = CGSize(width: frame.size.width, height: 50.0)
        return headerViewSize
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

}
