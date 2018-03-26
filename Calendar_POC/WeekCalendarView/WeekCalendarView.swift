//
//  WeekCalendarView.swift
//  Calendar_POC
//
//  Created by aanchal on 26/03/18.
//  Copyright © 2018 aanchal. All rights reserved.
//

import UIKit

class WeekCalendarView: UIView {

    var weekHeaderCollectionView: WeekHeaderCollectionView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        NotificationCenter.default.addObserver(self, selector: #selector(WeekCalendarView.dateChanged(_:)), name: NSNotification.Name(rawValue: "DateManager.DateChanged"), object: nil)
        
        backgroundColor = UIColor.white
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Invalidate Layout
    func invalidateLayout() {
        weekHeaderCollectionView?.collectionViewLayout.invalidateLayout()
        dateChanged(nil)
    }
    
    func setDictEvents(_ _dictEvents: [AnyHashable: Any]?) {
//        dictEvents = _dictEvents
        if !(weekHeaderCollectionView == nil) {
            let viewLeft = UIView(frame: CGRect(x: 0, y: 0, width: 80.0, height: 100))
            viewLeft.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
            addSubview(viewLeft)
            weekHeaderCollectionView = WeekHeaderCollectionView(frame: CGRect(x: viewLeft.frame.size.width, y: 0, width: frame.size.width - viewLeft.frame.size.width, height: 100))
            weekHeaderCollectionView?.weekHeaderCollectionViewProtocol = self as? WeekHeaderCollectionViewProtocol
            scroll(toPage: Int((Date.componentsOf(date: DateManager.shared().currentDate!).weekOfMonth)! + 1))
            addSubview(weekHeaderCollectionView!)
            
//            weekContainerScroll = WeekScrollView(frame: CGRect(x: 0, y: HEADER_HEIGHT_SCROLL, width: frame.size.width, height: frame.size.height - HEADER_HEIGHT_SCROLL))
//            addSubview(weekContainerScroll)
        }
//        weekContainerScroll.setDictEvents(dictEvents)
//        weekContainerScroll.collectionViewWeek.protocol = self
    }
    
    func scroll(toPage intPage: Int?) {
        let intIndex: Int = 7 * intPage! - 1
        weekHeaderCollectionView?.scrollToItem(at: IndexPath(item: intIndex, section: 0), at: .right, animated: false)
    }
    
    // MARK: - DateManager Notification
    @objc func dateChanged(_ notification: Notification?) {
        
    }
    
}
