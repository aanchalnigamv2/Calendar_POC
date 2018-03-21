//
//  MonthCollectionView.swift
//  Calendar_POC
//
//  Created by aanchal on 15/03/18.
//  Copyright © 2018 aanchal. All rights reserved.
//

import UIKit

class MonthCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var date: Date?
    var sizeOfCells = CGSize.zero
    var arrayDates: [Date?] = []
    var dateFirstDayOfMonth: Date?
    var lastContentOffset: CGFloat = 0.0
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: UICollectionViewFlowLayout())
        
        // Initialization code
        dataSource = self
        delegate = self
        backgroundColor = UIColor.white
        register(MonthCell.self, forCellWithReuseIdentifier: "monthCell")
        register(MonthHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerView")
        isScrollEnabled = true
        showsVerticalScrollIndicator = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - UICollectionView DataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
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
        
        sizeOfCells = CGSize(width: bounds.size.width / 7, height: 40)
        return arrayDates.count
        
//        let sizeOfCells = CGSize(width: bounds.size.width / 7, height: 40)
//        //CGSize(width: (frame.size.width - 7 * 2) / 7, height: (frame.size.height - CGFloat(dateFirstDayOfMonth.numberOfWeekInMonthCount() - 1) * 2 - 2) / CGFloat(dateFirstDayOfMonth.numberOfWeekInMonthCount()))
//
//        arraySizeOfCells[section] = NSValue(cgSize: sizeOfCells) as! CGSize
//
//        return arrayDates.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "monthCell", for: indexPath) as? MonthCell
        cell?.initLayout()
//        cell?.protocol = self
        cell?.setDay(aDay: arrayDates[indexPath.row])
        
        if indexPath.row % 7 == 0 || (indexPath.row + 1) % 7 == 0 {
            cell?.markAsWeekend()
        }
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var reusableview: UICollectionReusableView?
        if kind == UICollectionElementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerView", for: indexPath) as? MonthHeaderView
            headerView?.date = date
            headerView?.addWeekLabels(withSizeOfCells: sizeOfCells)
            reusableview = headerView
        }
        return reusableview!
    }
    
    
    // MARK: - UICollectionView Delegate FlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return sizeOfCells
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let headerViewSize = CGSize(width: frame.size.width, height: 20)
        return headerViewSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // MARK: - UIScrollView Delegate
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
            scrollView.contentOffset.y = frame.size.height
        }
        lastContentOffset = scrollView.contentOffset.y
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var scrollDirection: ScrollDirection
        if lastContentOffset > scrollView.contentOffset.y {
            changeYearDirectionIsUp(false)
        }
        else if lastContentOffset < scrollView.contentOffset.y {
            changeYearDirectionIsUp(true)
        }
        else {
            scrollDirection = .none
        }
    }
    
    // MARK: - Other Methods
    func changeYearDirectionIsUp(_ isUp: Bool) {
        var dateComponents = DateComponents()
        dateComponents.month = isUp ? 1 : -1
        let calendar = Calendar.current
        let newDate: Date? = calendar.date(byAdding: dateComponents, to: DateManager.shared().currentDate!)
        DateManager.shared().setCurrentDate(_currentDate: newDate!)
    }
    
}
