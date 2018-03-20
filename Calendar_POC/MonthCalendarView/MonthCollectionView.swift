//
//  MonthCollectionView.swift
//  Calendar_POC
//
//  Created by aanchal on 15/03/18.
//  Copyright © 2018 aanchal. All rights reserved.
//

import UIKit

class MonthCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    var arrayDates: [Date?] = []
    var arraySizeOfCells: [CGSize] = []
    var arrayWithFirstDay: [Date?] = []
    var lastContentOffset: CGFloat = 0.0
    var weekdayOfFirstDay: Int = 0
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: UICollectionViewFlowLayout())
        
        // Initialization code
        dataSource = self
        delegate = self
        backgroundColor = UIColor.white
        register(MonthCell.self, forCellWithReuseIdentifier: "monthCell")
        register(MonthHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerView")
        isScrollEnabled = true
//        isPagingEnabled = true
        showsVerticalScrollIndicator = false
//        array = [[Date](), [Date](), [Date]()]
        arraySizeOfCells = [NSValue(cgSize: CGSize.zero) as! CGSize, NSValue(cgSize: CGSize.zero) as! CGSize, NSValue(cgSize: CGSize.zero) as! CGSize]
        arrayWithFirstDay = [Date(), Date(), Date()]
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
        var compDateManager: DateComponents = Date.componentsOf(date: DateManager.shared().currentDate!)
        
        compDateManager.month! += section - 1 
        
        let dateFirstDayOfMonth = Date.dateWithYear(year: compDateManager.year!, month: compDateManager.month!, day: 1)
        
        arrayWithFirstDay[section] = dateFirstDayOfMonth
        
        var componentsFirstDayOfMonth: DateComponents = Date.componentsOf(date: dateFirstDayOfMonth)
        
        print("Weekday:\(Int(componentsFirstDayOfMonth.weekday!))")
        
        weekdayOfFirstDay = Int(componentsFirstDayOfMonth.weekday!)
        
        let lastDayMonth: Int = dateFirstDayOfMonth.numberOfDaysInMonthCount()
        let numOfCellsInCollection: Int = dateFirstDayOfMonth.numberOfWeekInMonthCount() * 7
        
        var i = 1 - ((componentsFirstDayOfMonth.weekday)! - 1), j = numOfCellsInCollection - ((componentsFirstDayOfMonth.weekday)! - 1)
        while i <= j {
            if (i >= 1 && i <= lastDayMonth) {
                let date = Date.dateWithYear(year: (compDateManager.year)!, month: (compDateManager.month)!, day: i)
                arrayDates.append(date)
            }else {
                arrayDates.append(nil)
            }
            i += 1
        }
        
        let sizeOfCells = CGSize(width: bounds.size.width / 7, height: 40)
        //CGSize(width: (frame.size.width - 7 * 2) / 7, height: (frame.size.height - CGFloat(dateFirstDayOfMonth.numberOfWeekInMonthCount() - 1) * 2 - 2) / CGFloat(dateFirstDayOfMonth.numberOfWeekInMonthCount()))
        
        arraySizeOfCells[section] = NSValue(cgSize: sizeOfCells) as! CGSize

        return arrayDates.count
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
            
            var compDateManager: DateComponents = Date.componentsOf(date: DateManager.shared().currentDate!)
            
            compDateManager.month! += indexPath.section - 1
            
            let dateFirstDayOfMonth = Date.dateWithYear(year: compDateManager.year!, month: compDateManager.month!, day: 1)
            
            arrayWithFirstDay[indexPath.section] = dateFirstDayOfMonth
            
            var componentsFirstDayOfMonth: DateComponents = Date.componentsOf(date: dateFirstDayOfMonth)
            
            print("Weekday:\(Int(componentsFirstDayOfMonth.weekday!))")
            
            weekdayOfFirstDay = Int(componentsFirstDayOfMonth.weekday!)
            
            let formatter = DateFormatter()
            let month: String? = formatter.shortMonthSymbols[compDateManager.month!].uppercased()
            headerView?.headerLabel?.text = String(month!)
            let layout = MonthCollectionViewFlowLayout()
            let labelOffset: CGFloat = CGFloat(weekdayOfFirstDay) * (layout.itemSize.width) + 6.0
            headerView?.leadingConstraint?.constant = labelOffset
            
            reusableview = headerView
        }
        return reusableview!
    }
    
    
    // MARK: - UICollectionView Delegate FlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return NSValue(cgSize: arraySizeOfCells[indexPath.section]) as! CGSize
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
        let newDate: Date? = calendar.date(byAdding: dateComponents, to: arrayWithFirstDay[1]!)
        DateManager.shared().currentDate = newDate
    }
    
}
