//
//  YearCalendarView.swift
//  Calendar
//
//  Created by Aanchal Nigam on 04/03/18.
//  Copyright © 2018 v2solutions. All rights reserved.
//

import UIKit

protocol YearCalendarViewProtocol: NSObjectProtocol {
    func showMonthCalendar()
}

class YearCalendarView: UIView, YearCollectionViewProtocol {

    var collectionViewYear: YearCollectionView?
    var yearCalendarViewProtocol: YearCalendarViewProtocol?
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Initialization code
        
        NotificationCenter.default.addObserver(self, selector: #selector(YearCalendarView.dateChanged(_:)), name: NSNotification.Name(rawValue: "DateManager.DateChanged"), object: nil)

        backgroundColor = UIColor.white
        collectionViewYear = YearCollectionView(frame: CGRect(x: 10, y: 60, width: self.frame.size.width - 2 * 10, height: self.frame.size.height - 2 * 10), collectionViewLayout: YearCollectionViewFlowLayout())
        collectionViewYear?.yearCollectionViewProtocol = self
        addSubview(collectionViewYear!)
        autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionViewYear?.autoresizingMask = [.flexibleHeight, .flexibleWidth, .flexibleTopMargin, .flexibleBottomMargin]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Invalidate Layout
    func invalidateLayout() {
        collectionViewYear?.collectionViewLayout.invalidateLayout()
    }
    
    // MARK: - FFDateManager Notification
    @objc func dateChanged(_ not: Notification) {
        collectionViewYear?.setContentOffset(CGPoint(x: 0.0, y: (collectionViewYear?.frame.size.height)! - 40), animated: false)
        collectionViewYear?.reloadData()
    }
    
    // MARK: - YearCollectionView Protocol
    func showMonthCalendar() {
        if yearCalendarViewProtocol != nil && (yearCalendarViewProtocol?.responds(to: Selector(("showMonthCalendar"))))! {
            yearCalendarViewProtocol?.showMonthCalendar()
        }
    }
    
}
