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
    var backButtonLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Today", style: .plain, target: self, action: #selector(MonthViewController.todayTapped))

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
        self.title = string
    }
    
    func addCalendars() {
        let frame = CGRect(x: 0.0, y: 20.0, width: view.frame.size.width, height: view.frame.size.height)
        viewCalendarMonth = MonthCalendarView(frame: frame)
//        viewCalendarMonth?.yearCalendarViewProtocol = self
        viewCalendarMonth?.date = DateManager.shared().currentDate
        view.addSubview(viewCalendarMonth!)
    }
    
    @objc func todayTapped() {
        DateManager.shared().setCurrentDate(_currentDate: Date.dateWithYear(year: Date.componentsOfCurrentDate().year!, month: Date.componentsOfCurrentDate().month!, day: Date.componentsOfCurrentDate().day!))
    }
    
    func showMonthCalendar() {
        updateLabelWithMonthAndYear()
    }

}
