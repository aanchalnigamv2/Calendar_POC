//
//  MonthViewController.swift
//  Calendar_POC
//
//  Created by aanchal on 15/03/18.
//  Copyright © 2018 aanchal. All rights reserved.
//

import UIKit

class MonthViewController: UIViewController, YearCalendarViewProtocol {

    var viewCalendarYear: YearCalendarView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(YearViewController.dateChanged(_:)), name: NSNotification.Name(rawValue: "DateManager.DateChanged"), object: nil)
        edgesForExtendedLayout = []
        addCalendars()
        updateLabelWithMonthAndYear()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - FFDateManager Notification
    @objc func dateChanged(_ notification: Notification) {
        updateLabelWithMonthAndYear()
    }
    
    func updateLabelWithMonthAndYear() {
        let comp: DateComponents? = Date.componentsOf(date: DateManager.shared().currentDate!)
        let string: String = String(describing: (comp?.year)!)
//        labelWithMonthAndYear.title = string
//        labelWithMonthAndYear.tintColor = UIColor.red
    }
    
    func addCalendars() {
        let frame = CGRect(x: 0.0, y: 0.0, width: view.frame.size.width, height: view.frame.size.height)
        viewCalendarYear = YearCalendarView(frame: frame)
        viewCalendarYear?.yearCalendarViewProtocol = self
        view.addSubview(viewCalendarYear!)
    }
    
    func showMonthCalendar() {
        updateLabelWithMonthAndYear()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
