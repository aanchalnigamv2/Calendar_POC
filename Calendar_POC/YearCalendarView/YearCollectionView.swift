//
//  YearCollectionView.swift
//  Calendar
//
//  Created by Aanchal Nigam on 04/03/18.
//  Copyright © 2018 v2solutions. All rights reserved.
//

import UIKit

protocol YearCollectionViewProtocol: NSObjectProtocol {
    func showMonthCalendar()
}

enum ScrollDirection : Int {
    case none
    case right
    case left
    case up
    case down
    case crazy
}

class YearCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, YearCellProtocol {
    
    var yearCollectionViewProtocol: YearCollectionViewProtocol?
    var lastContentOffset: CGFloat = 0.0
    var sizeOfCell: CGSize?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: YearCollectionViewFlowLayout())
        
        // Initialization code
        backgroundColor = UIColor.white
        dataSource = self
        delegate = self
        register(YearCell.self, forCellWithReuseIdentifier: "monthCell")
        isScrollEnabled = true
        isPagingEnabled = true
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
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "monthCell", for: indexPath) as? YearCell
        cell?.initLayout()
        cell?.setDate(aDate: Date.dateWithYear(year: (DateManager.shared().currentDate?.componentsOfDate().year)! + (indexPath.section-1), month: (indexPath.row + 1), day: 1))
        return cell!
    }
    
    // MARK: - UICollectionView Delegate FlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let isLandscape: Bool = UIInterfaceOrientationIsLandscape(UIApplication.shared.statusBarOrientation)
        let lines: Int = isLandscape ? 3 : 4
        let columns: Int = isLandscape ? 4 : 3
        sizeOfCell = CGSize(width: CGFloat(((frame.size.width - CGFloat((columns - 1) * 20)) / CGFloat(columns))), height: CGFloat(((frame.size.height - CGFloat((lines - 1) * 13)) / CGFloat(lines))))
        return sizeOfCell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
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
        let scrollDirection: ScrollDirection?
        if lastContentOffset > scrollView.contentOffset.y {
            changeYear(false)
        }else if lastContentOffset < scrollView.contentOffset.y {
            changeYear(true)
        }else {
            scrollDirection = ScrollDirection.none
        }
    }

    
    // MARK: - UICollectionView Delegate
    func showMonthCalendar() {
        if yearCollectionViewProtocol != nil && (yearCollectionViewProtocol?.responds(to: Selector(("showMonthCalendar"))))! {
            yearCollectionViewProtocol?.showMonthCalendar()
        }
    }
    
    // MARK: - Other Methods
    func changeYear(_ isUp: Bool) {
        var dateComponents = DateComponents()
        dateComponents.year = isUp ? 1 : -1
        let calendar = Calendar.current
        let newDate: Date = calendar.date(byAdding: dateComponents, to: DateManager.shared().currentDate!)!
        DateManager.shared().setCurrentDate(_currentDate: newDate)
    }

}
