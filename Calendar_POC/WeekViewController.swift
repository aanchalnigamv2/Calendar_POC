//
//  WeekViewController.swift
//  Calendar_POC
//
//  Created by aanchal on 26/03/18.
//  Copyright © 2018 aanchal. All rights reserved.
//

import UIKit

class WeekViewController: UIViewController {

    var viewCalendarWeek: WeekCalendarView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(WeekViewController.dateChanged(_:)), name: NSNotification.Name(rawValue: "DateManager.DateChanged"), object: nil)
        edgesForExtendedLayout = []
        addCalendars()
        updateLabelWithMonthAndYear()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - DateManager Notification
    @objc func dateChanged(_ notification: Notification) {
        updateLabelWithMonthAndYear()
    }
    
    func updateLabelWithMonthAndYear() {
        let comp: DateComponents? = Date.componentsOf(date: DateManager.shared().currentDate!)
        let string = String(describing: (comp?.year)!)

    }
    
    func addCalendars() {
        let frame = CGRect(x: 0.0, y: 0.0, width: view.frame.size.width, height: view.frame.size.height)
        viewCalendarWeek = WeekCalendarView(frame: frame)
//        viewCalendarWeek?.yearCalendarViewProtocol = self
        view.addSubview(viewCalendarWeek!)
    }


}
