//
//  WeekHeaderCollectionView.swift
//  Calendar_POC
//
//  Created by aanchal on 26/03/18.
//  Copyright © 2018 aanchal. All rights reserved.
//

import UIKit


protocol WeekHeaderCollectionViewProtocol: NSObjectProtocol {
    func headerDidScroll()
    func showHourLine(_ show: Bool)
}

class WeekHeaderCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate {

    var lastContentOffset: CGFloat = 0.0
    var isPrevious: Bool?
    var isNext: Bool?
    var weekHeaderCollectionViewProtocol: WeekHeaderCollectionViewProtocol?
    
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.dataSource = self
        self.delegate = self
        
        self.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        
        register(WeekCell.self, forCellWithReuseIdentifier: "monthCell")
        
        isScrollEnabled = true
        isPagingEnabled = true
        
        autoresizingMask = .flexibleWidth
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - UICollectionView DataSource
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let day = 7 * ((DateManager.shared().currentDate?.numberOfWeekInMonthCount())! + 2)
        return day
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var comp: DateComponents = Date.componentsOf(date: DateManager.shared().currentDate!)
        let dateFirstDayOfMonth = Date.dateWithYear(year: comp.year!, month: comp.month!, day: 1)
        var componentsFirstDayOfMonth: DateComponents = Date.componentsOf(date: dateFirstDayOfMonth)
        let dateOfLabel = Date.dateWithYear(year: comp.year!, month: comp.month!, day: 1 + indexPath.row - ((componentsFirstDayOfMonth.weekday)! - 1) - 7)
        var compDateOfLabel: DateComponents = Date.componentsOf(date: dateOfLabel)
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "monthCell", for: indexPath) as? WeekHeaderCell
        cell?.cleanCell()
        cell?.date = dateOfLabel
        cell?.label?.text = "\(arrayWeekAbrev[(compDateOfLabel.weekday!) - 1]), \(compDateOfLabel.day!)"
        if compDateOfLabel.weekday == 1 || compDateOfLabel.weekday == 7 {
            cell?.label?.textColor = UIColor.gray
        }
        if Date.isTheSameDateTheCompA(compDateOfLabel, compB: Date.componentsOfCurrentDate()) {
            cell?.imageView?.image = UIImage(named: "redCircle")
            cell?.label?.textColor = UIColor.white
        }
        return cell!
    }
    
    // MARK: - UICollectionView Delegate FlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.size.width / 7, height: frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // MARK: - UIScrollView Delegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if weekHeaderCollectionViewProtocol != nil {
            weekHeaderCollectionViewProtocol?.headerDidScroll()
        }
        if !(isPrevious! && scrollView.contentOffset.x < 0) {
            isPrevious = true
        }
        if !(isNext! && scrollView.contentOffset.x > CGFloat((DateManager.shared().currentDate?.numberOfWeekInMonthCount())! - 1) * scrollView.frame.size.width) {
            isNext = true
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        lastContentOffset = scrollView.contentOffset.x
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var comp: DateComponents? = Date.componentsOf(date: DateManager.shared().currentDate!)
        var scrollDirection = ScrollDirection(rawValue: 0)
        if lastContentOffset > scrollView.contentOffset.x || isPrevious! {
            scrollDirection = ScrollDirection.right
            comp?.day! -= 7
        }
        else if lastContentOffset < scrollView.contentOffset.x || isNext! {
            scrollDirection = ScrollDirection.left
            comp?.day! += 7
        }
        else {
            scrollDirection = ScrollDirection.none
        }
        
        DateManager.shared().currentDate = Date.dateWithYear(year: (comp?.year)!, month: (comp?.month)!, day: (comp?.day)!)
        
        isPrevious = false
        isNext = false
    }
    
}
