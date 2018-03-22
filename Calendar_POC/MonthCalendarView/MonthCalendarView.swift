//
//  MonthCalendarView.swift
//  Calendar_POC
//
//  Created by aanchal on 16/03/18.
//  Copyright © 2018 aanchal. All rights reserved.
//

import UIKit

class MonthCalendarView: UIView {

    var collectionViewMonth: MonthCollectionView?
    var date: Date?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        NotificationCenter.default.addObserver(self, selector: #selector(YearCalendarView.dateChanged(_:)), name: NSNotification.Name(rawValue: "DateManager.DateChanged"), object: nil)
        
        backgroundColor = UIColor.white
        
        collectionViewMonth = MonthCollectionView(frame: CGRect(x: 0.0, y: 32.0, width: frame.size.width, height: frame.size.height - 32), collectionViewLayout: UICollectionViewLayout())
//        collectionViewMonth.protocol = self
        collectionViewMonth?.date = DateManager.shared().currentDate
        addSubview(collectionViewMonth!)
        autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionViewMonth?.autoresizingMask = [.flexibleHeight, .flexibleWidth, .flexibleTopMargin, .flexibleBottomMargin]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Invalidate Layout
    func invalidateLayout() {
        collectionViewMonth?.collectionViewLayout.invalidateLayout()
        collectionViewMonth?.reloadData()
    }
    
    // MARK: - DateManager Notification
    @objc func dateChanged(_ not: Notification) {
        collectionViewMonth?.setContentOffset(CGPoint(x: 0.0, y: (collectionViewMonth?.frame.size.height)!), animated: false)
        collectionViewMonth?.reloadData()
    }
    
}
