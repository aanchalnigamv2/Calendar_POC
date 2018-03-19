//
//  MonthViewController.swift
//  Calendar_POC
//
//  Created by aanchal on 15/03/18.
//  Copyright © 2018 aanchal. All rights reserved.
//

import UIKit

class MonthViewController: UIViewController, YearCalendarViewProtocol {

    var viewCalendarMonth: MonthCalendarView?
    var date: Date?
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(MonthViewController.dateChanged(_:)), name: NSNotification.Name(rawValue: "DateManager.DateChanged"), object: nil)
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
        let string: String = String(describing: "\(arrayMonthName[(comp?.month)! - 1]) \((comp?.year)!)")
        print(string)
        
//        labelWithMonthAndYear.title = string
//        labelWithMonthAndYear.tintColor = UIColor.red
    }
    
    func addCalendars() {
        let frame = CGRect(x: 0.0, y: 0.0, width: view.frame.size.width, height: view.frame.size.height)
        viewCalendarMonth = MonthCalendarView(frame: frame)
//        viewCalendarMonth?.yearCalendarViewProtocol = self
        view.addSubview(viewCalendarMonth!)
    }
    
    func showMonthCalendar() {
        updateLabelWithMonthAndYear()
    }

}
